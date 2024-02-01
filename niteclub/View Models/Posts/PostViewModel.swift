//
//  PostViewModel.swift
//  niteclub
//
//  Created by +++ on 10/23/23.
//

import Foundation

// Definition of the protocol
protocol PostViewModelProtocol {
    // Perhaps every post view model needs a method to fetch post data
    func fetchPostData()

    // Maybe there's a requirement for a property that holds the post's data
    var postData: Post { get set }

    // ... any other requirements ...
}

// MARK: is concerned with the state and logic of individual posts
class PostViewModel: ObservableObject, Identifiable {
    @Published var post: Post
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var isLikeCountVisible: Bool = false
    @Published var isLikesListVisible: Bool = false
    
    var videoPlayerViewModel: VideoPlayerViewModel?

    var currentUser: User
    var quotingUser: User?  // This property will be nil for regular posts and will have a value only for quoted posts.
    
    // Each PostViewModel represents one Post, so the ID should be derived from the post
    var id: UUID { post.id }
    
    // Initializer
    init(post: Post, currentUser: User, quotingUser: User? = nil) {
        self.post = post
        self.currentUser = currentUser
        self.quotingUser = quotingUser
        
        if let videoURLString = post.videos?.first, let videoURL = URL(string: videoURLString) {
            self.videoPlayerViewModel = VideoPlayerViewModel(videoURL: videoURL)
        }

    }
    
    // Check if the current user is the post creator
    func isPostCreator() -> Bool {
        return post.author.id == currentUser.id
    }
    
    // Check if the user is a member or a forever member
    func isUserMemberOrForeverMember() -> Bool {
        return currentUser.status == .member || currentUser.status == .foreverMember
    }
    
    // Common functionalities for all posts
    func likePost() {
        // Prevent the post creator from liking their own post
        guard post.author.id != currentUser.id else { return }
        
        // Check if the current user has already liked the post
        if !isPostLikedByCurrentUser() {
            post.socialInteractions.likes.append(currentUser)
        }
    }

    func handleLikeButtonTapNonAuthor() {
        guard !isPostCreator() else { return }
        
        likePost()
        // Delay showing the like count
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.isLikeCountVisible = true
        }
    }
        // Handle like count tap for members or forever members
        func handleLikeCountTapForMember() {
            if isUserMemberOrForeverMember() {
                isLikesListVisible.toggle()
            }
        }
        
        // Handle like count tap for post creator
        func handleLikeCountTapForAuthor() {
            if isPostCreator() {
                isLikesListVisible.toggle()
            }
        }
        
        // Handle like count tap
        func handleLikeCountTap() {
            if isUserMemberOrForeverMember() {
                isLikesListVisible.toggle()
            }
        }
    
    //testing
    func toggleUserStatus(forTesting status: UserStatus) {
        currentUser.status = status
    }

    func togglePostCreator(forTesting isCreator: Bool) {
        if isCreator {
            // Make the currentUser the author of the post
            post.author = currentUser
        } else {
            // Set the author to a different user
            post.author = User(id: UUID(), username: "Different User", profilePicture: "", following: [], followers: [], lurking: 0, status: .default, acquiredThemes: [], selectedTheme: sampleTheme, dateJoined: Date(), location: "")
        }
    }

        // PICTURES
        func loadImages() {
            // Logic to load images (if they are not immediately loaded into the post)
        }
        
        // VIDEO
        func loadVideos() {
            // logic to load videos (if they are not immediately loaded into the post)
        }
        
        func playVideo() {
            // Logic to play video
        }
        
        func pauseVideo() {
            // Logic to pause video
        }
        
        var time: String {
            // time since user posted
            TimeSinceFormatter.timeSince(from: post.timestamp)
        }
                
        func isPostLikedByCurrentUser() -> Bool {
            post.socialInteractions.likes.contains(where: { $0.id == currentUser.id })
        }
        
        var likesCount: Int {
            post.socialInteractions.likes.count
        }
        
        func getLikes() -> [User] {
            // Here, you might sort the likes, fetch additional data about the users, etc.
            return post.socialInteractions.likes
        }
    
    // Determine if this post is a repost
    var isRepost: Bool {
        // Your logic here, maybe check if the post's author is not the current user but is in the user's reposts
        return post.socialInteractions.reposts.contains { $0.id == currentUser.id }
    }

    // Determine if this post is a quote
    var isQuote: Bool {
        // This is a simple check, and you might need more sophisticated logic
        return post.socialInteractions.quotes.contains { $0.quotingUser.id == currentUser.id }
    }

        func repostPost(by user: User) {
            // Now we have the 'user' who reposts the post, and we can append it to the 'reposts' array
            post.socialInteractions.reposts.append(user)
        }
        
        func getReposts() -> [User] {
            // Similar to likes, prepare the data as needed for your views.
            return post.socialInteractions.reposts
        }
        
        func commentOnPost(text: String, by user: User) {
            // Create a new comment instance. The 'author' and 'text' fields are set based on the function's parameters.
            let newComment = Comment(author: user, text: text, timestamp: Date()) // 'id' and 'replies' will use default values from the Comment's initializer
            
            // Add the new comment to the post's array of comments.
            post.socialInteractions.comments.append(newComment)
        }
        
        func getComments() -> [Comment] {
            // You might sort comments by timestamp, handle pagination if there are many comments, etc.
            return post.socialInteractions.comments
        }
        
        func quotePost(quoteText: String, by user: User) {
            // Create a new quote instance. This represents the user's new post, which is a quote of the original post.
            let newQuote = Quote(post: self.post, quotingUser: user, quoteText: quoteText, timestamp: Date()) // 'id' will use the default value from the Quote's initializer
            
            // Add the new quote to the post's array of quotes.
            post.socialInteractions.quotes.append(newQuote)
        }
        
        func getQuotes() -> [Quote] {
            // You might sort quotes by timestamp, handle pagination if there are many quotes, etc.
            return post.socialInteractions.quotes
        }
        
        func sharePost() {
            // Logic for sharing a post via Direct Message
        }
        
        func reportPost() {
            // Logic for reporting a post, which might involve calling a service to report the post
        }
        
        func deletePost() {
            // Logic for deleting a post, which might involve calling a service to remove the post
            // from the database or server, and then removing it from any post lists in the UI
        }
        
        // Hypothetical function that could be part of your setup or init
        func observePostChanges() {
            // Set up listeners for your post, for example, using Firebase Realtime Database or
            // any other real-time data service, and update your post model accordingly.
        }
        
        // ... more common functionalities ...
    }

// MARK: manages a collection of posts and overall state like the selected user profile
class PostsViewModel: ObservableObject {
    @Published var postViewModels: [PostViewModel] = []
    @Published var selectedUser: User?  // The user whose profile is selected
    @Published var userViewModel = UserViewModel()

    init() {
        // Initialize postViewModels
        // Replace this with your actual data fetching logic
        let currentUser = getCurrentUser()
        let posts = SampleData.allPosts // Replace with your method to fetch posts
        self.postViewModels = posts.map { PostViewModel(post: $0, currentUser: currentUser) }
    }


    func selectUser(_ user: User) {
        selectedUser = user
        userViewModel.setUserByID(user.id)
        userViewModel.user = user

    }
    func getCurrentUser() -> User {
        // Your logic to get the current user goes here
        // For simplicity, returning a dummy user
        return User(id: UUID(), username: "CurrentUser", profilePicture: "", following: [], followers: [], status: .default, acquiredThemes: [], selectedTheme: Theme(id: UUID(), name: "Sample Theme", content: ThemeContent(id: UUID(), themeURL: "image9"), price: 0.0, creationDate: Date(), approved: true), dateJoined: Date(), location: "")
    }

    var textPostViewModels: [PostViewModel] {
        postViewModels.filter {
            $0.post.textContent != nil && ($0.post.images?.isEmpty ?? true) && ($0.post.videos?.isEmpty ?? true)
        }
    }

    var imagePostViewModels: [PostViewModel] {
        postViewModels.filter {
            !($0.post.images?.isEmpty ?? true)
        }
    }
    

    var videoPostViewModels: [PostViewModel] {
        postViewModels.filter {
            !($0.post.videos?.isEmpty ?? true)
        }
    }
}


