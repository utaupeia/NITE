//
//  VideoPostView.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import SwiftUI
import AVKit

struct VideoPostView: View {
    @ObservedObject var viewModel: PostViewModel
    @EnvironmentObject var postsViewModel: PostsViewModel
<<<<<<< HEAD

    @StateObject private var videoPlayerViewModel: VideoPlayerViewModel
    @State private var navigateToProfile: Bool = false
    @Binding var navigationPath: NavigationPath
    @Binding var isActiveVideo: Bool

    var onProfilePictureClicked: ((User) -> Void)?
    var onSelectPost: (PostViewModel) -> Void

    init(viewModel: PostViewModel, navigationPath: Binding<NavigationPath>, isActiveVideo: Binding<Bool>, onSelectPost: @escaping (PostViewModel) -> Void) {
        self._viewModel = ObservedObject(initialValue: viewModel)
        self._navigationPath = navigationPath
        self._isActiveVideo = isActiveVideo
        self.onSelectPost = onSelectPost

        // Assume videoURLString is always available and valid
        _ = URL(string: viewModel.post.videos!.first!)!
        if let videoURLString = viewModel.post.videos?.first, let videoURL = URL(string: videoURLString) {
            self._videoPlayerViewModel = StateObject(wrappedValue: VideoPlayerViewModel(videoURL: videoURL))
        } else {
            fatalError("Video URL is not available")
        }
    }
=======
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topLeading) {
                // Initialize the videoPlayerViewModel if there's a video URL
                
<<<<<<< HEAD
                
                VideoPlayerView(viewModel: videoPlayerViewModel)
                    .onTapGesture {
                            withAnimation(.spring()) {
                                onSelectPost(viewModel)
                            }
                        }
                

                // Profile Picture and Countdown Timer
                VStack {
                    HStack(alignment: .top) {
                        Button(action: {
//                            postsViewModel.selectUser(viewModel.post.author)
                            navigateToProfile(viewModel.post.author)
                        }) {
                            Image(viewModel.post.author.profilePicture)
                                .resizable()
                                .frame(width: 36, height: 60)
                                .cornerRadius(6)
                                .padding(9)
                        }
                        Spacer()
                        
                        Text(videoPlayerViewModel.remainingTimeText)
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                            .padding(9)

                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            videoPlayerViewModel.toggleMute()
                        }) {
                            Image(systemName: videoPlayerViewModel.isMuted ? "speaker.slash.fill" : "speaker.fill")
                                .foregroundColor(.white)
                        }
                        .padding(9)
                        
                    }
=======
                Button(action: {
                    // This assumes that your Post has a reference to the user who created it
                    postsViewModel.selectUser(viewModel.post.author)
                }) {
                    Image(viewModel.post.author.profilePicture)
                        .resizable()
                        .frame(width: 36, height: 60)
                        .cornerRadius(6)
                        .padding(9)
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
                }
            }
            .frame(width: .infinity)
            .frame(height: 240)
            .cornerRadius(12)
            .onTapGesture {
                withAnimation(.spring()) {
                    onSelectPost(viewModel)
                }
            }
            // Post Author and Caption
            HStack {
                Button(action: {
                    withAnimation(.spring) {navigateToProfile(viewModel.post.author)}
                }) {
                    Text(viewModel.post.author.username)
                        .foregroundColor(.white.opacity(0.75))
                        .font(.system(size: 13))
                        .fontWeight(.bold)
                }
                Spacer()
                Text(viewModel.time)
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 6)
                
        }
        
    }
    func navigateToProfile(_ user: User) {
        withAnimation(.spring) {
            postsViewModel.selectUser(user)
            navigationPath.append(user)  // Trigger navigation
        }
    }
}

let sampleVideoPost = Post(
    author: sampleUser,
    timestamp: Date(),
    textContent: "This post contains an image.", // optional description
    images: nil, // hypothetical image URL
    videos: ["image3"],
    socialInteractions: interactionsManager
)


    // Create an ImagePostViewModel instance using the sample image post
let vm = PostViewModel(post: sampleVideoPost, currentUser: mockCurrentUser)

//#Preview {
//    VideoPostView(viewModel: vm)
//}
struct VideoPostView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a URL for the local video
        let localVideoURL = Bundle.main.url(forResource: "samplevideo", withExtension: "mov")!

        // Mock the Post object with the local video URL
        let mockPost = Post(id: UUID(), author: SampleData.userEmma, timestamp: Date(), textContent: "This is a sample post", images: nil, videos: [localVideoURL.absoluteString], socialInteractions: SocialInteractionsManager())

        let mockViewModel = PostViewModel(post: mockPost, currentUser: SampleData.userEmma)

        // Use VideoPostView with the mock ViewModel for preview
        return VideoPostView(viewModel: mockViewModel, navigationPath: .constant(NavigationPath()), isActiveVideo: .constant(true), onSelectPost: { _ in }
)
            .environmentObject(PostsViewModel())
    }
}

