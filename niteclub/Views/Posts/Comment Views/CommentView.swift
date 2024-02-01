//
//  CommentView.swift
//  niteclub
//
//  Created by +++ on 1/20/24.
//

import SwiftUI

struct CommentView: View {
    let comment: Comment
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .top) {
                // Comment Details
                // BUTTON TO NAV TO PROFILE
                Image(comment.author.profilePicture)
                    .resizable()
                    .frame(width: 36, height: 60)
                    .cornerRadius(6)
                
                VStack(alignment: .leading) {
                    // BUTTON TO NAV TO PROFILE
                    Text(comment.author.username) // Assuming User has a username property
                        .fontWeight(.bold)
                    
                    Text(comment.text)
                    HStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 20, height: 1)
                            .padding(.trailing, 3)
                            .foregroundColor(.white.opacity(0.5))
                        Text(TimeSinceFormatter.timeSince(from: comment.timestamp))
                            .font(.caption)
                        .foregroundColor(.gray)
                    }

                }
                
            }
            .padding(.vertical)

        }
    }
}

#Preview {
    CommentView(comment: MockData.comment)
}
