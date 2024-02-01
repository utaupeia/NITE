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
<<<<<<< HEAD
    var allImagePosts: [PostViewModel] // This should be all image posts, passed from outside or fetched inside the view.

    // Filter to only include image posts belonging to the specified user
    var userSpecificImagePosts: [PostViewModel] {
        allImagePosts.filter { $0.post.author.id == user.id && $0.post.images != nil }
    }

    @State private var isGridView = false
=======

    let sampleimages = ["p23"]
    let imageNames = ["story1", "story2", "story3", "story4"]
    let imageNames2 = ["album8","album9"]
    @State private var isGridView = true
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
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
<<<<<<< HEAD
                        Image(systemName: isGridView ? "rectangle.stack" : "square.grid.3x3.fill")
=======
                        Text(isGridView ? "Full View" : "Grid View")
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
                            .padding()
                            .foregroundColor(.white)
                            .cornerRadius(12)
                }
<<<<<<< HEAD
=======
                    Spacer()
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
                }
                // Define columns based on the view type
                let columns: [GridItem] = isGridView ? [
                    GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2),
                    GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2),
                    GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2)
                ] : [GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2)]
                LazyVGrid(columns: columns, spacing: 2) {
                    // Display your images
<<<<<<< HEAD
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

=======
                    ForEach(0..<12) { index in
                        Blur(style: .dark)
                            .frame(maxWidth: .infinity)
                            .frame(height: isGridView ? 240 : 500)
//                        height of list view will be whatever the height of the image is
//                        and will be able to swipe if multi pic
                    }
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
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
<<<<<<< HEAD
            .padding(.top, 30)
            .padding(.bottom, 200)
=======
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
        }
    }
}

<<<<<<< HEAD
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
=======

#Preview {
    ProfileImageContentView(user: sampleUser)
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
}
