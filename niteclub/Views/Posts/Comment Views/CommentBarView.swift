//
//  CommentBarView.swift
//  niteclub
//
//  Created by +++ on 11/20/23.
//

import SwiftUI

struct CommentBarView: View {
    @ObservedObject var viewModel: CommentViewModel
    @State private var commentText: String = ""
    @State private var isTextFieldVisible: Bool = false

    @Binding var showComments: Bool
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                if isTextFieldVisible {
                    withAnimation(.spring()) {
                        TextField("Add a comment...", text: $commentText, axis: .vertical)
                            .cornerRadius(8)
                            .padding()
                    }
                }
//                if commentText.count > 0 {
//                    Button(action: postComment) {
//                        Text("Post")
//                    }
//                } else {
                    Button(action: {
                        withAnimation(.spring()) {
                            if commentText.count > 0 {
                                postComment()
                            } else {
                                isTextFieldVisible.toggle() // Toggle the visibility of the TextField
                            }
                                
                            showComments.toggle()  // Toggle the visibility of the comments section
                        }
                    }) {
                        HStack(spacing: 0) {
                            Text("\(viewModel.commentsCount)")
                                .opacity(commentText.count > 0 ? 0.0 : 1.0)
                            Image(systemName: commentText.count > 0 ? "arrow.merge" : "bubble.right") // Comment image
                                .resizable()
                                .frame(width: 18, height: 18)
                                .padding(.leading, 6)
                        }
                        .foregroundColor(.gray)
                        .padding(12)
                    }
                    
                
            }
            .background(
                
                Blur(style: .dark)
                    .cornerRadius(25)
                    .frame(height: 45)
                    .opacity(isTextFieldVisible ? 0.0 : 1.0)
                
            )
            .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(.gray, lineWidth: 0.5)
                .opacity(isTextFieldVisible ? 1.0 : 0.0)
            )
            .padding(.trailing, 18)
            .padding(.leading, viewModel.commentsCount > 0 ? 18 : 0)

        }
    }

    private func postComment() {
        let newComment = Comment(author: sampleUser, text: commentText, timestamp: Date())
        viewModel.addComment(newComment)
        commentText = "" // Reset comment text
        isTextFieldVisible = false // Hide the text field again
    }
}

let mockCommentViewModel = MockCommentViewModel()

struct CommentBarView_Previews: PreviewProvider {
    @State static var showComments = false // Define a state within the preview provider

    static var previews: some View {
//        #Preview {
            CommentBarView(viewModel: MockCommentViewModel(), showComments: $showComments)
//        }
    }
}

