//
//  PostPreview.swift
//  niteclub
//
//  Created by +++ on 1/19/24.
//

import SwiftUI
import AVKit

struct PostPreview: View {
    let post: Post
//  TODO: extract thumbnail from video for less data strain

    var body: some View {
        Group {
            switch post.type {
            case .text:
                if let textContent = post.textContent {
                    Text(textContent)
                }

            case .image:
                if let imageNames = post.images, !imageNames.isEmpty {
                    let firstImageURL = imageNames.first!
                    Image(firstImageURL) // Assuming this is a local image asset
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(3)
                }

            case .video:
                if let videoURLs = post.videos, !videoURLs.isEmpty, let firstVideoURLString = videoURLs.first, let firstVideoURL = URL(string: firstVideoURLString) {
                    let videoPlayerViewModel = VideoPlayerViewModel(videoURL: firstVideoURL)
                    VideoPlayerView(viewModel: videoPlayerViewModel)
                        .frame(width: 120, height: 60)
                }

            default:
                Text("Unknown Post Type")
            }
        }
    }
}

//
//#Preview {
//    PostPreview()
//}
