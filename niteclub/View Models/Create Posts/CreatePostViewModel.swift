//
//  CreatePostViewModel.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import Foundation

class CreatePostViewModel: ObservableObject {
    // 1. Properties for post content.
    @Published var textContent: String = ""
    @Published var images: [String] = [] // Placeholder for image data. You might use UIImage or some other data type in a real-world scenario.
    @Published var videos: [String] = [] // Placeholder for video data. Similarly, you might use a different data type in reality.

    // 2. Methods to add images, videos.
    func addImage(_ image: String) {
        images.append(image)
    }

    func addVideo(_ video: String) {
        videos.append(video)
    }

    // 3. Method to create a post.
    func createPost(author: User, timestamp: Date = Date()) -> Post {
        let interactionsManager = SocialInteractionsManager() // Default interactions manager
        let newPost = Post(author: author, timestamp: timestamp, textContent: textContent, images: images, videos: videos, socialInteractions: interactionsManager)
        return newPost
    }
}



