//
//  TextDisco.swift
//  niteclub
//
//  Created by +++ on 10/22/23.
//

import SwiftUI

struct TextDisco: View {
    @ObservedObject var viewModel = PostsViewModel() // This will be your view model containing all posts

    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.textPostViewModels) { postViewModel in
                    // Now PostView is being initialized with only text-based PostViewModels
                    TextPostView(viewModel: postViewModel) // This is your existing PostView or a modified version that better suits text posts
                        .padding(.bottom, 8)
                }
            }
        }
        .padding(.horizontal, 6)
    }
}

#Preview {
    TextDisco()
}
