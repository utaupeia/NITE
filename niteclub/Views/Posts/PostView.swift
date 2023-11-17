//
//  PostView.swift
//  niteclub
//
//  Created by +++ on 10/21/23.
//

import SwiftUI

class SharedViewModel: ObservableObject {
    @Published var selectedPost: PostViewModel?
}

struct PostView: View {
    @ObservedObject var viewModel: PostViewModel
    @Binding var navigationPath: NavigationPath  // Add NavigationPath binding
    var namespace: Namespace.ID
    var onSelectPost: (PostViewModel) -> Void

//    var onSelect: (Int) -> Void  // Closure to call when a post is selected

    var body: some View {
        ZStack {
            switch viewModel.post.type {
            case .text:
                TextPostView(viewModel: viewModel, navigationPath: $navigationPath, onSelectPost: onSelectPost)
                    .matchedGeometryEffect(id: viewModel.id, in: namespace)

            case .image:
                ImagePostView(viewModel: viewModel, navigationPath: $navigationPath, onSelectPost: onSelectPost)
                    .matchedGeometryEffect(id: viewModel.id, in: namespace)

            case .video:
                VideoPostView(viewModel: viewModel)
                    .matchedGeometryEffect(id: viewModel.id, in: namespace)

            default:
                EmptyView()
            }
        }
        //            .matchedGeometryEffect(id: viewModel.postViewModels[index].id, in: namespace)

    }
}

let quotedTextPost = Post(id: UUID(), author: sampleUser, timestamp: Date(), textContent: "This is the original post being quoted!", images: nil, videos: nil, socialInteractions: interactionsManager)

let textPost = Post(id: UUID(), author: sampleUser, timestamp: Date(), textContent: "This is an amazing text post!", images: nil, videos: nil, socialInteractions: interactionsManager)

let imagePost = Post(id: UUID(), author: sampleUser, timestamp: Date(), textContent: "Check out these images!", images: ["image21", "image2"], videos: nil, socialInteractions: interactionsManager)

let videoPost = Post(id: UUID(), author: sampleUser, timestamp: Date(), textContent: "Awesome video ahead!", images: nil, videos: ["videoUrl"], socialInteractions: interactionsManager)

let textPostViewModel = PostViewModel(post: textPost, currentUser: mockCurrentUser)
let videoPostViewModel = PostViewModel(post: videoPost, currentUser: mockCurrentUser)

//struct PostView_Previews: PreviewProvider {
//    @Namespace static var namespace
//
//    static var previews: some View {
//        PostView(
//            viewModel: PostViewModel(post: samplePost, currentUser: sampleUser),
//            navigationPath: .constant(NavigationPath()),
//            namespace: namespace,
//            onSelectPost: { _ in }
//        )
//    }
//}
#Preview {
    PostView(
        viewModel: PostViewModel(post: samplePost, currentUser: sampleUser),
        navigationPath: .constant(NavigationPath()),
        namespace: Namespace().wrappedValue,
        onSelectPost: { _ in }
    )
}

//
//#Preview {
//    
//    PostViewPreviewWrapper(viewModel: PostViewModel(post: textPost, currentUser: sampleUser), navigationPath: .constant(NavigationPath()))
//    //, onSelect: { _ in }
//}
