//
//  CommentViewModel.swift
//  niteclub
//
//  Created by +++ on 11/20/23.
//

import Foundation

class CommentViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    
    func addComment(_ comment: Comment) {
        comments.append(comment)
    }

    var commentsCount: Int {
        comments.reduce(0) { $0 + 1 + countReplies(in: $1) }
    }
    
    private func countReplies(in comment: Comment) -> Int {
        // Recursive function to count replies and nested replies
        return comment.replies.reduce(0) { $0 + 1 + countReplies(in: $1) }
    }

    func addReply(to commentId: UUID, reply: Comment) {
        // Find the comment in the array and add the reply to its replies array.
        // This is a simplified example. You might need to handle nested replies or other complexities.
        if let index = comments.firstIndex(where: { $0.id == commentId }) {
            comments[index].replies.append(reply)
        }
    }

    func likeComment(_ commentId: UUID, by user: User) {
        // Logic to add a user to the likes array of a comment
        if let index = comments.firstIndex(where: { $0.id == commentId }) {
            comments[index].likes.append(user)
        }
    }

}

