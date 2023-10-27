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



class PostViewModel: ObservableObject, Identifiable {
    @Published var post: Post
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // Each PostViewModel represents one Post, so the ID should be derived from the post
    var id: UUID { post.id }

    // Initializer
    init(post: Post) {
        self.post = post
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

    // Common functionalities for all posts
    func likePost(by user: User) {
        // Now we have the 'user' who likes the post, and we can append it to the 'likes' array
        post.socialInteractions.likes.append(user)
    }
    func getLikes() -> [User] {
        // Here, you might sort the likes, fetch additional data about the users, etc.
        return post.socialInteractions.likes
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

        // Here, you would also add code to trigger any network requests needed to update your backend server.
        // This could include sending the new comment to the server and handling any responses or errors.
    }

    func getComments() -> [Comment] {
        // You might sort comments by timestamp, handle pagination if there are many comments, etc.
        return post.socialInteractions.comments
    }
    
    func quotePost(quoteText: String, by user: User) {
        // Create a new quote instance. This represents the user's new post, which is a quote of the original post.
        let newQuote = Quote(post: self.post, quotingUser: user, quoteText: quoteText, timestamp: Date()) // 'id' will use the default value from the Quote's initializer

        // Add the new quote to the post's array of quotes.
        // This assumes that your Post's 'socialInteractions' has a 'quotes' property. If not, you'll need to adjust how quotes are stored.
        post.socialInteractions.quotes.append(newQuote)

        // Here, you would also add code to trigger any network requests needed to update your backend server.
        // This could include sending the new quote to the server, potentially creating a new post entity for the quote, and handling any responses or errors.
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

class PostsViewModel: ObservableObject {
    @Published var postViewModels: [PostViewModel] = []

    // Initializer to load the posts

    init() {
        // Assuming you fetch your sample posts here
        let posts = SampleData.allPosts
        postViewModels = posts.map { PostViewModel(post: $0) }

        // After creating your view models, you can loop through them for debugging purposes:
        for (index, viewModel) in postViewModels.enumerated() {
            if let images = viewModel.post.images {
                print("Post \(index) contains \(images.count) images.")
            } else {
                print("Post \(index) contains no images.")
            }
        }
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

