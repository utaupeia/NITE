//
//  PicContent.swift
//  niteclub
//
//  Created by +++ on 11/20/23.
//

import SwiftUI

struct PicContent: View {
        @Environment(\.presentationMode) var presentationMode
//        var content: PicContent
        @State private var isLiked = false
        @State private var showLikes = false  // Add this line
        var isSelfPost: Bool = false  // Add this line, update it based on your logic
        @State private var showTextField = false // New state variable to control the visibility of the TextField
        @State private var commentCount = 123 // Replace with your actual data
        @State private var comments = ""
        @State private var showCommentsSection = false  // New state variable to control the visibility of the comments section
        var body: some View {
            ZStack {
//                Background()
                Color.gray.ignoresSafeArea()
    //content
                VStack(alignment: showCommentsSection ? .center : .leading) {
                    Image("image33")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: showCommentsSection ? 100 : .infinity)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                showCommentsSection = false
                            }
                        }
    //                display fullscren zoom view like twitter
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("content.username")
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                                .opacity(0.75)
                            
                            Text("content.details")
                                .font(.system(size: 15))
                                .foregroundColor(.white.opacity(1.0))
                        }
                        .frame(width: .infinity)
                        .padding(.horizontal, showCommentsSection ? 18 : 6)
                    .foregroundColor(.white)
                        Spacer()
                        
                        Button(action:{
    //                        options button
                        }) {
                            Image(systemName: "option")
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                    
                    if showCommentsSection {
                        ScrollView(showsIndicators: false) {
                            ForEach(0..<10, id: \.self) { _ in
                                Text("Sample comme cjhs ajsh jcs jh csajh asjch ajsch sacjh ascj sacjlhas cjlh csajh asc ascjlh sacjh ascj asc ascl ahskc hnt")
                                    .foregroundColor(.white)
                                    .padding()
                                
                                Divider()
                                    .background(Color.white.opacity(1.0))
                                    .padding(.horizontal, 60)
                            }
                            .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(.white, lineWidth: 0.75)
                                .frame(width: .infinity)
                            )
                            .padding(.horizontal, 6)
                        }
                        .frame(width: .infinity)
                        .padding(6)
//                        .transition(.move(edge: .bottom))
                    }
                    Spacer()
                }
                .padding(.top, 60)
    //            blur
                VStack {
                    Spacer()
                    VariableBlurView()
                        .frame(width: .infinity)
                        .frame(height: 100)
                        .rotationEffect(.degrees(180))
                        .ignoresSafeArea()
                }
                .ignoresSafeArea()
    //            commentbar
                VStack {
                    Spacer()
                    HStack {
                            
                        if comments.count == 0  {
                            withAnimation(.spring()) {
                                LikesButton(isLiked: $isLiked, isSelfPost: isSelfPost, showLikes: $showLikes) // Use LikeButton here
                                    .background(
                                        ZStack {
                                            Blur(style: .dark)
                                                .cornerRadius(25)
                                                .frame(width: 45, height: 45)
                                                .opacity(isLiked ? 0.0 : 1.0)
                                        }
                                        
                                    )
                                    .padding(.leading)
                            }
                        }
                                Spacer()
                                
                                HStack(alignment: .bottom) {
                                    if showTextField {
                                        withAnimation(.spring()) {
                                            TextField("Add a comment...", text: $comments, axis: .vertical)
                                                .cornerRadius(8)
                                                .frame(height: 45)
                                                .padding(.leading)
                                        }
                                    }
                                        Button(action: {
                                            withAnimation(.spring()) {
                                                showTextField.toggle() // Toggle the visibility of the TextField
                                                showCommentsSection.toggle()  // Toggle the visibility of the comments section
                                            }
                                        }) {
                                            HStack(spacing: 0) {
                                                Text("\(commentCount)") // Comment count
                                                    .opacity(showTextField ? 0.0 : 1.0)
                                                Image(systemName: "bubble.right") // Comment image
                                                    .resizable()
                                                    .frame(width: 18, height: 18)
                                                    .padding(.leading, 6)
                                            }
                                            .padding(12)
                                        }
                                    
                                }
                                .background(
                                    
                                    Blur(style: .dark)
                                        .cornerRadius(25)
                                        .frame(height: 45)
                                        .opacity(showTextField ? 0.0 : 1.0)
                                    
                                )
                                .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(.white, lineWidth: 0.5)
                                    .opacity(showTextField ? 1.0 : 0.0)
                                )
                                .padding(.trailing, 18)
                                .padding(.leading, comments.count > 0 ? 18 : 0)
    //                            .padding(.bottom, 3)
                            }
                    .foregroundColor(.white)
                }
                .offset(y: 20)
    //            navbar
                VStack {
                    HStack {
                        Button(action:  {
                            presentationMode.wrappedValue.dismiss() // Dismiss the view
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .background(
                                    Blur(style: .dark)
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(20)
                                )
                                .padding()
                        }
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Text("142 Quotes")
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .background(
                                Blur(style: .dark)
                                    .cornerRadius(20)
                                    .frame(height: 40)
                            )
                        }
                        Spacer()
                        
                        Button(action:  {
                            
                        }) {
                            Image(systemName: "chevron.up")
                                .foregroundColor(.white)
                                .background(
                                    Blur(style: .dark)
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(20)
                                )
                                .padding()
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }



#Preview {
    PicContent()
}

struct LikesButton: View {
    @Binding var isLiked: Bool
    @State private var likeCount: Int = 347
    @State private var showLikeCount: Bool = false
    var isSelfPost: Bool
    @Binding var showLikes: Bool
    var body: some View {
        ZStack {
            if !showLikeCount {
                Button(action: {
                    withAnimation(.spring()) {
                        if !isLiked {
                            isLiked.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    showLikeCount = true
                                }
                            }
                        }
                    }
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(isLiked ? .white : .white.opacity(0.5))
                        .padding(.vertical, 15)
                        .padding(.horizontal, 15)
                }
                .transition(.scale)
                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0), value: isLiked)
            }
            // Show the like count by default if the post is the user's own post
            if showLikeCount || isSelfPost {
                Button(action: {
                    // Add your action here
                    withAnimation(.spring()) {
                        showLikes.toggle() // Toggle showLikes
                    }
                }) {
                    Text("\(likeCount) \(likeCount == 1 ? "Like" : "Likes")")
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .transition(.scale)
                        .animation(.easeInOut(duration: 0.4), value: showLikeCount)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 15)
                }
            }
        }
        // The like count is displayed by default when the post belongs to the current user
        .onAppear {
            if isSelfPost {
                showLikeCount = true
            }
        }
    }
}
