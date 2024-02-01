//
//  FollowingDisco.swift
//  niteclub
//
//  Created by +++ on 10/22/23.
//

import SwiftUI
import AVKit

struct FollowingDisco: View {
    @EnvironmentObject var viewModel: PostsViewModel
    @EnvironmentObject var storiesViewModel: StoriesViewModel
    @EnvironmentObject var sharedStoryState: SharedStoryState

    @State private var navigationPath = NavigationPath()
    @Namespace private var namespace
    @EnvironmentObject var sharedViewModel: SharedViewModel
    
    @State private var selectedPostIndex: Int?
    
    var body: some View {    
        NavigationStack(path: $navigationPath) {
            
            ZStack {
                ScrollView {
                    
                    VStack(spacing: 24) {
                        StoriesScrollView(storiesViewModel: storiesViewModel, sharedStoryState: sharedStoryState)

                        ForEach(viewModel.postViewModels.indices, id: \.self) { index in
                            PostView(
                                viewModel: viewModel.postViewModels[index], 
                                postsVM: viewModel, // new
                                navigationPath: $navigationPath,
                                namespace: namespace,
                                onSelectPost: { selectedViewModel in
                                    withAnimation(.spring()) {
                                        sharedViewModel.selectedPost = selectedViewModel
                                    }
                                }
                            )
                        }
                    }
                    .padding(.top, 40)
                }
                .padding(.horizontal, 6)
            }
        }
    }
}

#Preview {
    FollowingDisco()
        .environmentObject(PostsViewModel()) // Provide a PostsViewModel instance
        .environmentObject(StoriesViewModel(stories: SampleData.sampleStories, currentUser: SampleData.userJohn))
        .environmentObject(SharedStoryState())
}
