//
//  ProfilePostFeedView.swift
//  niteclub
//
//  Created by +++ on 10/31/23.
//

import SwiftUI
// MARK: this view will contain both posts (text / video / image) of the profiles user + reposts by this user,
struct ProfilePostFeedView: View {
    var allPosts: [PostViewModel] // Includes both posts and reposts
    var user: User
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
        }
    }
}

let textPostVM = PostViewModel(post: textPost, currentUser: mockCurrentUser)
let imagePostVM = PostViewModel(post: imagePost, currentUser: mockCurrentUser)


#Preview {
    ProfilePostFeedView(allPosts: [textPostVM, imagePostVM], user: sampleUser)
}
