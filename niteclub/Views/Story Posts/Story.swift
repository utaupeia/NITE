//
//  Story.swift
//  niteclub
//
//  Created by +++ on 1/8/24.
//

import Foundation
import Combine
import SwiftUI

enum StoryType {
    case image
    case video
}

struct StoryPost: Identifiable {
    let id: UUID
    let author: User
    let media: StoryType
    var imageUrl: String? // URL or name of the image
    var videoUrl: String? // URL of the video
    var duration: TimeInterval // For images, default 6 seconds
    let timePosted: Date
    var viewed: [User] // Users who viewed the post
    var likes: [User] // Users who liked the post
    var replies: [Reply] // Replies to the post
    var isCloseFriendPost: Bool

    init(author: User, media: StoryType, imageUrl: String? = nil, videoUrl: String? = nil, duration:TimeInterval, timePosted: Date, isCloseFriendPost: Bool = false) {
        self.id = UUID()
        self.author = author
        self.media = media
        self.imageUrl = imageUrl
        self.videoUrl = videoUrl
        self.duration = duration
        self.timePosted = timePosted
        self.viewed = []
        self.likes = []
        self.replies = []
        self.isCloseFriendPost = isCloseFriendPost
        self.duration = media == .image ? 6 : 0 // Set default duration for images
    }

    // Convenience method to get view count
    var viewCount: Int {
        viewed.count
    }

    // Convenience method to get like count
    var likeCount: Int {
        likes.count
    }
}


struct Story: Identifiable {
    let id: UUID
    let author: User
    var storyPosts: [StoryPost]
    var currentIndex: Int = 0 {
        didSet {
            print("currentIndex updated to: \(currentIndex)")
        }
    }

    init(author: User, storyPosts: [StoryPost]) {
        self.id = UUID()  // Unique identifier for each story
        self.author = author
        self.storyPosts = storyPosts
    }
}

struct Reply: Identifiable {
    let id: UUID
    let user: User // The user who made the reply
    let message: String // The reply message
    let timePosted: Date

    init(user: User, message: String, timePosted: Date) {
        self.id = UUID()
        self.user = user
        self.message = message
        self.timePosted = timePosted
    }
}

class StoryPostViewModel: ObservableObject {
    @Published var storyPost: StoryPost

    init(storyPost: StoryPost) {
        self.storyPost = storyPost
    }

    func toggleViewedBy(user: User) {
        if let index = storyPost.viewed.firstIndex(where: { $0.id == user.id }) {
            storyPost.viewed.remove(at: index)
        } else {
            storyPost.viewed.append(user)
        }
    }

    func toggleLikeBy(user: User) {
        if let index = storyPost.likes.firstIndex(where: { $0.id == user.id }) {
            storyPost.likes.remove(at: index)
        } else {
            storyPost.likes.append(user)
        }
    }

    func addReply(_ reply: Reply) {
        storyPost.replies.append(reply)
    }
    
    var isExpired: Bool {
        let expirationPeriod: TimeInterval = 2 * 60 * 60 // 2 hours in seconds
        let expirationTime = storyPost.timePosted.addingTimeInterval(expirationPeriod)
        return Date() >= expirationTime
    }
    var remainingTimeText: String {
        let expirationPeriod: TimeInterval = 2 * 60 * 60 // 2 hours in seconds
        let expirationTime = storyPost.timePosted.addingTimeInterval(expirationPeriod)
        let remainingTime = expirationTime.timeIntervalSinceNow

        if remainingTime > 0 {
            return formatTimeInterval(remainingTime)
        } else {
            return "Expired"
        }
    }

    private func formatTimeInterval(_ interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60 % 60
        let seconds = Int(interval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

}


class StoryViewModel: ObservableObject, Identifiable {
    let id: UUID  // Add this line
    @Published var story: Story
    @Published var refreshTrigger = false
    @Published var viewedPostsCount = 0
    var storyPostViewModels: [StoryPostViewModel]
    weak var storiesViewModel: StoriesViewModel?
    @Published var currentIndex: Int = 0
    var currentUser: User // This will now be initialized
    @Published var progressArray: [Double]
    // Timer for progress bar
    var progressTimer: Timer?
    var progressTimers: [UUID: Timer] = [:]

    // Callback to inform when to move to the next story
    var moveToNextStory: (() -> Void)?
    var onLastPost: (() -> Void)?
    var onFirstPost: (() -> Void)?

    init(story: Story, currentUser: User, storiesViewModel: StoriesViewModel) {
        self.id = story.id
        self.story = story
        self.currentUser = currentUser
        self.storiesViewModel = storiesViewModel
        self.storyPostViewModels = story.storyPosts.map { StoryPostViewModel(storyPost: $0) }
        self.progressArray = Array(repeating: 0.0, count: story.storyPosts.count)
        self.currentIndex = 0

    }
    
    func indexForPost(_ postVM: StoryPostViewModel) -> Int {
        return storyPostViewModels.firstIndex(where: { $0.storyPost.id == postVM.storyPost.id }) ?? 0
    }
    
    var remainingTimeForCurrentPost: String {
        guard currentIndex < storyPostViewModels.count else {
            return "Invalid Post"
        }

        let currentPost = storyPostViewModels[currentIndex].storyPost
        let expirationPeriod: TimeInterval = 2 * 60 * 60 // 2 hours in seconds
        let expirationTime = currentPost.timePosted.addingTimeInterval(expirationPeriod)
        let remainingTime = expirationTime.timeIntervalSinceNow

        if remainingTime > 0 {
            return formatTime(remainingTime)
        } else {
            return "Expired"
        }
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60

        if hours > 0 {
            return "\(hours):\(String(format: "%02d", minutes))"
        } else {
            return "\(minutes)m"
        }
    }

    func moveToNextPost() {
        if currentIndex < storyPostViewModels.count - 1 {
            currentIndex += 1
            startProgressForCurrentPost() // Start progress for the new current post
        } else {
            onLastPost?() // Handle the last post scenario
        }
    }
    
    func advanceToNextUnviewedPost() {
        DispatchQueue.main.async {
            let nextIndex = self.allPostsViewed() ? 0 : self.firstUnviewedPostIndex()
            self.currentIndex = nextIndex
            print("Advanced to next unviewed post: Index \(nextIndex) for Story ID: \(self.id)")
        }
    }

    func moveToPreviousPost() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
//        resetAndStartProgressForCurrentPost()
    }
    
    func allPostsViewed() -> Bool {
        return storyPostViewModels.allSatisfy { $0.storyPost.viewed.contains(currentUser) }
    }
    func completeAllProgress() {
        for index in storyPostViewModels.indices {
            // Set the progress of each post to complete
            progressArray[index] = 1.0
        }
        // Notify the view of the changes
        objectWillChange.send()
    }

//    private func completeProgressForCurrentPost() {
//        let currentPostId = storyPostViewModels[currentIndex].storyPost.id
//        // Fast-forward progress to complete
//        progressArray[currentIndex] = 1.0
//        // Invalidate the timer for the current post
//        progressTimers[currentPostId]?.invalidate()
//    }

    
    func startProgressForCurrentPost() {
        progressTimer?.invalidate()
        progressArray[currentIndex] = 0.0

        let currentPostDuration = storyPostViewModels[currentIndex].storyPost.duration
        progressTimer = Timer.scheduledTimer(withTimeInterval: currentPostDuration / 100, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.progressArray[self.currentIndex] < 1.0 {
                self.progressArray[self.currentIndex] += 0.01
            } else {
                self.progressTimer?.invalidate()
                if self.currentIndex < self.storyPostViewModels.count - 1 {
                    // Automatically move to the next post when progress completes
                    self.moveToNextPost()
                } else {
                    // If it's the last post of the story, handle accordingly
                    self.onLastPost?()
                }
            }
        }
    }
    
    func completeProgressForCurrentPost() {
        // Check if currentIndex is valid
        if currentIndex >= 0 && currentIndex < storyPostViewModels.count {
            progressArray[currentIndex] = 1.0 // Set progress to 100%
            progressTimer?.invalidate() // Stop the progress timer for the current post
            objectWillChange.send() // Notify the view of the change
        }
        print("Progress for post at index \(currentIndex) completed.")

    }
//    func completeProgressForCurrentPost() {
//        if currentIndex >= 0 && currentIndex < storyPostViewModels.count {
//            // Set the progress of the current post to complete
//            progressArray[currentIndex] = 1.0
//            // Invalidate and remove any existing timer for the current post
//            let currentPostId = storyPostViewModels[currentIndex].storyPost.id
//            progressTimers[currentPostId]?.invalidate()
//            // Notify the view of the change
//            objectWillChange.send()
//        }
//    }
 
    func fastForwardProgress() {
        // Invalidate the current timer and set progress to complete
        progressTimer?.invalidate()
        progressArray[currentIndex] = 1.0

        // Move to the next post immediately
        moveToNextPost()
    }


    func resetAndStartProgressForCurrentPost() {
        // Invalidate and remove any existing timer for the current post
        progressTimers.values.forEach { $0.invalidate() }

        // Reset progress to full for all posts in the story
        progressArray = Array(repeating: 0.0, count: storyPostViewModels.count)
        currentIndex = 0 // Start from the first post
        startProgressForCurrentPost()
    }

    func markPostAsViewed(_ post: StoryPost) {
        if let index = story.storyPosts.firstIndex(where: { $0.id == post.id }), !story.storyPosts[index].viewed.contains(currentUser) {
            story.storyPosts[index].viewed.append(currentUser)
            storyPostViewModels[index].storyPost.viewed.append(currentUser)
            viewedPostsCount += 1  // Increment to trigger view update
            print("Marked as viewed: \(post.id), currentIndex: \(currentIndex)")
        }
    }


    func updateIndexAfterClosingExpanded() {
        // Check if the current post was the last one
        if currentIndex >= storyPostViewModels.count - 1 {
            currentIndex = 0
        } else {
            // Set currentIndex to the next unviewed post or to the first post
            currentIndex = firstUnviewedPostIndex()
        }
    }
    
    func handleClosingExpandedView() {
        // Ensure currentIndex is within the bounds of the array
        if currentIndex >= 0 && currentIndex < storyPostViewModels.count {
            let currentPost = storyPostViewModels[currentIndex].storyPost
            if currentPost.viewed.contains(currentUser) {
                // Find the next unviewed post or reset to the first post
                currentIndex = firstUnviewedPostIndex()
                print("Updated currentIndex after closing: \(currentIndex)")

            }
        } else {
            // Handle any cases where currentIndex is out of bounds if necessary
        }
    }

    func updateToNextUnviewedPost() {
        if allPostsViewed() {
            currentIndex = 0
        } else {
            currentIndex = firstUnviewedPostIndex()
        }
        print("updateToNextUnviewedPost called, currentIndex updated to: \(currentIndex)")
    }
    
    func firstUnviewedPostIndex() -> Int {
        return storyPostViewModels.firstIndex(where: { !$0.storyPost.viewed.contains(currentUser) }) ?? 0
    }
    
    private func updateCurrentIndex() {
        if allPostsViewed() {
            currentIndex = 0
        } else {
            currentIndex = firstUnviewedPostIndex()
        }
        print("Updated currentIndex to \(currentIndex)")
    }

    private func updateCurrentIndexAfterViewingPost() {
        if allPostsViewed() {
            currentIndex = 0 // Reset to the first post if all posts are viewed
        } else {
            currentIndex = firstUnviewedPostIndex() // Update to next unviewed post
        }
        print("Updated currentIndex: \(currentIndex)")
    }

    func firstUnviewedPostViewModel() -> StoryPostViewModel {
        let firstUnviewedIndex = firstUnviewedPostIndex()
        return storyPostViewModels[firstUnviewedIndex]
    }


    // Call this method when a post becomes the current post
    func startProgressForPost(at index: Int) {
        // Reset progress for the current post
        progressArray[index] = 0.0

        // Example timer logic to update progress
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.progressArray[index] += 0.1
            if self.progressArray[index] >= 1.0 {
                timer.invalidate()
                // Optionally, move to next post
            }
        }
    }

    private func resetProgress() {
        progressTimer?.invalidate()
        progressArray[currentIndex] = 0.0
    }

    private func stopCurrentTimer() {
        let currentPostId = storyPostViewModels[currentIndex].storyPost.id
        progressTimers[currentPostId]?.invalidate()
    }

    private func updateProgress(postId: UUID) {
        guard let index = storyPostViewModels.firstIndex(where: { $0.storyPost.id == postId }) else { return }
        if progressArray[index] < 1.0 {
            progressArray[index] += 0.01
        } else {
            moveToNextPost()
        }
    }
    

    // Additional methods as needed
}

class StoriesViewModel: ObservableObject {
    @Published var stories: [StoryViewModel]
    @Published var refreshTrigger = false
    @Published var currentStoryIndex: Int = 0
    var currentUser: User

    init(stories: [Story], currentUser: User) {
        self.currentUser = currentUser

        // Step 1: Initialize stories with an empty array
        self.stories = [] // Initialize as empty

        // Step 2: Properly set up each StoryViewModel
        for story in stories {
            let storyVM = StoryViewModel(story: story, currentUser: currentUser, storiesViewModel: self)
            self.stories.append(storyVM)
        }

        for index in self.stories.indices {
            self.stories[index].onFirstPost = { [weak self] in
                self?.moveToPreviousStory()
            }
        }
        for index in self.stories.indices {
            self.stories[index].onLastPost = { [weak self] in
                guard let self = self else { return }
                if self.currentStoryIndex < self.stories.count - 1 {
                    self.currentStoryIndex += 1
                    self.stories[self.currentStoryIndex].currentIndex = 0 // Start from first post of the next story
                    self.stories[self.currentStoryIndex].startProgressForCurrentPost()
                }
            }
        }
    }
    
    func refreshView() {
        // Simplest way is to toggle a published property
        self.refreshTrigger.toggle()
    }

    func moveToPreviousStory() {
        if currentStoryIndex > 0 {
            currentStoryIndex -= 1
        } else {
            // Optional: Handle the scenario when it's the first story.
            // For example, do nothing or wrap around to the last story:
            // currentStoryIndex = stories.count - 1
        }
    }
    
    func moveToNextStory() {
        print("Current story index before increment: \(currentStoryIndex)")

        if currentStoryIndex < stories.count - 1 {
            currentStoryIndex += 1
        } else {
            print("Last story reached. Consider looping or stopping.")
        }

        // Make sure the first post of the next story is shown
        stories[currentStoryIndex].currentIndex = 0
    }
    

    func advanceToNextStoryAfterViewing(currentViewModel: StoryViewModel) {
        currentViewModel.advanceToNextUnviewedPost()
        refreshTrigger.toggle() // Trigger a view update
    }
    
    func handleClosingStoryView(currentViewModel: StoryViewModel) {
        currentViewModel.advanceToNextUnviewedPost()
        refreshTrigger.toggle() // Trigger a view update
        
    }

    private func handlePostVisibility(for index: Int) {
        let storyVM = stories[index]
        // Implement logic to show first unseen post or first post
        storyVM.currentIndex = storyVM.firstUnviewedPostIndex()
    }

    func firstUnviewedPostIndex(for storyIndex: Int) -> Int {
        // Assuming that 'stories' is an array of 'StoryViewModel'
        guard storyIndex < stories.count else { return 0 }

        let storyVM = stories[storyIndex]
        return storyVM.firstUnviewedPostIndex()
    }


    func selectStory(at index: Int) {
        guard index < stories.count else { return }
        currentStoryIndex = index
        // Reset the progress of the selected story
        stories[index].currentIndex = 0
        stories[index].resetAndStartProgressForCurrentPost()
    }


}




extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
