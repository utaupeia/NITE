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
<<<<<<< HEAD
    @ObservedObject var postsVM: PostsViewModel
    @Binding var navigationPath: NavigationPath  // Add NavigationPath binding
    var namespace: Namespace.ID
    var onSelectPost: (PostViewModel) -> Void

    @State private var isVideoActive = true  // Add this line

    var body: some View {
        ZStack {
            switch viewModel.post.type {
            case .text:
                TextPostView(viewModel: viewModel, navigationPath: $navigationPath, onSelectPost: onSelectPost)
                    .matchedGeometryEffect(id: viewModel.id, in: namespace)

=======
    @Binding var navigationPath: NavigationPath  // Add NavigationPath binding
    
//    var onSelect: (Int) -> Void  // Closure to call when a post is selected

    var body: some View {
        VStack {

            switch viewModel.post.type {
            case .text:
                TextPostView(viewModel: viewModel, navigationPath: $navigationPath)
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
            case .image:
                ImagePostView(viewModel: viewModel, navigationPath: $navigationPath, onSelectPost: onSelectPost)
                    .matchedGeometryEffect(id: viewModel.id, in: namespace)

            case .video:
                VideoPostView(
                    viewModel: viewModel,
                    navigationPath: $navigationPath,
                    isActiveVideo: $isVideoActive,
                    onSelectPost: onSelectPost
                )
                .matchedGeometryEffect(id: viewModel.id, in: namespace)
//                .onAppear { isVideoActive = true }  // Play video on appear
//                .onDisappear { isVideoActive = false }  // Pause video on disappear
                

            default:
                EmptyView()
            }
        }
        .navigationDestination(for: User.self) { user in
            ProfileContentTabView(user: user, navigationPath: $navigationPath)
                // Provide necessary environment objects
                .environmentObject(UserViewModel())
                .environmentObject(viewModel)
                .environmentObject(postsVM.userViewModel)
                .onAppear {
                    postsVM.userViewModel.setUserByID(user.id)
                }
        }
    }
}

let quotedTextPost = Post(id: UUID(), author: sampleUser, timestamp: Date(), textContent: "This is the original post being quoted!", images: nil, videos: nil, socialInteractions: interactionsManager)

let textPost = Post(id: UUID(), author: sampleUser, timestamp: Date(), textContent: "This is an amazing text post!", images: nil, videos: nil, socialInteractions: interactionsManager)

let imagePost = Post(id: UUID(), author: sampleUser, timestamp: Date(), textContent: "Check out these images!", images: ["image21", "image2"], videos: nil, socialInteractions: interactionsManager)

let videoPost = Post(id: UUID(), author: sampleUser, timestamp: Date(), textContent: "Awesome video ahead!", images: nil, videos: ["videoUrl"], socialInteractions: interactionsManager)

let vidPost = SampleData.vidPost3

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
<<<<<<< HEAD
    PostView(
        viewModel: PostViewModel(post: vidPost, currentUser: sampleUser), postsVM: PostsViewModel(),
        navigationPath: .constant(NavigationPath()),
        namespace: Namespace().wrappedValue,
        onSelectPost: { _ in }
    )
=======
    PostView(viewModel: PostViewModel(post: textPost, currentUser: mockCurrentUser), navigationPath: .constant(NavigationPath()))
    //, onSelect: { _ in }
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
}

//
//#Preview {
//    
//    PostViewPreviewWrapper(viewModel: PostViewModel(post: textPost, currentUser: sampleUser), navigationPath: .constant(NavigationPath()))
//    //, onSelect: { _ in }
//}
