//
//  TextPostView.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import SwiftUI

struct TextPostView: View {
    @ObservedObject var viewModel: PostViewModel  // Changed parameter name to viewModel

    var body: some View {
            HStack(alignment: .top) {
                
                // button links to profile 
                Image(viewModel.post.author.profilePicture)
                    .resizable()
                    .frame(width: 36, height: 60)
                    .cornerRadius(6)

                VStack(alignment: .leading) {
                    
                    HStack {
                        Text(viewModel.post.author.username)
                                .font(.system(size: 12))
                                .fontWeight(.bold)
                                .foregroundColor(.white.opacity(0.75))
                        
                        Spacer()
                        
                        Text(viewModel.time)
                            .font(.system(size: 10))
                            .foregroundColor(.white.opacity(0.5))
                            .padding(.horizontal, 6)

                    }

                        
                    Text(viewModel.post.textContent ?? "")
                        //                    Text(post.content)
                            .font(.system(size: 13))
                            .fontWeight(.regular)
                            .foregroundColor(.white.opacity(1.0))
                            .multilineTextAlignment(.leading)
                }
            }
            .padding(6)
            .background(
                Blur(style: .dark)
                    .cornerRadius(12)
            )
//            .padding(6) sample padding , add in on call in view 
        }
    }

// Create a TextPost instance directly, instead of casting from Post to TextPost
let interactionsManager = SocialInteractionsManager()
let sampleTextPost = Post(
    author: sampleUser,
    timestamp: Date(),
    textContent: "This is a sample text post.",
    images: nil,
    videos: nil,
    socialInteractions: interactionsManager
)

let viewModel = PostViewModel(post: sampleTextPost, currentUser: mockCurrentUser)

#Preview {
    TextPostView(viewModel: viewModel)
}

