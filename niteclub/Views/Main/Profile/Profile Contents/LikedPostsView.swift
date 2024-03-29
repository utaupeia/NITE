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

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(likedPosts) { post in
                    PostView(viewModel: PostViewModel(post: post, currentUser: mockCurrentUser), 
                             navigationPath: .constant(NavigationPath()))
//                    , onSelect: { _ in selectedPostIndex = index }

                }
            }
            .padding()
        }
    }
}


let samplePost = Post(author: sampleUser, timestamp: Date(), textContent: "This is a sample post.", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())


#Preview {
    LikedPostsView(likedPosts: [samplePost], user: sampleUser)}
