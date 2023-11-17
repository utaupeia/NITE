//
//  StoryViewModel.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import SwiftUI
import Combine

class StoryViewModel: ObservableObject {
    
    @Published var currentStoryGroup: StoryGroup?
    @Published var currentStory: StoryItem?
    @Published var allStoryGroups: [StoryGroup] = SampleData.allStoryGroups
    @Published var isExpanded: Bool = false
    private var currentGroupIndex: Int = 0
    private var currentStoryIndex: Int = 0
    private var storyTimer: Timer?
    private var currentUser: User // Assuming this is set somewhere

    var onEndOfStories: (() -> Void)?

        // ... existing methods ...

        init(currentUser: User) {
            self.currentUser = currentUser
            loadDummyData()
            
            loadFirstUnseenStory()

        }
    

        func loadDummyData() {
            // ... existing dummy data loading logic ...

            // Filter out expired stories
            allStoryGroups = allStoryGroups.map { group in
                let filteredStories = group.stories.filter { !$0.isExpired() }
                return StoryGroup(user: group.user, stories: filteredStories)
            }

            // Set the initial current story group and story
            setCurrentStoryGroup()
        }
    
    func loadFirstUnseenStory() {
        // Find the first unseen story
        for (groupIndex, group) in allStoryGroups.enumerated() {
            if let storyIndex = group.stories.firstIndex(where: { !$0.seen }) {
                currentGroupIndex = groupIndex
                currentStoryIndex = storyIndex
                currentStory = group.stories[storyIndex]
                return
            }
        }
        currentStory = nil // No unseen stories
    }

    
    private func restartTimer() {
        guard let currentStory = currentStory else { return }
        
        storyTimer?.invalidate()
        storyTimer = Timer.scheduledTimer(withTimeInterval: currentStory.duration, repeats: false) { [weak self] _ in
            self?.nextStory()
        }
    }
    
    func selectStoryGroup(_ selectedGroup: StoryGroup) {
        if let groupIndex = allStoryGroups.firstIndex(where: { $0.id == selectedGroup.id }) {
            currentGroupIndex = groupIndex
            // Find the index of the first unseen story, or start from 0 if all are seen
            currentStoryIndex = selectedGroup.stories.firstIndex(where: { !$0.seen }) ?? 0
            setCurrentStoryGroup()
            isExpanded = true // Ensure the story view is expanded
        }
    }
    
    private func setCurrentStoryGroup() {
        if currentGroupIndex < allStoryGroups.count {
            let group = allStoryGroups[currentGroupIndex]
            if currentStoryIndex < group.stories.count {
                currentStoryGroup = group
                currentStory = group.stories[currentStoryIndex]
                restartTimer()
            }
        } else {
            currentStoryGroup = nil
            currentStory = nil
        }
    }

    func nextStory() {
        // Increment story index or move to the next group if at the end of the current group
        if currentStoryIndex < allStoryGroups[currentGroupIndex].stories.count - 1 {
            currentStoryIndex += 1
        } else if currentGroupIndex < allStoryGroups.count - 1 {
            currentGroupIndex += 1
            currentStoryIndex = 0
        } else {
            // Handle the case where we are at the end of all stories
            // Option: Loop back to the start or simply return
            print("Reached the end of all stories")
            return
        }
        
        if currentGroupIndex >= allStoryGroups.count - 1 &&
           currentStoryIndex >= allStoryGroups[currentGroupIndex].stories.count - 1 {
            // Reached the end of all stories
            withAnimation {
                isExpanded = false
            }
            
        }
        // Check if we've reached the end of all stories
        if currentGroupIndex >= allStoryGroups.count - 1 &&
           currentStoryIndex >= allStoryGroups[currentGroupIndex].stories.count - 1 {
            // Call the closure
            onEndOfStories?()
        }



        currentStory = allStoryGroups[currentGroupIndex].stories[currentStoryIndex]
        print("Moved to next story: GroupIndex: \(currentGroupIndex), StoryIndex: \(currentStoryIndex)")
    }

    func previousStory() {
        // Decrement story index or move to the previous group if at the start of the current group
        if currentStoryIndex > 0 {
            currentStoryIndex -= 1
        } else if currentGroupIndex > 0 {
            currentGroupIndex -= 1
            currentStoryIndex = allStoryGroups[currentGroupIndex].stories.count - 1
        } else {
            // Handle the case where we are at the beginning of all stories
            // Option: Loop back to the end or simply return
            print("At the beginning of all stories")
            return
        }

        currentStory = allStoryGroups[currentGroupIndex].stories[currentStoryIndex]
        print("Moved to previous story: GroupIndex: \(currentGroupIndex), StoryIndex: \(currentStoryIndex)")
    }


    
    func nextStoryGroup() {
        currentGroupIndex += 1
        setCurrentStoryGroup()
    }
    
    // ... existing restartTimer and viewDidDisappear methods ...
}

//class StoryViewModel: ObservableObject {
//    
//    @Published var currentStoryGroup: StoryGroup?
//    @Published var currentStory: StoryItem?
//    @Published var allStoryGroups: [StoryGroup] = [] // This should be populated with actual data
//    private var currentGroupIndex: Int = 0
//    private var currentStoryIndex: Int = 0
//    private var currentUser: User // The user who is viewing the stories
//
//    init(currentUser: User) {
//        self.currentUser = currentUser
//        loadStoryGroups()
//    }
//    
//
//        func loadDummyData() {
//            // ... existing dummy data loading logic ...
//
//            // Filter out expired stories
//            allStoryGroups = allStoryGroups.map { group in
//                let filteredStories = group.stories.filter { !$0.isExpired() }
//                return StoryGroup(user: group.user, stories: filteredStories)
//            }
//
//            // Set the initial current story group and story
//            setCurrentStoryGroup()
//        }
//    
//    func loadFirstUnseenStory() {
//        // Find the first unseen story
//        for (groupIndex, group) in allStoryGroups.enumerated() {
//            if let storyIndex = group.stories.firstIndex(where: { !$0.seen }) {
//                currentGroupIndex = groupIndex
//                currentStoryIndex = storyIndex
//                currentStory = group.stories[storyIndex]
//                return
//            }
//        }
//        currentStory = nil // No unseen stories
//    }
//    
//    private func loadStoryGroups() {
//        // Assuming 'SampleData.allStoryGroups' is accessible and contains the static data
//        allStoryGroups = SampleData.allStoryGroups.map { group in
//            let filteredStories = group.stories.filter { !$0.isExpired() }
//            return StoryGroup(user: group.user, stories: filteredStories)
//        }
//        setCurrentStoryGroup()
//        print("Loaded story groups: \(allStoryGroups.count)")
//    }
//
//    private func setCurrentStoryGroup() {
//        if currentGroupIndex < allStoryGroups.count {
//            currentStoryGroup = allStoryGroups[currentGroupIndex]
//            currentStory = currentStoryGroup?.currentStory(for: currentUser)
//        }
//    }
//
//    func nextStory() {
//        guard let group = currentStoryGroup else { return }
//
//        if group.currentIndex < group.stories.count - 1 {
//            // Move to the next story
//            group.nextStory()
//            currentStory = group.currentStory(for: currentUser)
//        } else if currentGroupIndex < allStoryGroups.count - 1 {
//            // Move to the next group
//            currentGroupIndex += 1
//            setCurrentStoryGroup()
//        }
//    }
//
//    func previousStory() {
//        guard let group = currentStoryGroup else { return }
//
//        if group.currentIndex > 0 {
//            // Move to the previous story within the current group
//            group.previousStory()
//            currentStory = group.currentStory(for: currentUser)
//        } else if currentGroupIndex > 0 {
//            // Move to the previous group
//            currentGroupIndex -= 1
//            currentStoryGroup = allStoryGroups[currentGroupIndex]
//            currentStoryGroup?.resetToLastStory()
//            currentStory = currentStoryGroup?.currentStory(for: currentUser)
//        }
//    }
//
//
////    
////    private func restartTimer() {
////        guard let currentStory = currentStory else { return }
////        
////        storyTimer?.invalidate()
////        storyTimer = Timer.scheduledTimer(withTimeInterval: currentStory.duration, repeats: false) { [weak self] _ in
////            self?.nextStory()
////        }
////    }
//
//    
//    func nextStoryGroup() {
//        currentGroupIndex += 1
//        setCurrentStoryGroup()
//    }
//    
//    // ... existing restartTimer and viewDidDisappear methods ...
//}
