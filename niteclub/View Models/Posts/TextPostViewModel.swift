//
//  TextPostViewModel.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import Foundation
import SwiftUI
import Combine

// Assuming your Post class and other code from before...

class TextPostsViewModel: ObservableObject {
    // This array will only contain posts that have text content
    @Published var textPosts: [PostViewModel] = []

    init() {
        // Filter out posts that only have text content and initialize PostViewModels for each
        let textBasedPosts = SampleData.allPosts.filter { $0.textContent != nil }
        textPosts = textBasedPosts.map { PostViewModel(post: $0, currentUser: mockCurrentUser) }
    }
}

