//
//  LikedPostsView.swift
//  niteclub
//
//  Created by +++ on 10/31/23.
//

import SwiftUI
import AVKit

struct LikedPostsView: View {
    var likedPosts: [Post]
    var user: User
<<<<<<< HEAD
    @EnvironmentObject var postsVM: PostsViewModel // Use shared instance
    @Namespace private var namespace
    @State private var selectedPost: PostViewModel?
=======
    @State private var selectedPostIndex: Int?
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
<<<<<<< HEAD
                ForEach(likedPosts.indices, id: \.self) { index in
                    let postViewModel = PostViewModel(post: likedPosts[index], currentUser: user)
                    PostView(
                        viewModel: postViewModel,
                        postsVM: postsVM, // Use the shared instance
                        navigationPath: .constant(NavigationPath()),
                        namespace: namespace,
                        onSelectPost: { selectedViewModel in
                            selectedPost = selectedViewModel
                        }
                    )
=======
                ForEach(likedPosts) { post in
                    PostView(viewModel: PostViewModel(post: post, currentUser: mockCurrentUser), 
                             navigationPath: .constant(NavigationPath()))
//                    , onSelect: { _ in selectedPostIndex = index }

>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
                }
                .padding(12)
            }
            .padding(.top, 30)
        }
    }
}



let samplePost = Post(author: sampleUser, timestamp: Date(), textContent: "This is a sample post.", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())


#Preview {
<<<<<<< HEAD
    LikedPostsView(likedPosts: [samplePost], user: sampleUser)
        .environmentObject(PostsViewModel())
}
=======
    LikedPostsView(likedPosts: [samplePost], user: sampleUser)}
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
