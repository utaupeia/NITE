//
//  VideoDisco.swift
//  niteclub
//
//  Created by +++ on 10/25/23.
//

import SwiftUI
import AVKit

struct VideoDisco: View {
<<<<<<< HEAD
    @EnvironmentObject var viewModel: PostsViewModel
    @State private var navigationPath = NavigationPath()
    @Namespace private var namespace
    @EnvironmentObject var sharedViewModel: SharedViewModel
    @State private var activeVideoID: UUID?
=======
    @EnvironmentObject var viewModel: PostsViewModel // Access PostsViewModel from the environment
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack {
                    ForEach(viewModel.videoPostViewModels.indices, id: \.self) { index in
                        if viewModel.videoPostViewModels[index].post.type == .video {
                            let isCurrentVideoActive = viewModel.videoPostViewModels[index].post.id == activeVideoID

                            PostView(
                                viewModel: viewModel.videoPostViewModels[index],
                                postsVM: viewModel,
                                navigationPath: $navigationPath,
                                namespace: namespace,
                                onSelectPost: { selectedViewModel in
                                    sharedViewModel.selectedPost = selectedViewModel
                                    if isCurrentVideoActive { activeVideoID = selectedViewModel.post.id }
                                }
                            )
                            .frame(width: UIScreen.main.bounds.width - 12)
                            .matchedGeometryEffect(id: viewModel.videoPostViewModels[index].id, in: namespace)
                            .padding(.bottom, 8)
                        }
                    }
                }
            }
            .padding(.horizontal, 6)
        }
        .navigationDestination(for: User.self) { user in
            ProfileContentTabView(user: user, navigationPath: $navigationPath)
                .environmentObject(UserViewModel())
                .environmentObject(viewModel)
                .onAppear {
                    viewModel.userViewModel.setUserByID(user.id)
                }
        }
    }
}

#Preview {
    VideoDisco()
        .environmentObject(PostsViewModel()) // Provide a PostsViewModel instance

}
