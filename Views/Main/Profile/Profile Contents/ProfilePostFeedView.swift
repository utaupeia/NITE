//
//  ProfilePostFeedView.swift
//  niteclub
//
//  Created by +++ on 10/31/23.
//

import SwiftUI

struct ProfilePostFeedView: View {
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
                }
            }
            .padding()
        }
    }
}
let textPostVM = PostViewModel(post: textPost, currentUser: mockCurrentUser)
let imagePostVM = PostViewModel(post: imagePost, currentUser: mockCurrentUser)


#Preview {
    ProfilePostFeedView(posts: [textPostVM, imagePostVM], user: sampleUser)
}