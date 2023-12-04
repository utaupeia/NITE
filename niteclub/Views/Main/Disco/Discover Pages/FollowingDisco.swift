//
//  FollowingDisco.swift
//  niteclub
//
//  Created by +++ on 10/22/23.
//

import SwiftUI

struct FollowingDisco: View {
    @EnvironmentObject var viewModel: PostsViewModel
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
                        }
                    }
                    .padding(.top, 40)
                }
            .padding(.horizontal, 6)
            
            if let selectedPost = selectedPost {
                PopupPostView(postViewModel: selectedPost, namespace: namespace) {
                    self.selectedPost = nil
                }
                .zIndex(1)
            }

        }
    }
}



#Preview {
    FollowingDisco(navigationPath: .constant(NavigationPath()))
        .environmentObject(PostsViewModel()) // Provide a PostsViewModel instance

}
