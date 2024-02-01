//
//  CommentListView.swift
//  niteclub
//
//  Created by +++ on 11/20/23.
//

import SwiftUI

struct CommentListView: View {
    @ObservedObject var postViewModel: PostViewModel

    var body: some View {
        ScrollView {
            VStack {
                ForEach(postViewModel.post.socialInteractions.comments, id: \.id) { comment in
                    VStack(alignment: .leading) {
                        
                        CommentView(comment: comment)

                        // Like and Reply Buttons
                        HStack {
                            
                            // Reply Button
                            Button("Reply") {
                                // Handle reply action
                            }
                            .padding(6)

                            
                            Spacer()
                            
                            // Like Button with Count
                            Button(action: {
//                                viewModel.likeComment(comment.id, by: sampleUser)
                            }) {
                                HStack {
                                    Image(systemName: "heart") // Heart icon
                                    Text("\(comment.likes.count)")
                                        .monospaced()
                                }
                                .padding(6)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .font(.caption)
                        .padding()

                        Divider()

                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()


#Preview {
    CommentListView(postViewModel: PostViewModel(post: SampleData.emmaImagePost, currentUser: SampleData.bobby))
}

struct MockData {
    static let comment: Comment = Comment(author: SampleData.donna, text: "Great post!", timestamp: Date())

    
    static let comments: [Comment] = [
        Comment(author: User(username: "sampleguy", profilePicture: "image33", selectedTheme: sampleTheme, dateJoined: Date(), location: "az"), text: "Great post!", timestamp: Date()),
        Comment(author: User(username: "otherfella", profilePicture: "image23", selectedTheme: sampleTheme, dateJoined: Date(), location: "ny"), text: "I completely agree!", timestamp: Date()),
        // Add more mock comments as needed
    ]
}

class MockCommentViewModel: CommentViewModel {
    override init() {
        super.init()
        self.comments = MockData.comments
    }
}

// You can also directly initialize the comments in CommentViewModel for the sake of preview.
