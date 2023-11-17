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
    let items = [1, 2, 3, 4, 5] // Replace with last 10 images of gallery

    var body: some View {
        ZStack {
// theme
            Color.black.opacity(0.8).ignoresSafeArea()
            VStack {
                // Banner Ad
                Image("image42")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .infinity)
                    .frame(height: 180)
                    .clipped()
                Spacer()
            }
            .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        // clear post
                    }) {
                        Image(systemName: "xmark.circle")
                            .padding()
                    }
                    Spacer()
                    
                    Button(action: {
                        // Logic to create the post
                        // For now, we're just creating a post with a dummy 'User' and current timestamp.
                        _ = viewModel.createPost(author: User(username: "user", profilePicture: "image1", selectedTheme: sampleTheme, dateJoined: Date(), location: "az")) // Assuming a User initializer
                        // Handle the new post: Save to a database, update UI, etc.
                    }) {
                        Image(systemName: "tray.and.arrow.up")
                            .padding()
                }
                }
                
                TextField("What's on your mind?", text: $viewModel.textContent, axis: .vertical)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .padding(12)
                    .padding(.vertical, 3)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(.black, lineWidth: 1)
                    )
                    .padding(.horizontal)

                HStack {
                    Button(action: {
                        // Open Camera
                    }) {
                        
                        Image(systemName: "photo")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Button(action: {
                        // Open Camera
                    }) {
                        
                        Image(systemName: "suit.heart")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)

                    
                    Button(action: {
                        // Open Camera
                    }) {
                        
                        Text("NSFW")
                            .font(.system(size: 13))
                            .fontDesign(.serif)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                }
                .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        VStack {
                            Button(action: {
                                // Open Camera
                            }) {
                                ZStack {
                                    Blur(style: .dark)
                                        .frame(width: 140, height: 106)
                                        .cornerRadius(12)
                                    
                                    Image(systemName: "photo")
                                        .foregroundColor(.white)
                                }
                            }
                            
                            Button(action: {
                                // Open Gallery
                            }) {
                                ZStack {
                                    Blur(style: .dark)
                                        .frame(width: 140, height: 106)
                                        .cornerRadius(12)
                                    
                                    Image(systemName: "iphone.rear.camera")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        
                        HStack {
                            ForEach(items, id: \.self) { item in
                                Button(action: {
                                    // select image from gallery
                                }) {
                                    Blur(style: .dark)
                                        .frame(width: 160, height: 220)
                                        .cornerRadius(18)
                                }
                                // Additional view modifiers or content can be added here
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

let mockViewModel = CreatePostViewModel()
// Sample initialization of ThemeContent for demonstration purposes


#Preview {
    CreatePostView(viewModel: CreatePostViewModel())
}
