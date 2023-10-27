//
//  FollowingDisco.swift
//  niteclub
//
//  Created by +++ on 10/22/23.
//

import SwiftUI

struct FollowingDisco: View {
    @ObservedObject var viewModel = PostsViewModel()

    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.postViewModels) { postViewModel in
                    PostView(viewModel: postViewModel)
                        .padding(.bottom, 8)
                }
            }
        }
        .padding(.horizontal, 6)
    }
}
#Preview {
    FollowingDisco()
}
