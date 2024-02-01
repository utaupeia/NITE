//
//  PostLikeNotificationView.swift
//  niteclub
//
//  Created by +++ on 1/19/24.
//

import SwiftUI

struct PostLikeNotificationView: View {
    var notification: UserNotification
    
    var body: some View {
        ZStack {
            if case .postLike(let post) = notification.type {
                // Use the post.type to determine how to display the post
                switch post.type {
                case .text:
                    VStack() {
                        HStack(spacing: 03) {
                            // Assuming the notification type is postLike
                            
                            Image("\(mostRecentLikerPic(from: post))")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 36, height: 60)
                                .cornerRadius(6)
                                .clipped()
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                HStack(spacing: 6) {
                                    Text("\(mostRecentLikerName(from: post))")
                                        .fontWeight(.bold)
                                    Text("liked your post")
                                }
                                Text("+ \(post.socialInteractions.likes.count) other people")
                                    .font(.system(size: 15))
                                    .padding(.leading, 6)
                                
                                PostPreview(post: post)
                                
                            }.frame(height: 60)
                                .padding(.horizontal)
                            // Optionally display a preview of the post
                        }
                    }
                    // Render text post
                case .image, .video:
                    // Render image or video post
                    HStack(spacing: 0) {
                        // Assuming the notification type is postLike
                        Image("\(mostRecentLikerPic(from: post))")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 60)
                            .cornerRadius(6)
                            .clipped()
                        
                        Spacer(minLength: 0)

                        VStack(alignment: .center) {
                            HStack(spacing: 6) {
                                Text("\(mostRecentLikerName(from: post))")
                                    .fontWeight(.bold)
                                Text("liked your post")
                            }
                            
                            Text("+ \(post.socialInteractions.likes.count) other people")
                                .font(.system(size: 15))
                                .padding(.leading, 6)
                            
                            
                        }.frame(height: 60)
                            .padding(.horizontal)
                        
                        // Optionally display a preview of the post
                        PostPreview(post: post)
                        
                    }
                default:
                    EmptyView()
                    // Handle undefined or other types
                }
            }
            
        }
    }
    
    private func mostRecentLikerPic(from post: Post) -> String {
        post.socialInteractions.likes.last?.profilePicture ?? ""
    }
    private func mostRecentLikerName(from post: Post) -> String {
        post.socialInteractions.likes.last?.username ?? "Someone"
    }
    
    // Example of a simple post preview view
//    private func PostPreview(post: Post) -> some View {
//        // Use @ViewBuilder to build the view
//        @ViewBuilder var view: some View {
//            switch post.type {
//            case .text:
//                if let textContent = post.textContent {
//                    Text(textContent)
//                }
//
//            case .image:
//                if let imageNames = post.images, !imageNames.isEmpty {
//                    let firstImageURL = imageNames.first!
//                    Image(firstImageURL)
//                        .resizable()
//                        .frame(width: 60,height: 60)
//                        .cornerRadius(3)
//                }
//
//            case .video:
//                if let videoURLs = post.videos, !videoURLs.isEmpty, let firstVideoURLString = videoURLs.first, let firstVideoURL = URL(string: firstVideoURLString) {
//                    let videoPlayerViewModel = VideoPlayerViewModel(videoURL: firstVideoURL)
//                    VideoPlayerView(viewModel: videoPlayerViewModel)
//                        .mask(Rectangle().frame(width: 120, height: 60)) // Mask to crop the video
//                        .frame(width: 120, height: 60)
//
//                }
//
//            default:
//                Text("Unknown Post Type")
//            }
//        }
//
//        return view
//    }

}


#Preview {
    ForEach(SampleData.mockNotifications, id: \.id) { notification in
        PostLikeNotificationView(notification: notification)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

extension SampleData {
    static var mockNotifications: [UserNotification] {
        [
            UserNotification(id: UUID(), type: .postLike(post: johnTextPost), timestamp: Date()),
            UserNotification(id: UUID(), type: .postLike(post: emmaImagePost), timestamp: Date()),
            UserNotification(id: UUID(), type: .postLike(post: vidPost1), timestamp: Date()),
            // Add more notifications as needed
        ]
    }
}

