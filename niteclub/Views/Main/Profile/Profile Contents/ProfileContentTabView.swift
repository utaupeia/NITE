//
//  ProfileContentTabView.swift
//  niteclub
//
//  Created by +++ on 10/31/23.
//

import SwiftUI

struct ProfileContentTabView: View {
    var user: User
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var postsViewModel: PostsViewModel
    @Binding var navigationPath: NavigationPath

    var userSpecificPosts: [PostViewModel] {
        postsViewModel.postViewModels.filter { $0.post.author.id == user.id }
    }

    let columns: [GridItem] = [
        GridItem(.flexible(),spacing: nil, alignment: nil),
    ]
    
    @State private var isPlaying = false
    @State private var postText: String = "Sample Text"
    @State private var selectedTabIndex: Int = 0
    let tabTitles = ["feed", "pics", "vids", "themes", "likes"]
    @State private var showLikes = false
    
    
    var body: some View {
        ZStack {
            SelectedThemeView(user: user)

            ZStack(alignment: .top) {
               
                
                TabView(selection: $selectedTabIndex) {
                    ProfilePostFeedView(allPosts: postsViewModel.postViewModels, user: user)
                        .tag(0)
                    ProfileImageContentView(user: SampleData.userRickkw, allImagePosts: postsViewModel.postViewModels)
                        .tag(1)
                    ProfileVideoContentView(user: sampleUser, allVideoPosts: postsViewModel.postViewModels)
                        .tag(2)
                    ProfileThemeView(user: sampleUser)
                        .tag(3)
                    LikedPostsView(likedPosts: [samplePost], user: sampleUser)
                        .tag(4)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                ProfileTabBar(titles: tabTitles, selectedIndex: $selectedTabIndex)
                    .padding(.top, 60)
                
                HStack {
                    if user.id != userViewModel.user.id {
                        
                    backButton
                        
                    Spacer()
                    
                    followButton
                    
                                        }

                }
                .padding(.top, 60)

            }
            
//            topContent()
                .foregroundColor(.white)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
    
    var backButton: some View {
        Button(action: {
            withAnimation(.spring()) {
                postsViewModel.selectedUser = nil  // Deselect the user
                
                // Handle navigation back
                if !navigationPath.isEmpty {
                    navigationPath.removeLast()
                }
            }
        }) {
            Image(systemName: "chevron.backward")
                .padding(12)
                .background(
                    Blur(style: .dark)
                        .cornerRadius(24)
                )
        }
        .padding()

    }
    
    var backButton2: some View {
        Button(action: {
            withAnimation(.spring()) {
                
            }
        }) {
            Image(systemName: "chevron.backward")
                .background(
                    Blur(style: .dark)
                        .frame(width: 30, height: 30)
                        .cornerRadius(24)
                )
        }
        .padding()

    }
    var followButton: some View {
        Button(action: {
            withAnimation(.spring()) {

            }
        }) {
            Text("follow")
                .font(.system(size: 12))
                .background(
                    Blur(style: .dark)
                        .frame(width: 80, height: 30)
                        .cornerRadius(24)
                )
                .padding()
        }
    }

}

struct ProfileTabBar: View {
    let titles: [String]
    @Binding var selectedIndex: Int
    @Namespace private var tabAnimation // Namespace for the animation
    var body: some View {
        ScrollViewReader { reader in
            HStack(spacing: 6) { // Adjust spacing as needed
                ForEach(Array(titles.enumerated()), id: \.offset) { index, title in
                    ZStack {
                        // This view represents the unselected state
                        if index != selectedIndex {
                            Circle()
                                .fill(Color.white.opacity(0.5))
                                .matchedGeometryEffect(id: "tab\(index)", in: tabAnimation, properties: .frame, anchor: .center, isSource: true)
                                .frame(width: 4, height: 4)
                        }
                        // This view represents the selected state
                        if index == selectedIndex {
                            Text(title)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                                .matchedGeometryEffect(id: "tab\(index)", in: tabAnimation, properties: .frame, anchor: .center, isSource: false)
                                .font(.system(size: 13))
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedIndex = index
                            reader.scrollTo(index, anchor: .center) // Scroll to the selected item
                        }
                    }
                }
            }
            .padding([.leading, .trailing], 20) // Adjust padding as needed
            .onChange(of: selectedIndex) { [selectedIndex] in
                withAnimation(.spring()) {
                    reader.scrollTo(selectedIndex, anchor: .center)
                }
            }
        }
    }
}

#Preview {
    ProfileContentTabView(user: SampleData.userJohn, navigationPath: .constant(NavigationPath()))
        .environmentObject(PostsViewModel())
        .environmentObject(UserViewModel(user: SampleData.userJohn))
}
