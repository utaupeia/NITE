//
//  LikedPostsView.swift
//  niteclub
//
//  Created by +++ on 10/31/23.
//

import SwiftUI

struct LikedPostsView: View {
    var likedPosts: [Post]
    var user: User
    @State private var selectedPostIndex: Int?
    @Namespace private var namespace
    @State private var selectedPost: PostViewModel?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(likedPosts.indices, id: \.self) { index in
                    let postViewModel = PostViewModel(post: likedPosts[index], currentUser: user)
                    PostView(
                        viewModel: postViewModel,
                        navigationPath: .constant(NavigationPath()),
                        namespace: namespace,
                        onSelectPost: { selectedViewModel in
                            selectedPost = selectedViewModel
                        }
                    )
                }
                .padding(12)
            }
            .padding(.top, 30)
        }
    }
}


let samplePost = Post(author: sampleUser, timestamp: Date(), textContent: "This is a sample post.", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())


#Preview {
    LikedPostsView(likedPosts: [samplePost], user: sampleUser)}
