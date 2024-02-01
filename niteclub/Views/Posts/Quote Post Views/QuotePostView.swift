//
//  QuotePostView.swift
//  niteclub
//
//  Created by +++ on 10/31/23.
//

import SwiftUI

struct QuotePostView: View {
    var quote: Quote
<<<<<<< HEAD
    var quotedPostViewModel: PostViewModel
    var namespace: Namespace.ID
    var onSelectPost: (PostViewModel) -> Void
=======
    @State private var selectedPostIndex: Int?
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee

    var body: some View {
        VStack(spacing: 0) {

            HStack(alignment: .top) {
                
                // button links to profile
                Image(quote.quotingUser.profilePicture)
                    .resizable()
                    .frame(width: 36, height: 60)
                    .cornerRadius(6)

                VStack(alignment: .leading) {
                    
                    HStack {
                        Text(quote.quotingUser.username)
                                .font(.system(size: 12))
                                .fontWeight(.bold)
                                .foregroundColor(.black.opacity(0.75))
                        
                        Spacer()
                        
                        Text(viewModel.time)
                            .font(.system(size: 10))
                            .foregroundColor(.white.opacity(0.5))
                            .padding(.horizontal, 6)

                    }
                        
                    Text(quote.quoteText)
                        .font(.system(size: 13))
                        .fontWeight(.regular)
                        .foregroundColor(.black.opacity(1.0))
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(.bottom, 20)
            
<<<<<<< HEAD
            PostView(
                            viewModel: quotedPostViewModel,
                            postsVM: PostsViewModel(), // new
                            navigationPath: .constant(NavigationPath()),
                            namespace: namespace,
                            onSelectPost: onSelectPost
                        )
=======
            PostView(viewModel: PostViewModel(post: quote.post, currentUser: mockCurrentUser), navigationPath: .constant(NavigationPath()))
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 18)
            .stroke(.black, lineWidth: 0.75))
        .padding()
    }
}

let sampleQuote = Quote(post: samplePost, quotingUser: sampleUser, quoteText: "This is a sample quote. this post sucks ass im quoting your post just to let you know this shit sucks", timestamp: Date())

struct QuotePostView_Previews: View {
    @Namespace var previewNamespace

    var body: some View {
        QuotePostView(
            quote: sampleQuote,
            quotedPostViewModel: mockPostViewModel,
            namespace: previewNamespace,
            onSelectPost: { _ in }
        )
    }
}


#Preview {
    QuotePostView_Previews()
}
