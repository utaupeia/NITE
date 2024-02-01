//
//  ImagePopUpView.swift
//  niteclub
//
//  Created by +++ on 1/3/24.
//

import SwiftUI

struct ImagePopUpView: View {
    var posts: [PostViewModel] // Array of PostViewModels
    var namespace: Namespace.ID
    var onDismiss: () -> Void

    var body: some View {
        ZStack {
            Blur(style: .dark)
                .onTapGesture {
                    withAnimation(.spring()) {
                        onDismiss()
                    }
                }
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 300) { // Spacing between posts
                    ForEach(posts, id: \.id) { postViewModel in
                        
                        VStack(alignment: .leading) {
                            
                            // Image ScrollView for this post
                            ZStack(alignment: .topLeading) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) { // Spacing between images
                                    ForEach(postViewModel.post.images ?? [], id: \.self) { imageName in
                                        Image(imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 400) // Adjust as needed
                                            .cornerRadius(10)
                                            .matchedGeometryEffect(id: imageName, in: namespace)
                                    }
                                }
                            }
                            Button(action: {
                                // This assumes that your Post has a reference to the user who created it
                                withAnimation(.spring) {
                                    //                                    postsViewModel.selectUser(viewModel.post.author)
                                    //                        navigationPath.append(viewModel.post.author) // Append to the navigation path
                                    //                                    navigationPath.append(viewModel.post.author)  // Trigger navigation
                                    
                                }
                            }) {
                                Image(postViewModel.post.author.profilePicture)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 36, height: 60)
                                    .cornerRadius(6)
                                    .padding(12)
                                    .clipped()
                                
                            }
                        }
                            Button(action: {
                                // This assumes that your Post has a reference to the user who created it
                                withAnimation(.spring) {
                                    //                                            postsViewModel.selectUser(viewModel.post.author)
                                }
                            }) {
                                Text(postViewModel.post.author.username)
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white.opacity(0.75))
                                    .padding(6)
                            }
                            
                            Text(postViewModel.post.textContent ?? "")
                                .font(.system(size: 13))
                                .fontWeight(.regular)
                                .foregroundColor(.white.opacity(1.0))
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 6)
                            
                        }
                    }
                }
            }
        }
    }
}


struct ImagePopUpView_Previews: PreviewProvider {
    @Namespace static var dummyNamespace

    static var previews: some View {
        // Use SampleData to create an array of PostViewModels
        let postsFromSampleData = SampleData.allPosts.map { post in
            PostViewModel(post: post, currentUser: post.author) // Assuming PostViewModel takes these parameters
        }

        ImagePopUpView(posts: postsFromSampleData, namespace: dummyNamespace, onDismiss: {})
    }
}




