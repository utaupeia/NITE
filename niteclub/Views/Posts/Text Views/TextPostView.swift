//
//  TextPostView.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import SwiftUI

struct TextPostView: View {
    @ObservedObject var viewModel: PostViewModel
    @EnvironmentObject var postsViewModel: PostsViewModel

    @State private var navigateToProfile: Bool = false
    @Binding var navigationPath: NavigationPath

    var onProfilePictureClicked: ((User) -> Void)?

    var onSelectPost: (PostViewModel) -> Void

    var body: some View {
            HStack(alignment: .top) {
                
                Button(action: {
                    withAnimation(.spring) {navigateToProfile(viewModel.post.author)}
                }) {
                    Image(viewModel.post.author.profilePicture)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 36, height: 60)
                        .cornerRadius(6)
                        .clipped()
                }
                VStack(alignment: .leading) {
                    
                    HStack {
                            Text(viewModel.post.author.username)
                                .font(.system(size: 12))
                                .fontWeight(.bold)
                                .foregroundColor(.white.opacity(0.75))
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        navigateToProfile(viewModel.post.author)
                                    }
                                }
                        
                        Spacer()
                        
                        Text(viewModel.time)
                            .font(.system(size: 10))
                            .foregroundColor(.white.opacity(0.5))

                        Button(action: {
                            // Show Options Depending on USER for Actions ( Delete / Report )
                        }) {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .frame(width: 12, height: 3)
                                .foregroundColor(.white.opacity(0.25))
                        }
                    }
                                            
                        Text(viewModel.post.textContent ?? "")
                            .font(.system(size: 13))
                            .fontWeight(.regular)
                            .foregroundColor(.white.opacity(1.0))
                            .multilineTextAlignment(.leading)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    onSelectPost(viewModel)
                                }
                            }
                }
            }
            .padding(9)
            .background(
                Blur(style: .dark)
                    .cornerRadius(12)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            onSelectPost(viewModel)
                        }
                    }

            )
        }
    func navigateToProfile(_ user: User) {
        withAnimation(.spring) {
            postsViewModel.selectUser(user)
            navigationPath.append(user)  // Trigger navigation
        }
    }
    }

// Create a TextPost instance directly, instead of casting from Post to TextPost
let interactionsManager = SocialInteractionsManager()
let sampleTextPost = Post(
    author: sampleUser,
    timestamp: Date(),
    textContent: "This is a sample text post.",
    images: nil,
    videos: nil,
    socialInteractions: interactionsManager
)

let viewModel = PostViewModel(post: sampleTextPost, currentUser: mockCurrentUser)

#Preview {
    TextPostView(viewModel: viewModel, navigationPath: .constant(NavigationPath()), 
                 onSelectPost: { _ in }
    )
        .environmentObject(PostsViewModel()) // If needed

}

//struct TextPostView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        TextPostView(
//            viewModel: viewModel,
//            navigationPath: .constant(NavigationPath()),
//            onSelectPost: { _ in
//                // Action when post content is tapped. Leave blank for preview.
//            }
//        )
//        .environmentObject(PostsViewModel()) // If needed
//        // Apply any additional modifiers for preview layout.
//    }
//}


