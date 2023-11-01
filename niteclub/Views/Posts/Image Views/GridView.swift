//
//  GridView.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import SwiftUI

struct GridView: View {
    var imagePosts: [PostViewModel]  // The PostViewModels

    // Define a 3-column grid layout
    let columns = [
        GridItem(.flexible(), spacing: 3),
        GridItem(.flexible(), spacing: 3),
        GridItem(.flexible(), spacing: 3)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 3) {
                // Iterate over the PostViewModels and create image views
                ForEach(imagePosts, id: \.post.id) { postViewModel in
                    // Check if the image exists in the assets
                    if let imageName = postViewModel.post.images?.first, let uiImage = UIImage(named: imageName) {
                        ZStack(alignment: .bottomTrailing) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 240)
                                .frame(width: UIScreen.main.bounds.width / 3 - 6)
                                .clipped()

                            if let images = postViewModel.post.images, images.count > 1 {
                                Image(systemName: "square.stack.fill")
                                    .padding(4)
                                    .background(Color.black.opacity(0.7))
                                    .foregroundColor(.white)
                                    .font(.caption)
                                    .clipShape(Circle())
                                    .padding(4)
                            }
                        }
                    } else {
                        // Placeholder in case the image is missing
                        Rectangle()
                            .fill(Color.gray)
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(10)
                    }
                }
            }
            .cornerRadius(21.0)
            .padding(.all, 3)  // Padding around the entire grid
        }
    }
}
// Extract image names from the sample posts
let mockCurrentUser = User(id: UUID(), username: "CurrentUser", profilePicture: "", following: [], followers: [], status: .default, acquiredThemes: [], selectedTheme: ThemeContent(
    name: "Cool Blue",
    content: Theme(themeURL: "url_to_theme_content"),
    price: 2.99,
    creationDate: Date(),  // Assuming the theme is created now
    approved: true  // Let's say this theme is already approved
), dateJoined: Date(), location: "Test Location")

let mockPostViewModels = SampleData.allPosts.filter {
    // Ensure that the post has at least one image
    guard let images = $0.images, !images.isEmpty else {
        return false
    }
    return true
}.map { PostViewModel(post: $0, currentUser: mockCurrentUser) }

#Preview {
    GridView(imagePosts: mockPostViewModels)
}

// Mock ViewModel for preview purposes
class MockPostViewModel: PostViewModel {
    init() {
        // Assuming your PostViewModel expects a 'Post' model on initialization. Adjust as per your actual initializer.
        super.init(post: Post(id: UUID(), author: User(id: UUID(), username: "testUser", profilePicture: "testImage", selectedTheme: sampleTheme, dateJoined: Date(), location: "some")
                              , timestamp: Date(), textContent: "Test post", images: ["image1", "image2"], videos: nil, socialInteractions: SocialInteractionsManager()), currentUser: mockCurrentUser)
    }
}
