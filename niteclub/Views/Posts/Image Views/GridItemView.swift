//
//  GridItemView.swift
//  niteclub
//
//  Created by +++ on 10/22/23.
//

import SwiftUI

struct GridItemView: View {
    @ObservedObject var viewModel: PostViewModel
    
    var body: some View {
        // Stack the content, so the overlay doesn't interfere with the image
        ZStack(alignment: .bottomTrailing) {
            // Display the image
            if let imageName = viewModel.post.images?.first, let image = UIImage(named: imageName) {
                Image(uiImage: image)
            } else {
                // Fallback or placeholder image if the image is missing
                Rectangle()
                    .fill(Color.gray)
            }
            
            // If there are multiple images, show an indicator
            if let images = viewModel.post.images, images.count > 1 {
                Image(systemName: "square.stack.fill")
                    .padding(4)
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .font(.caption)
                    .clipShape(Circle())
                    .padding(4)
            }
        }
    }
}

#Preview {
    GridItemView(viewModel: imagePostViewModel)
}
