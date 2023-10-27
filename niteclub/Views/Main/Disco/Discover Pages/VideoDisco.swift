//
//  VideoDisco.swift
//  niteclub
//
//  Created by +++ on 10/25/23.
//

import SwiftUI

struct VideoDisco: View {
    @ObservedObject var viewModel = PostsViewModel()

    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.videoPostViewModels) { postViewModel in
                    VideoPostView(viewModel: postViewModel)
                        .padding(.bottom, 8)
                }
            }
        }
        .padding(.horizontal, 6)
    }
}

#Preview {
    VideoDisco()
}
