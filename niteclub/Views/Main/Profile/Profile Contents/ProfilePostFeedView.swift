//
//  ProfilePostFeedView.swift
//  niteclub
//
//  Created by +++ on 10/31/23.
//

import SwiftUI
import AVKit

// MARK: this view will contain both posts (text / video / image) of the profiles user + reposts by this user,
struct ProfilePostFeedView: View {
    var allPosts: [PostViewModel] // Includes both posts and reposts
    var user: User
    @EnvironmentObject var postsVM: PostsViewModel // Assuming it's provided from the parent view
    @Binding var navigationPath: NavigationPath // Assuming it's provided from the parent view
    @Namespace private var namespace
    @State private var selectedPost: PostViewModel?

    // Filter posts to only include those belonging to the specified user
    var userSpecificPosts: [PostViewModel] {
        allPosts.filter { $0.post.author.id == user.id }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                ForEach(userSpecificPosts, id: \.id) { viewModel in
                    PostView(
                        viewModel: viewModel,
                        postsVM: postsVM, // new
                        navigationPath: .constant(NavigationPath()),
                        namespace: namespace,
                        onSelectPost: { selectedViewModel in
                            selectedPost = selectedViewModel
                        }
                    )
                }
            }
            .padding()
            .padding(.top, 30)
            .padding(.bottom, 200)
        }
    }
}

let textPostVM = PostViewModel(post: textPost, currentUser: mockCurrentUser)
let imagePostVM = PostViewModel(post: imagePost, currentUser: mockCurrentUser)


struct ProfilePostFeedView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample data for the preview
        let textPostVM = PostViewModel(post: textPost, currentUser: mockCurrentUser)
        let imagePostVM = PostViewModel(post: imagePost, currentUser: mockCurrentUser)

        // Create a sample NavigationPath
        let navigationPath = NavigationPath()

        // Provide the necessary environment object or a sample PostsViewModel
        ProfilePostFeedView(
            allPosts: [textPostVM, imagePostVM],
            user: sampleUser,
            navigationPath: .constant(navigationPath) // Provide the navigationPath here
        )
        .environmentObject(PostsViewModel()) // Provide a sample PostsViewModel
    }
}

