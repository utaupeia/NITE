//
//  VideoView.swift
//  niteclub
//
//  Created by +++ on 10/22/23.
//

import SwiftUI
import AVKit

struct VideoView: View {
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


#Preview {
    VideoView(viewModel: vm)
}
