//
//  CommentBar.swift
//  niteclub
//
//  Created by +++ on 11/15/23.
//

import SwiftUI

struct CommentBar: View {
<<<<<<< HEAD
    @ObservedObject var postViewModel: PostViewModel
    @State private var newComment: String = ""

    var body: some View {
        HStack {
            HStack(alignment: .bottom) {
                TextField("Comment...", text: $newComment, axis: .vertical)
                    .foregroundColor(.white)
                
                if newComment.count > 0 {
                    Button(action: {
                        // 1 // dimiss text field
                        // 2 // send comment to array
                        //                    viewModel.addReplyToCurrentPost(newReply)
                        //                    newReply = ""
                        if let currentUser = SessionManager.shared.currentUser {
                            postViewModel.commentOnPost(text: newComment, by: currentUser)
                            newComment = "" // Clear the text field
                        }

                    }) {
                        Image(systemName: "arrowshape.turn.up.forward.fill")
                            .resizable()
                            .foregroundColor(.white.opacity(0.75) )
                            .frame(width: 24,height: 18)
                        
                    }
                }
            }
            .padding(9)
            .background(
            RoundedRectangle(cornerRadius: 24)
                .stroke(.white,
                        lineWidth: 1)
        )
        }
    }
}
=======
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CommentBar()
}
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
