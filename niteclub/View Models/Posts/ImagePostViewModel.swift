//
//  ImagePostViewModel.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import Foundation
import Combine
import SwiftUI

class ImagePostsViewModel: ObservableObject {
    @Published var postViewModels: [PostViewModel] = []

    var imagePostViewModels: [PostViewModel] {
        postViewModels.filter {
            // Check if there are images and no text content or videos.
            !($0.post.images?.isEmpty ?? true) && $0.post.textContent == nil && ($0.post.videos?.isEmpty ?? true)
        }
    }

    // Initializer to load the posts
    init() {
        let posts = SampleData.allPosts // Assuming you fetch your sample posts here
        postViewModels = posts.map { PostViewModel(post: $0, currentUser: mockCurrentUser) }
    }
}


