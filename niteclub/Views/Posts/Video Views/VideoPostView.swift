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

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            ZStack(alignment: .topLeading) {
                
                
                Image(viewModel.post.author.profilePicture)
                    .resizable()
                    .frame(width: 36, height: 60)
                    .cornerRadius(6)
                    .padding(9)
            }
                
                HStack {
                    Text(viewModel.post.author.username)
                        .font(.system(size: 13))
                        .fontWeight(.bold)
                    Spacer()
                    Text(viewModel.time)
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 6)
                
                if let caption = viewModel.post.textContent {  // Safely unwrap the optional caption
                    Text(caption)
                        .font(.system(size: 15))
                        .padding(.horizontal, 6)

                }
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
    let vm = PostViewModel(post: sampleVideoPost)

#Preview {
    VideoPostView(viewModel: vm)
}
