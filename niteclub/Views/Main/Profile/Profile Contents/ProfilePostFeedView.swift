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
<<<<<<< HEAD
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
=======
    var posts: [PostViewModel] // Includes both posts and reposts
    var user: User
    @State private var selectedPostIndex: Int?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(posts, id: \.id) { viewModel in
                    // We'll use the PostView you provided earlier to display each post
//                    PostView(viewModel: viewModel.textPostViewModels[index],
                    PostView(viewModel: viewModel, navigationPath: .constant(NavigationPath()))
                        .padding(.bottom)
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
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


<<<<<<< HEAD
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
=======
#Preview {
    ProfilePostFeedView(posts: [textPostVM, imagePostVM], user: sampleUser)
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
}

