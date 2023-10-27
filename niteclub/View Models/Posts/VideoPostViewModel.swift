//
//  VideoPostViewModel.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import Foundation
import Combine
import AVKit

class VideoPostsViewModel: ObservableObject {
    @Published var postViewModels: [PostViewModel] = []

    var videoPostViewModels: [PostViewModel] {
        postViewModels.filter {
            // Check if there are videos and no text content or images.
            !($0.post.videos?.isEmpty ?? true) && $0.post.textContent == nil && ($0.post.images?.isEmpty ?? true)
        }
    }

    // Initializer to load the posts
    init() {
        let posts = SampleData.allPosts // Assuming you fetch your sample posts here
        postViewModels = posts.map { PostViewModel(post: $0) }
    }
}




