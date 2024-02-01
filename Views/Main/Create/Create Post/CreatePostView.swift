//
//  CreatePostView.swift
//  niteclub
//
//  Created by +++ on 10/21/23.
//

import SwiftUI
import AVFoundation
import _AVKit_SwiftUI

struct CreatePostView: View {
    @ObservedObject var viewModel: CreatePostViewModel
    @State private var showMediaPicker: Bool = false
    @State private var mediaShown: Bool = false
    private let characterLimit = 222
    var body: some View {
        VStack(alignment: .leading) {
            TextField("What's on your mind?", text: $viewModel.textContent, axis: .vertical)
                .font(.system(size: 16))
                .foregroundColor(.black)
                .padding(12)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 21)
                        .stroke(.black, lineWidth: 1)
                )
                .cornerRadius(8)
            Button(action: {
                withAnimation(.spring()) {
                    mediaShown.toggle()
                }
            }) {
                
                Image(systemName: "photo")
                    .foregroundColor(.black)
                    .padding()
            }
            if mediaShown {
                Button(action: {
                    self.showMediaPicker.toggle()
                }) {
                Blur(style: .dark)
                    .frame(width: 150, height: 240)
                    .cornerRadius(24.0)
            }
                .sheet(isPresented: $showMediaPicker) {
                    // MediaPicker()  // this would be your view or UIKit controller for picking media
                }
        }
            
            Button("Submit Post") {
                // Logic to create the post
                // For now, we're just creating a post with a dummy 'User' and current timestamp.
                _ = viewModel.createPost(author: User(username: "user", profilePicture: "image1", selectedTheme: sampleTheme, dateJoined: Date(), location: "az")) // Assuming a User initializer
                // Handle the new post: Save to a database, update UI, etc.
            }


        }
        .padding()
    }
}
let mockViewModel = CreatePostViewModel()
// Sample initialization of ThemeContent for demonstration purposes


#Preview {
    CreatePostView(viewModel: CreatePostViewModel())
}
