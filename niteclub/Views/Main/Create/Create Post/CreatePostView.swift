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
    @EnvironmentObject var viewModel: CreatePostViewModel  // assuming it's stored as an environment object
    @State private var showMediaPicker: Bool = false
    @State private var mediaShown: Bool = false
    private let characterLimit = 222
    var body: some View {
        VStack(alignment: .leading) {
            TextField("What's on your mind?", text: $viewModel.formData.textContent, axis: .vertical)
                .font(.system(size: 16))
                .foregroundColor(.black)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 30)
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
            
            
            Button(action: {
                // Here, create the post with the necessary data
                viewModel.addPost(author: User(username: "user", profilePicture: "image3"), socialInteractions: SocialInteractionsManager())  // replace with actual data
            }) {
                Text("Post")
                    .padding()
            }
        }
        .padding()
    }
}
let mockViewModel = CreatePostViewModel()

#Preview {
    CreatePostView()
        .environmentObject(mockViewModel)  // Here's where you inject the mock view model
}
