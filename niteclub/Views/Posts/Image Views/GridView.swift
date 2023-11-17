//
//  GridView.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import SwiftUI

struct GridView: View {
    var imagePosts: [PostViewModel]  // The PostViewModels
    @State private var isGridView = true

    // Define a 3-column grid layout

    var body: some View {
        ScrollView {
            VStack {
                // Full view button
                HStack {
                    Button(action: {
                        withAnimation {
                            isGridView.toggle()
                        }
                    }) {
                        Text(isGridView ? "Full View" : "Grid View")
                            .padding()
                            .foregroundColor(.white)
                            .cornerRadius(12)
                }
                }
                let columns: [GridItem] = isGridView ? [
                    GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2),
                    GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2),
                    GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2)
                ] : [GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2)]

                LazyVGrid(columns: columns, spacing: 3) {
                    // Iterate over the PostViewModels and create image views
                    ForEach(imagePosts, id: \.post.id) { postViewModel in
                        // Check if the image exists in the assets
                        if let imageName = postViewModel.post.images?.first, let uiImage = UIImage(named: imageName) {
                            ZStack(alignment: .bottomTrailing) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: isGridView ? 220 : .infinity)
                                    .frame(width: isGridView ? UIScreen.main.bounds.width / 3 - 6 : .infinity)
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
            .padding(.all, 3)
            }  // Padding around the entire grid
            .padding(.top, 40)
        }
    }
}
// Extract image names from the sample posts
let mockCurrentUser = User(id: UUID(), username: "CurrentUser", profilePicture: "", following: [], followers: [], status: .default, acquiredThemes: [], selectedTheme: Theme(
    name: "Cool Blue",
    content: ThemeContent(id: UUID() , themeURL: "url_to_theme_content"),
    price: 2.99,
    creationDate: Date(),  // Assuming the theme is created now
    approved: true  // Let's say this theme is already approved
), dateJoined: Date(), location: "Test Location")

let mockPostViewModels = SampleData.allPosts.filter { post in
    guard let images = post.images, !images.isEmpty else {
        return false
    }
    return true
}.map { post in
    PostViewModel(post: post, currentUser: mockCurrentUser)
}


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
