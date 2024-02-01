//
//  ProfileVideoContentView.swift
//  niteclub
//
//  Created by +++ on 11/2/23.
//

import SwiftUI
import AVKit

struct ProfileVideoContentView: View {
    var user: User
    @EnvironmentObject var postsVM: PostsViewModel
    @Namespace private var namespace
    @Binding var navigationPath: NavigationPath

    // Filter to only include video posts belonging to the specified user
    var userSpecificVideoPosts: [PostViewModel] {
        postsVM.postViewModels.filter { $0.post.author.id == user.id && $0.post.type == .video }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                ForEach(userSpecificVideoPosts, id: \.id) { viewModel in
                    PostView(
                        viewModel: viewModel,
                        postsVM: postsVM,
                        navigationPath: $navigationPath,
                        namespace: namespace,
                        onSelectPost: { selectedViewModel in
                            // Handle post selection if needed
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
//
//#Preview {
//    ProfileVideoContentView(user: sampleUser)
//}

struct ProfileVideoContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of PostsViewModel
        let postsViewModel = PostsViewModel()

        // Provide it to your previewed view
        ProfileVideoContentView(user: SampleData.userJohn, navigationPath: .constant(NavigationPath()))
            .environmentObject(postsViewModel)
    }
}


