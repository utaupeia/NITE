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
    @ObservedObject var adViewModel: AdViewModel
    @State private var showMediaPicker: Bool = false
    @State private var selectedImage: UIImage?
    @State private var selectedVideoURL: URL?
    @State private var mediaShown: Bool = true
    private let characterLimit = 222
    let items = [1, 2, 3, 4, 5] // Replace with last 10 images of gallery

    var body: some View {
        let textBinding = Binding<String>(
            get: { viewModel.textContent },
            set: { newValue in
                viewModel.textContent = String(newValue.prefix(viewModel.textCharacterLimit))
            }
        )

        ZStack(alignment: .top) {
            // theme
            Color.black.opacity(0.48).ignoresSafeArea()
                // Banner Ad
                BannerAd(adViewModel: adViewModel) // Add the BannerAd view

            .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                VStack {
                    HStack {
                        if viewModel.textContent.count > 0 {
                            Button(action: {
                                withAnimation(.spring()) { viewModel.clearContent()}}) {
                                Image(systemName: "xmark.circle")
                                    .foregroundStyle(.white)
                                    .padding()
                            }
                        }
                        Spacer()
                        
                        if viewModel.textContent.count > 0 {
                            
                            Button(action: {
                                // Logic to create the post
                                // For now, we're just creating a post with a dummy 'User' and current timestamp.
                                _ = viewModel.createPost(author: User(username: "user", profilePicture: "image1", selectedTheme: sampleTheme, dateJoined: Date(), location: "az")) // Assuming a User initializer
                                // Handle the new post: Save to a database, update UI, etc.
                            }) {
                                Image(systemName: "arrow.up.circle")
                                    .foregroundStyle(.white)
                                    .padding()
                            }
                        }
                    }
                    
                    TextField("What's on your mind?", text: textBinding, axis: .vertical)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(12)
                        .padding(.vertical, 3)

                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 20)
                            .foregroundColor(Color.gray.opacity(0.3))

                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: max(0, min(viewModel.textInputProgress, 1)) * UIScreen.main.bounds.width, height: 20)
                            .foregroundColor(viewModel.textInputProgress < 1 ? .blue : .green)

                    }
                    .padding([.leading, .trailing])

                }
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(viewModel.isNSFW ? .orange : (viewModel.isCloseFriends ? .pink : .white.opacity(0.5)),
                                lineWidth: 1)
                )
                .padding(.horizontal)
                
                            
                if mediaShown {
                    // conditional
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            VStack {
                                Button(action: {
                                    // Open Gallery
                                    showMediaPicker.toggle()
                                }) {
                                    Image(systemName: "photo")
                                        .foregroundColor(.white)
                                        .frame(width: 140, height: 106)
                                        .background(
                                            RoundedRectangle(cornerRadius: 18)
                                                .stroke(.white, lineWidth: 1)
                                        )
                                }
                                
                                Button(action: {
                                    // Open cam
                                }) {
                                    Image(systemName: "iphone.rear.camera")
                                        .foregroundColor(.white)
                                        .foregroundColor(.white)
                                        .frame(width: 140, height: 106)
                                        .background(
                                            RoundedRectangle(cornerRadius: 18)
                                                .stroke(.white, lineWidth: 1)
                                        )
                                }
                            }
                            
                            HStack {
                                ForEach(items, id: \.self) { item in
                                    Button(action: {
                                        // select image from gallery
                                    }) {
                                        RoundedRectangle(cornerRadius: 18)
                                            .stroke(.white, lineWidth: 1)
                                            .frame(width: 160, height: 220)

                                    }
                                    // Additional view modifiers or content can be added here
                                }
                            }
                        }
                        .padding()
                    }
                }
                Spacer()
                HStack {
                    Button(action: {
                        // toggle media visibility
                        withAnimation(.spring()) {
                            mediaShown.toggle()
                        }
                    }) {
                        Image(systemName: "photo")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    Button(action: {withAnimation(.spring()) {viewModel.isCloseFriends.toggle()}}) {
                        Image(systemName: viewModel.isCloseFriends ? "heart.fill" : "heart")
                            .font(.system(size: 15))
                            .foregroundColor(viewModel.isCloseFriends ? .pink : .white)
                            
                    }
                    .padding(.horizontal)
                    
                    Button(action: {withAnimation(.spring()) {viewModel.isNSFW.toggle()}}) {
                        Text("NSFW")
                            .font(.system(size: 13))
                            .fontDesign(.serif)
                            .foregroundColor(viewModel.isNSFW ? .orange : .white)
                            .padding(.horizontal)
                    }
                }
                .padding()

            }
            .padding(.top, 160)
        }
        .sheet(isPresented: $showMediaPicker) {
            MediaPicker(selectedImage: $selectedImage, selectedVideoURL: $selectedVideoURL)
        }

    }
}

let mockViewModel = CreatePostViewModel(currentUser: SampleData.userJohn)
// Sample initialization of ThemeContent for demonstration purposes

#Preview {
    CreatePostView(viewModel: mockViewModel, adViewModel: AdViewModel())
}
