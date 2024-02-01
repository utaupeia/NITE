//
//  ProfileImageContentView.swift
//  niteclub
//
//  Created by +++ on 10/31/23.
//

import SwiftUI
import AVKit

struct ProfileImageContentView: View {
    var user: User
    var allImagePosts: [PostViewModel] // This should be all image posts, passed from outside or fetched inside the view.

    // Filter to only include image posts belonging to the specified user
    var userSpecificImagePosts: [PostViewModel] {
        allImagePosts.filter { $0.post.author.id == user.id && $0.post.images != nil }
    }

    @State private var isGridView = false
    @State private var showHiddenImages = false
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(spacing: 0) {
                
                // Full view button
                HStack {
                    Button(action: {
                        withAnimation {
                            isGridView.toggle()
                        }
                    }) {
                        Image(systemName: isGridView ? "rectangle.stack" : "square.grid.3x3.fill")
                            .padding()
                            .foregroundColor(.white)
                            .cornerRadius(12)
                }
                }
                // Define columns based on the view type
                let columns: [GridItem] = isGridView ? [
                    GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2),
                    GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2),
                    GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2)
                ] : [GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2)]
                LazyVGrid(columns: columns, spacing: 2) {
                    // Display your images
                    ForEach(userSpecificImagePosts, id: \.id) { viewModel in
                        if let imageNames = viewModel.post.images {
                            ForEach(imageNames, id: \.self) { imageName in
                                Image(imageName) // Replace with your image view
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: isGridView ? 240 : 500)
                                    .frame(width: isGridView ? UIScreen.main.bounds.width / 3 - 6 : .infinity)
                                    .clipped()
                                    // Other modifiers...
                            }
                        }
                    }

                    if showHiddenImages {
                        // hidden images, on bottom, long press should provide overlay that allows you to show image again in normal loop
                        ForEach(0..<6) { index in
                            Blur(style: .light)
                                .frame(maxWidth: .infinity)
                                .frame(height: isGridView ? 240 : 500)
                        }
                    }
                }
                .cornerRadius(24)
                .padding(.horizontal, 3)
                
                // only if profile is yours
                Button(action: {
                    withAnimation {
                        showHiddenImages.toggle()
                    }
                }) {
                    Text(showHiddenImages ? "Hide Hidden" : "Show Hidden")
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 200)
        }
    }
}

let imagePosts = SampleData.allPosts.filter { post in
    post.author.id == SampleData.userJohn.id && !(post.images?.isEmpty ?? true)
}.map { post in
    PostViewModel(post: post, currentUser: SampleData.userRickkw) // Create PostViewModel for each post
}

//
//#Preview {
//    ProfileImageContentView(user: SampleData.userJohn, allImagePosts: [imagePosts])
//}
struct ProfileImageContentView_Previews: PreviewProvider {
    static var previews: some View {

        let imagePosts = SampleData.allPosts.filter { post in
            post.author.id == SampleData.userJohn.id && !(post.images?.isEmpty ?? true)
        }.map { post in
            PostViewModel(post: post, currentUser: SampleData.userJohn)
        }

        ProfileImageContentView(user: SampleData.userJohn, allImagePosts: imagePosts)
    }
}
