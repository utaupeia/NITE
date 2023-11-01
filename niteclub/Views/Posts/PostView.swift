//
//  PostView.swift
//  niteclub
//
//  Created by +++ on 10/21/23.
//

import SwiftUI

struct PostView: View {
    @ObservedObject var viewModel: PostViewModel

    var body: some View {
        VStack {

            
            switch viewModel.post.type {
            case .text:
                TextPostView(viewModel: viewModel)
            case .image:
                ImagePostView(viewModel: viewModel)
            case .video:
                VideoPostView(viewModel: viewModel)
            default:
                EmptyView()
            }
        }
    }
}

let quotedTextPost = Post(id: UUID(), author: sampleUser, timestamp: Date(), textContent: "This is the original post being quoted!", images: nil, videos: nil, socialInteractions: interactionsManager)


let textPost = Post(id: UUID(), author: sampleUser, timestamp: Date(), textContent: "This is an amazing text post!", images: nil, videos: nil, socialInteractions: interactionsManager)

let imagePost = Post(id: UUID(), author: sampleUser, timestamp: Date(), textContent: "Check out these images!", images: ["image1url", "image2url"], videos: nil, socialInteractions: interactionsManager)

let videoPost = Post(id: UUID(), author: sampleUser, timestamp: Date(), textContent: "Awesome video ahead!", images: nil, videos: ["videoUrl"], socialInteractions: interactionsManager)

let textPostViewModel = PostViewModel(post: textPost, currentUser: mockCurrentUser)
let videoPostViewModel = PostViewModel(post: videoPost, currentUser: mockCurrentUser)

#Preview {
    PostView(viewModel: PostViewModel(post: textPost, currentUser: mockCurrentUser))
}
