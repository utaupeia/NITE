//
//  ProfileContentTabView.swift
//  niteclub
//
//  Created by +++ on 10/31/23.
//

import SwiftUI

struct ProfileContentTabView: View {
    var user: User
    @EnvironmentObject var postsViewModel: PostsViewModel  // Inject PostsViewModel
    @Binding var navigationPath: NavigationPath            // NavigationPath binding

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
            Color.gray
            ZStack(alignment: .top) {
               
                TabView(selection: $selectedTabIndex) {
                    ProfilePostFeedView(posts: [imagePostVM, textPostVM], user: sampleUser)
                        .tag(0)
                    ProfileImageContentView(user: sampleUser)
                        .tag(1)
                    ProfileVideoContentView(user: sampleUser)
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
                    backButton
                        .padding(.top, 60)

                    Spacer()
                }
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
            Image(systemName: "arrow.left")  // Example back arrow icon
            Text("Back")
        }
        .padding()

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
    ProfileContentTabView(user: sampleUser, navigationPath: .constant(NavigationPath()))
}
