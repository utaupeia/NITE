//
//  CommentBarView.swift
//  niteclub
//
//  Created by +++ on 11/20/23.
//

import SwiftUI

struct CommentButton: View {
    @ObservedObject var postViewModel: PostViewModel
    @State private var isTextFieldVisible: Bool = false
    @Binding var showComments: Bool
    
    var body: some View {
        VStack {
            Button(action: {withAnimation(.spring()) {
                showComments.toggle()
            }
            }) {
                HStack(spacing: 0) {
                    if postViewModel.post.socialInteractions.comments.count > 0 {
                        Text("\(postViewModel.post.socialInteractions.comments.count)")
                            .monospaced()
                    }
                    Image(systemName: "message.badge")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .padding(.leading, 6)
                }
                .foregroundColor(showComments ? .white : .white.opacity(0.5))
                .padding(12)
            }
        }
    }
}

let mockCommentViewModel = MockCommentViewModel()

struct CommentBarView_Previews: PreviewProvider {
    @State static var showComments = false // Define a state within the preview provider

    static var previews: some View {
//        #Preview {
        CommentButton(postViewModel: PostViewModel(post: SampleData.emmaImagePost, currentUser: SampleData.bobby), showComments: $showComments)
//        }
    }
}

