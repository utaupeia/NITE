//
//  ImageDisco.swift
//  niteclub
//
//  Created by +++ on 10/22/23.
//

import SwiftUI

struct ImageDisco: View {
    @EnvironmentObject var viewModel: PostsViewModel // Access PostsViewModel from the environment

    var body: some View {
        // You can directly initialize the GridView with the image posts.
        // The GridView itself will handle the rendering of each image post.
        GridView(imagePosts: viewModel.imagePostViewModels)
            .padding(.horizontal, 6)
        
    }
}

#Preview {
    ImageDisco()
        .environmentObject(PostsViewModel()) // Provide a PostsViewModel instance

}
