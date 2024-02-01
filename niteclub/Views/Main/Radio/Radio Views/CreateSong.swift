//
//  CreateSong.swift
//  niteclub
//
//  Created by +++ on 12/9/23.
//

import SwiftUI
import UniformTypeIdentifiers
import PhotosUI

struct CreateSong: View {
    @State private var songName: String = ""
    @State private var showDocumentPicker = false
    @State private var showImagePicker = false
    @State private var image: UIImage?
    @State private var selectedFileName: String?
    
    var isCreateSongEnabled: Bool {
        image != nil && !songName.isEmpty && selectedFileName != nil
    }
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: .center) {
                    if songName.isEmpty {
                        HStack {
                            
                            Text("Song Name")
                                .fontDesign(.monospaced)
                                .foregroundStyle(.white)
                                .font(.system(size: 19))

                        }
                    }
                    
                    TextField("Song Name", text: $songName)
                        .multilineTextAlignment(.center)
                        .fontDesign(.monospaced)
                        .font(.system(size: 19))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(width: .infinity)

                    
                }
                .padding()
                .padding(.vertical, 30)
                
                if let image = image {
                    VStack() {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .cornerRadius(12)
                            .clipped()

                        Button(action: {
                            withAnimation(.spring()) {
                                self.image = nil // Clear the selected image
                            }
                        }) {
                            Text("Remove Artwork")
                                .padding()
                                .foregroundStyle(.red.opacity(0.75))
                                .fontDesign(.monospaced)
                        }
                    }
                } else {
                    Button(action: {
                        showImagePicker = true
                    }) {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(.white, lineWidth: 1.5)
                                .frame(width: 200, height: 200)
                            
                            Text("Artwork")
                                .padding()
                                .foregroundStyle(.white)
                                .fontDesign(.monospaced)
                        }
                    }
                }
                                // MP3 File Upload or Selected File Name
                if let selectedFileName = selectedFileName {
                    HStack {
                        Button(action: {
                            withAnimation(.spring()) {
                                self.selectedFileName = nil // Clear the selected audio
                            }
                        }) {
                            Text("Remove Audio")
                                .padding()
                                .foregroundStyle(.red.opacity(0.75))
                                .fontDesign(.monospaced)
                        }
                        Text(selectedFileName)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                        .cornerRadius(5)
                    }
                } else {
                    Button(action:
                            {
                        showDocumentPicker = true
                    }) {
                        HStack {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 100, height: 1.5)
                                .foregroundStyle(.white)

                            Text("Audio File")
                                .fontDesign(.monospaced)
                                .foregroundStyle(.white)
                                .font(.system(size: 18))
                            
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 100, height: 1.5)
                                .foregroundStyle(.white)

                        }
                        .padding()
                        .padding(.vertical, 30)
                    }
                }
    
            }
            .padding()
            
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $image)
        }
        .sheet(isPresented: $showDocumentPicker) {
            DocumentPicker(selectedFileName: $selectedFileName)
        }

        if isCreateSongEnabled {
            Button("Create Song") {
                // Handle the song creation logic here
                // Adding Music Post to Feed
                // Adding To Library
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(5)
            
        }
    }
}

#Preview {
    CreateSong()
}
