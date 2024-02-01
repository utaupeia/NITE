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
<<<<<<< HEAD
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
=======
    @Binding var navigationPath: NavigationPath
    @State private var selectedPostIndex: Int?
    @Namespace private var namespace
    @State private var selectedPost: PostViewModel?

    var body: some View {
//        NavigationStack(path: $navigationPath) {
        ZStack {
            ScrollView {
                    VStack(spacing: 24) {
                        ForEach(viewModel.postViewModels.indices, id: \.self) { index in
                            PostView(viewModel: viewModel.postViewModels[index],
                                     navigationPath: $navigationPath)  // Corrected line
                            .matchedGeometryEffect(id: viewModel.postViewModels[index].id, in: namespace)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedPost = viewModel.postViewModels[index]
                                }
                            }

    //                    , onSelect: { _ in selectedPostIndex = index }
    //                            .padding(.bottom, 15)
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
                        }
                    }
                    .padding(.top, 40)
                }
<<<<<<< HEAD
                .padding(.horizontal, 6)
=======
            .padding(.horizontal, 6)
            
            if let selectedPost = selectedPost {
                PopupPostView(postViewModel: selectedPost, namespace: namespace) {
                    self.selectedPost = nil
                }
                .zIndex(1)
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
            }

        }
    }
}

<<<<<<< HEAD
#Preview {
    FollowingDisco()
        .environmentObject(PostsViewModel()) // Provide a PostsViewModel instance
        .environmentObject(StoriesViewModel(stories: SampleData.sampleStories, currentUser: SampleData.userJohn))
        .environmentObject(SharedStoryState())
=======


#Preview {
    FollowingDisco(navigationPath: .constant(NavigationPath()))
        .environmentObject(PostsViewModel()) // Provide a PostsViewModel instance

>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
}
