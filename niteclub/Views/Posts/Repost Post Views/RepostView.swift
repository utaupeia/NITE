//
//  RepostView.swift
//  niteclub
//
//  Created by +++ on 10/31/23.
//

import SwiftUI

struct RepostView: View {
    @ObservedObject var viewModel: PostViewModel
    @State private var selectedPostIndex: Int?

    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            HStack {
                Image(systemName: "arrow.triangle.2.circlepath") // Choose your desired system image
                    .resizable()
                    .frame(width: 16, height: 14) // Adjust the size as needed
                Text("\(viewModel.post.repostedBy?.username ?? "user")")
            }
            .padding(3)

            PostView(viewModel: PostViewModel(post: quote.post, currentUser: mockCurrentUser), navigationPath: .constant(NavigationPath()))
        }
        .padding()
        .cornerRadius(8)
    }
}
let quotingUser = User(id: UUID(), username: "Quoter", profilePicture: "sampleImage2", selectedTheme: sampleTheme, dateJoined: Date(), location: "Mars")
let quote = Quote(id: UUID(), post: originalPost, quotingUser: quotingUser, quoteText: "This is the quote text", timestamp: Date())


let originalAuthor = User(id: UUID(), username: "OriginalAuthor", profilePicture: "image4", selectedTheme: sampleTheme, dateJoined: Date(), location: "Earth")
let repostingUser = User(id: UUID(), username: "Reposter", profilePicture: "sampleImage2", selectedTheme: sampleTheme, dateJoined: Date(), location: "Mars")

let originalPost = Post(id: UUID(), author: originalAuthor, timestamp: Date(), textContent: "This is the original post content!", images: nil, videos: nil, socialInteractions: interactionsManager)

#Preview {
    RepostView(viewModel: viewModel)
}
