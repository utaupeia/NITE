//
//  StoriesScrollView.swift
//  niteclub
//
//  Created by +++ on 1/8/24.
//

import SwiftUI

class SharedStoryState: ObservableObject {
    @Published var currentStoryIndex: Int = 0
    @Published var isExpanded: Bool = false
}

struct StoriesScrollView: View {
    @ObservedObject var storiesViewModel: StoriesViewModel
    @ObservedObject var sharedStoryState: SharedStoryState

    @State private var isExpanded: Bool = false
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(storiesViewModel.stories.indices, id: \.self) { index in
                        let storyVM = storiesViewModel.stories[index]
                        let postVM = storyVM.storyPostViewModels[storyVM.currentIndex] // Use updated currentIndex
                        let allPostsViewed = storyVM.allPostsViewed()
                        let postIndexToShow = storyVM.firstUnviewedPostIndex()

                        VStack(alignment: .leading) {
//                            StoryPostView(viewModel: postVM)
                            
                            StoryPostView(viewModel: storyVM.storyPostViewModels[postIndexToShow])
                                .id("storyThumbnail-\(storyVM.id)-\(postIndexToShow)")
                                .scaledToFill()
                                .frame(width: 96, height: 160)
                                .cornerRadius(12)
                                .matchedGeometryEffect(id: postVM.storyPost.id, in: animation)
                                .padding(6)
                                .background(
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(borderColor(for: postVM.storyPost),
                                                lineWidth: 3)
                                )
                                .opacity(allPostsViewed ? 0.25 : 1.0)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                                        sharedStoryState.isExpanded = true
                                        sharedStoryState.currentStoryIndex = index
//                                        storiesViewModel.currentStoryIndex = index
                                        let firstUnviewedIndex = storiesViewModel.stories[index].firstUnviewedPostIndex()
                                        storiesViewModel.stories[index].currentIndex = firstUnviewedIndex
                                    }
                                }
 
                            Text(storyVM.story.author.username)
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.leading, 6)
                        }

                        
                    }

                }
                .padding(.all)
            }
            .onReceive(storiesViewModel.$refreshTrigger) { _ in

                // Add logic here to refresh the view
            }

            if storiesViewModel.currentStoryIndex < storiesViewModel.stories.count, isExpanded {
                let selectedStoryVM = storiesViewModel.stories[storiesViewModel.currentStoryIndex]
                ExpandedStoryView(viewModel: selectedStoryVM, storiesViewModel: storiesViewModel, isExpanded: $isExpanded, animation: animation) // Add storiesViewModel here
            }
            
        }
    }
    // Function to return color based on StoryPost status
    private func borderColor(for post: StoryPost) -> Color {
        if post.isCloseFriendPost {
            return .pink // Pink for close friends
        } else {
            return colorForUserStatus(post.author.status)
        }
    }

    // Function to return color based on UserStatus
    private func colorForUserStatus(_ status: UserStatus) -> Color {
        switch status {
        case .default:
            return .white
        case .member, .foreverMember, .admin:
            return .blue
        }
    }

}


// ExpandedStoryView is the full-screen view that will be presented
struct ExpandedStoryView: View {
    @ObservedObject var viewModel: StoryViewModel
    @ObservedObject var storiesViewModel: StoriesViewModel // Pass the same StoriesViewModel
    @Binding var isExpanded: Bool
    var animation: Namespace.ID
    
    @State private var showPopup = false
    @State private var selectedTab: PopupTab = .views

    var body: some View {
        ZStack {
            // Your fullscreen story presentation logic here
            // For now, let's display a placeholder
            Blur(style: .dark).ignoresSafeArea()
                .onTapGesture {
                    isExpanded = false
                    let currentStoryVM = storiesViewModel.stories[storiesViewModel.currentStoryIndex]
                    if currentStoryVM.currentIndex < currentStoryVM.storyPostViewModels.count {
                        // Complete the progress of the current post
                        currentStoryVM.completeProgressForCurrentPost()
                        // Other logic...
                    }
                    storiesViewModel.stories[storiesViewModel.currentStoryIndex].completeProgressForCurrentPost()

                }
            
            ForEach(viewModel.storyPostViewModels.indices, id: \.self) { index in
                if index == viewModel.currentIndex {
                    StoryPostView(viewModel: viewModel.storyPostViewModels[index])
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .id(UUID()) // Force refresh the view when currentIndex changes
                        .onAppear {
                            // Start progress for the currently indexed post
                            viewModel.startProgressForCurrentPost()
                            
                            // Get the current post based on currentIndex
                            let currentPost = viewModel.storyPostViewModels[index].storyPost
                            
                            // Mark the current post as viewed
                            if viewModel.currentIndex == index {
                                viewModel.markPostAsViewed(currentPost)
                                print("Post Viewed: \(currentPost.id), Index: \(index)")
                            }
                            

                        }
                    
                        .gesture(
                            LongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity)
                                .onChanged { _ in viewModel.pauseProgress() }
                                .onEnded { _ in viewModel.resumeProgress() }
                        )
                }
            }

            
            VStack {
                HStack(alignment: .top,spacing: 0) {
                    Button(action: { withAnimation(.spring()) { isExpanded = false }
}){
                     Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(6)
                    }
                    .background(
                    Circle()
                        .stroke(.white.opacity(0.5))
                    )
                    .padding(.trailing, 6)
                    
                    MenuButtonView(viewModel: viewModel,
                        onDelete: {
                            // Handle delete action
                        },
                        onReport: {
                            // Handle report action
                        },
                        onUnfollow: {
                            // Handle unfollow action
                        })
                    .preferredColorScheme(.dark) // This enforces dark mode for the entire view

                    Text(viewModel.remainingTimeForCurrentPost)
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(
                        Circle()
                            .stroke(.white.opacity(0.5))
                        )
                        .padding(.horizontal, 6)

                    
                    Spacer()
                    VStack(alignment: .trailing) {
                        
                        Image(viewModel.story.author.profilePicture)
                            .resizable()
                            .frame(width: 48, height: 80)
                            .cornerRadius(9)
                        Text(viewModel.story.author.username)
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                    }
                }
                .padding(.horizontal)

                Spacer()
                
                if viewModel.story.author.id == viewModel.currentUser.id {
                    
                    LikesRepliesPopupView(viewModel: viewModel, selectedTab: $selectedTab, showPopup: $showPopup)
                        .padding(.horizontal)
                } else {
                    LikesAndCommentsView(viewModel: viewModel)
                }
                StoryProgressBar(numberOfPosts: viewModel.storyPostViewModels.count, progress: viewModel.progressArray)
                    .padding(.horizontal)
            }


        }
        .overlay(
            HStack {
                Color.clear
                    .frame(width: 70, height: 400) // Adjust the width as needed
                    .contentShape(Rectangle())
                    .onTapGesture {
                        // Call moveToPreviousPost
                        viewModel.moveToPreviousPost()
                    }
                
                Spacer()
                // Right side tap area for next post
                Color.clear
                    .frame(width: 70, height: 400) // Adjust the width as needed
                    .contentShape(Rectangle())
                    .onTapGesture {
//                        viewModel.moveToNextPost()
                        viewModel.fastForwardProgress()

                    }

            }
        )
        .sheet(isPresented: $showPopup) {
            PopupView(selectedTab: $selectedTab, viewModel: viewModel)
        }

        
    }
}


struct StoriesScrollView_Previews: PreviewProvider {
    static var previews: some View {
        // Assuming SampleData.sampleStories is an array of Story objects
        let stories = SampleData.sampleStories
        let currentUser = SampleData.userJohn  // Ensure this is a User object

        // Initialize StoriesViewModel with the array of Story objects and a currentUser
        let storiesViewModel = StoriesViewModel(stories: stories, currentUser: currentUser)
        let sharedStoryState = SharedStoryState() // Initialize SharedStoryState

        // Return the StoriesScrollView with the initialized storiesViewModel
        return StoriesScrollView(storiesViewModel: storiesViewModel, sharedStoryState: sharedStoryState)
    }
}

struct StoryProgressBar: View {
    var numberOfPosts: Int
    var progress: [Double] // Array of progress values for each post, starts at 1 (100%) and decreases to 0 (0%)

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<numberOfPosts, id: \.self) { index in
                GeometryReader { geometry in
                    ZStack(alignment: .trailing) {
                        // Gray bar (background)
                        RoundedRectangle(cornerRadius: 4)
                            .frame(height: 4)
                            .foregroundColor(.gray)

                        // White bar (shrinking foreground)
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: geometry.size.width * CGFloat(1 - progress[index]), height: 4)
                            .foregroundColor(.white)
                            .animation(.linear(duration: 0.1), value: progress[index])
                    }
                }
                .frame(height: 4)
            }
        }
        .padding(.horizontal, 12)
    }
}

enum PopupTab {
    case views, likes, replies
}

struct PopupView: View {
    @Binding var selectedTab: PopupTab
    var viewModel: StoryViewModel

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Views: \(viewModel.storyPostViewModels[viewModel.currentIndex].storyPost.viewCount)")
                .tabItem { Label("Views", systemImage: "eye") }
                .tag(PopupTab.views)

            Text("Likes: \(viewModel.storyPostViewModels[viewModel.currentIndex].storyPost.likeCount)")
                .tabItem { Label("Likes", systemImage: "heart") }
                .tag(PopupTab.likes)

            Text("Replies: \(viewModel.storyPostViewModels[viewModel.currentIndex].storyPost.replies.count)")
                .tabItem { Label("Replies", systemImage: "message") }
                .tag(PopupTab.replies)
        }
    }
}

struct LikesAndCommentsView: View {
    @ObservedObject var viewModel: StoryViewModel
    @State private var showCommentField = true
    @State private var newReply: String = ""
// TODO: Make it so that when User is Replying, the Timer Pauses
    var body: some View {
        HStack {
            // Like Button
            Button(action: {
                viewModel.toggleLikeByUser()
            }) {
                Image(systemName: viewModel.isLikedByCurrentUser ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 24,height: 20)
                    .foregroundColor(viewModel.isLikedByCurrentUser ? .red : .white)
            }

            Spacer()

            HStack(alignment: .bottom) {
                TextField("Reply...", text: $newReply, axis: .vertical)
                    .foregroundColor(.white)
                Button(action: {
                    viewModel.addReplyToCurrentPost(newReply)
                    newReply = ""
                }) {
                    Image(systemName: "message")
                        .resizable()
                        .foregroundColor(newReply.count > 0 ? .white.opacity(1.0) : .white.opacity(0.5))
                        .frame(width: 24,height: 20)

                }
            }
            .padding(9)
            .background(
            RoundedRectangle(cornerRadius: 24)
                .stroke(viewModel.isLikedByCurrentUser ? .red : .white,
                        lineWidth: 1)
        )
            .padding(6)
                
        }
        .padding()
        .animation(.default, value: showCommentField)
    }
}

struct LikesRepliesPopupView: View {
    @ObservedObject var viewModel: StoryViewModel
    @Binding var selectedTab: PopupTab
    @Binding var showPopup: Bool

    var body: some View {
        HStack {
            // Likes Button
            Button("\(viewModel.storyPostViewModels[viewModel.currentIndex].storyPost.likeCount) Likes") {
                self.selectedTab = .likes
                self.showPopup = true
            }
            .foregroundColor(.white)
            .padding()

            Spacer()
            
            // Replies Button
            Button("\(viewModel.storyPostViewModels[viewModel.currentIndex].storyPost.replies.count) Replies") {
                self.selectedTab = .replies
                self.showPopup = true
            }
            .foregroundColor(.white)
            .padding()
        }
    }
}

extension StoryViewModel {
    var isLikedByCurrentUser: Bool {
        storyPostViewModels[currentIndex].storyPost.likes.contains(where: { $0.id == currentUser.id })
    }

    func toggleLikeByUser() {
        storyPostViewModels[currentIndex].toggleLikeBy(user: currentUser)
    }

    func addReplyToCurrentPost(_ comment: String) {
        let newReply = Reply(user: currentUser, message: comment, timePosted: Date())
        storyPostViewModels[currentIndex].addReply(newReply)
    }
}

struct MenuButtonView: View {
    @ObservedObject var viewModel: StoryViewModel
    var onDelete: () -> Void
    var onReport: () -> Void
    var onUnfollow: () -> Void

    var body: some View {
        Menu {
            if viewModel.story.author.id == viewModel.currentUser.id {
                Button("Delete", action: onDelete)
            } else {
                Button("Report", action: onReport)
                Button("Unfollow", action: onUnfollow)
            }
        } label: {
            Image(systemName: "ellipsis")
                .resizable()
                .frame(width: 10,height: 2)
                .foregroundColor(.white)
                .rotationEffect(.degrees(90))
                .imageScale(.large)
                .padding(13)
                .background(
                Circle()
                    .stroke(.white.opacity(0.5))
                )
                .padding(.horizontal, 6)

        }
        
    }
}




