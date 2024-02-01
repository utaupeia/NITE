//
//  ImagePostView.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import SwiftUI

struct ImagePostView: View {
    @ObservedObject var viewModel: PostViewModel
    @EnvironmentObject var postsViewModel: PostsViewModel

<<<<<<< HEAD
    @State private var navigateToProfile: Bool = false
    @Binding var navigationPath: NavigationPath

    var onProfilePictureClicked: ((User) -> Void)?

    var onSelectPost: (PostViewModel) -> Void

=======
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            ZStack(alignment: .topLeading) {
                
                ZStack {
                    switch viewModel.post.images?.count {
                    case 1:
                        SingleImageView(imageName: viewModel.post.images!.first!)
                    case 2:
                        TwoImagesView(images: viewModel.post.images!)
                    case 3:
                        ThreeImagesView(images: viewModel.post.images!)
                    case 4:
                        FourImagesView(images: viewModel.post.images!)
                    default:
                        EmptyView() // or some other placeholder for posts with different numbers of images
                    }
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        onSelectPost(viewModel)
                    }
                }
                .cornerRadius(12)
                
                Button(action: {
<<<<<<< HEAD
                    withAnimation(.spring) {navigateToProfile(viewModel.post.author)}
=======
                    // This assumes that your Post has a reference to the user who created it
                    withAnimation(.spring) {
                        postsViewModel.selectUser(viewModel.post.author)
                    }
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
                }) {
                    Image(viewModel.post.author.profilePicture)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 36, height: 60)
                        .cornerRadius(6)
                        .padding(9)
                        .clipped()

                }
            }
                
                HStack {
                    Button(action: {
<<<<<<< HEAD
                        withAnimation(.spring) {navigateToProfile(viewModel.post.author)}
=======
                        // This assumes that your Post has a reference to the user who created it
                        withAnimation(.spring) {
                            postsViewModel.selectUser(viewModel.post.author)
                        }
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
                    }) {
                        Text(viewModel.post.author.username)
                            .font(.system(size: 13))
                            .fontWeight(.bold)
                            .foregroundColor(.white.opacity(0.75))
                            .padding(.top, 6)
                    }
                    Spacer()
                    Text(viewModel.time)
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 9)
                
                if let caption = viewModel.post.textContent {  // Safely unwrap the optional caption
                    Text(caption)
                        .font(.system(size: 15))
                        .padding(.horizontal, 6)
                        .foregroundColor(.white)
                        .padding(.top, 3)

                } else {
                    EmptyView()
                        .frame(height: 0)
                }
            }
        }
    func navigateToProfile(_ user: User) {
        withAnimation(.spring) {
            postsViewModel.selectUser(user)
            navigationPath.append(user)  // Trigger navigation
        }
    }
    }
// MARK: - Individual Views for different image counts

struct SingleImageView: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
    }
}

struct TwoImagesView: View {
    let images: [String]

    var body: some View {
        HStack(alignment: .top, spacing: 3) {
            ForEach(images, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .frame(width: UIScreen.main.bounds.width / 2 - 6)
                    .clipped()
            }
        }
        .frame(height: 300)

    }
}

struct ThreeImagesView: View {
    let images: [String]

    var body: some View {
        HStack(spacing: 3) {
            Image(images[0])  // First image occupies more space
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .frame(width: UIScreen.main.bounds.width / 2 - 6)
                .clipped()
            
            VStack(spacing: 3) {
                Image(images[1])  // Second image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .frame(width: UIScreen.main.bounds.width / 2 - 6)
                    .clipped()
                
                Image(images[2])  // Third image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .frame(width: UIScreen.main.bounds.width / 2 - 6)
                    .clipped()
            }
            .frame(height: 300)
            .frame(width: UIScreen.main.bounds.width / 2 - 6)

        }
        .frame(height: 300)
    }
}

struct FourImagesView: View {
    var images: [String] // your image names or URLs

    var body: some View {
        // Define the layout for your grid
        let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 3),
            GridItem(.flexible(), spacing: 3)
        ]

        // Create a grid view
        LazyVGrid(columns: columns, spacing: 3) {
            ForEach(images, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 240)
                    .frame(width: UIScreen.main.bounds.width / 2 - 6)
                    .clipped()
            }
        }
        .cornerRadius(21)
    }
}



let sampleUser = User(
    id: UUID(),
    username: "sampleUser",
    profilePicture: "image4", // This URL is just a placeholder
    following: [], // This user is not following anyone in this example
    followers: [], // This user has no followers in this example
    lurking: 5, // This number is arbitrary
    status: .default, // Using the 'default' status for this example
    acquiredThemes: [sampleTheme], // Assigning the sample theme we created
    selectedTheme: sampleTheme, // This user has selected the sample theme
    dateJoined: Date(), // The date of creating this sample, i.e., now
    location: "USA"
)

    // Create a sample image post with the user, timestamp, image content, and caption
let sampleImagePost = Post(
    author: sampleUser,
    timestamp: Date(),
    textContent: "This post contains an image.", // optional description
    images: ["image3", "image6"], // hypothetical image URL
    videos: nil,
    socialInteractions: interactionsManager
)


    // Create an ImagePostViewModel instance using the sample image post
let imagePostViewModel = PostViewModel(post: sampleImagePost, currentUser: mockCurrentUser)

#Preview {
    
    return ImagePostView(viewModel: imagePostViewModel, navigationPath: .constant(NavigationPath()),
                         onSelectPost: { _ in }
                         )
}
                         
