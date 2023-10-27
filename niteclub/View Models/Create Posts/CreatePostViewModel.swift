//
//  CreatePostViewModel.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import Foundation

class CreatePostViewModel: ObservableObject {
    @Published var formData: CreatePostFormData
    @Published var posts: [Post]

    init(formData: CreatePostFormData = CreatePostFormData(), posts: [Post] = []) {
        self.formData = formData
        self.posts = posts
    }

    // Function to add a post
    func addPost(author: User, socialInteractions: SocialInteractionsManager) {
        let newPost = Post(author: author,
                           timestamp: Date(),
                           textContent: formData.textContent,
                           images: formData.selectedImages.isEmpty ? nil : ["image-identifiers"],  // replace with your logic
                           videos: formData.selectedVideos.isEmpty ? nil : ["video-identifiers"],  // replace with your logic
                           socialInteractions: socialInteractions)

        posts.append(newPost)
    }

    // ... Other logic like media selection handling, form validation, etc.
}

