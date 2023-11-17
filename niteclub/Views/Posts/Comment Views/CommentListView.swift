//
//  CommentListView.swift
//  niteclub
//
//  Created by +++ on 11/20/23.
//

import SwiftUI

struct CommentListView: View {
    @ObservedObject var viewModel: CommentViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.comments, id: \.id) { comment in
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .top) {
                            // Comment Details
                            Image(comment.author.profilePicture)
                                .resizable()
                                .frame(width: 36, height: 60)
                                .cornerRadius(6)
                            
                            VStack(alignment: .leading) {
                                Text(comment.author.username) // Assuming User has a username property
                                    .fontWeight(.bold)
                                
                                Text(comment.text)
                                Text(TimeSinceFormatter.timeSince(from: comment.timestamp))
                                    .font(.caption)
                                    .foregroundColor(.gray)

                            }
                        }
                        .padding(.vertical)
                        

                        // Like and Reply Buttons
                        HStack {
                            
                            // Reply Button
                            Button("Reply") {
                                // Handle reply action
                            }
                            
                            Spacer()
                            
                            // Like Button with Count
                            Button(action: {
                                viewModel.likeComment(comment.id, by: sampleUser)
                            }) {
                                HStack {
                                    Image(systemName: "heart") // Heart icon
                                    Text("\(comment.likes.count)")
                                }
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
    CommentListView(viewModel: MockCommentViewModel())
}

struct MockData {
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
