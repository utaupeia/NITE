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
    @EnvironmentObject var sharedViewModel: SharedViewModel

    var body: some View {
        ZStack {
            ScrollView {
                    VStack(spacing: 24) {
                        ForEach(viewModel.postViewModels.indices, id: \.self) { index in
                            PostView(
                                viewModel: viewModel.postViewModels[index],
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


#Preview {
    FollowingDisco(navigationPath: .constant(NavigationPath()))
        .environmentObject(PostsViewModel()) // Provide a PostsViewModel instance

}
