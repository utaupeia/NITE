//
//  PostRepostNotificaionView.swift
//  niteclub
//
//  Created by +++ on 1/19/24.
//

import SwiftUI

struct PostRepostNotificaionView: View {
    var notification: UserNotification
    
    var body: some View {
        ZStack {
            
            if case .postRepost(let post) = notification.type {
                // Use the post.type to determine how to display the post
                switch post.type {
                case .text:
                    VStack() {
                        HStack(spacing: 03) {
                            // Assuming the notification type is postLike
                            
                            Image("\(mostRecentReposterPic(from: post))")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 36, height: 60)
                                .cornerRadius(6)
                                .clipped()
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                HStack(spacing: 6) {
                                    Text("\(mostRecentReposterName(from: post))")
                                        .fontWeight(.bold)
                                    Text("reposted this post")
                                }
                                Text("+ \(post.socialInteractions.reposts.count) other people")
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
                        Image("\(mostRecentReposterPic(from: post))")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 60)
                            .cornerRadius(6)
                            .clipped()
                        
                        Spacer(minLength: 0)

                        VStack(alignment: .center) {
                            HStack(spacing: 6) {
                                Text("\(mostRecentReposterName(from: post))")
                                    .fontWeight(.bold)
                                Text("reposted this")
                            }
                            
                            Text("+ \(post.socialInteractions.reposts.count) other people")
                                .font(.system(size: 15))
                                .padding(.leading, 6)
                            
                            
                        }.frame(height: 60)
                            .padding(.horizontal)
                        
                        Spacer(minLength: 0)

                        // Optionally display a preview of the post
                        PostPreview(post: post)
                            .cornerRadius(3)
                    }
                default:
                    EmptyView()
                    // Handle undefined or other types
                }
            }
            
        }
    }
    
    private func mostRecentReposterPic(from post: Post) -> String {
        post.socialInteractions.reposts.last?.profilePicture ?? ""
    }
    private func mostRecentReposterName(from post: Post) -> String {
        post.socialInteractions.reposts.last?.username ?? "Someone"
    }
    
}


#Preview {
    ForEach(SampleData.mockNotifications1, id: \.id) { notification in
        PostRepostNotificaionView(notification: notification)
            .previewLayout(.sizeThatFits)
            .padding()
            .border(.red)

    }
}

extension SampleData {
    static var mockNotifications1: [UserNotification] {
        [
            UserNotification(id: UUID(), type: .postRepost(post: johnTextPost), timestamp: Date()),
            UserNotification(id: UUID(), type: .postRepost(post: emmaImagePost), timestamp: Date()),
            UserNotification(id: UUID(), type: .postRepost(post: vidPost1), timestamp: Date()),
            // Add more notifications as needed
        ]
    }
}
