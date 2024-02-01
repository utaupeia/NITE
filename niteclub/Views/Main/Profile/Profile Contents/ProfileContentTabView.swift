//
//  ProfileContentTabView.swift
//  niteclub
//
//  Created by +++ on 10/31/23.
//

import SwiftUI
import AVKit

//MARK: HOW TO NAVIGATE TO THIS         ProfileContentTabView(user: getUserByID(userID), navigationPath: $navigationPath)

struct ProfileContentTabView: View {
    var user: User
<<<<<<< HEAD
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var postsViewModel: PostsViewModel
    @Binding var navigationPath: NavigationPath
    
    var userSpecificPosts: [PostViewModel] {
        postsViewModel.postViewModels.filter { $0.post.author.id == user.id }
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible(),spacing: nil, alignment: nil),
    ]
    @State private var showExtras = false
    @State private var showSettings = false
    
    @State private var isPlaying = false
    @State private var postText: String = "Sample Text"
    @State private var selectedIndex = 0

    let titles = ["feed", "pics", "vids", "themes", "likes"]
    @State private var showLikes = false
    
    @State private var blurHeight: CGFloat = 100
    @State private var isExpanded: Bool = false
    var maxHeight: CGFloat = UIScreen.main.bounds.height

    @Namespace private var tabAnimation

    var body: some View {
        ZStack {
            SelectedThemeView(viewModel: userViewModel)
            
            ZStack(alignment: .top) {
                
                TabView(selection: $selectedIndex) {
                    ProfilePostFeedView(allPosts: postsViewModel.postViewModels, user: user, navigationPath: $navigationPath)
                        .tag(0)
                    ProfileImageContentView(user: user, allImagePosts: postsViewModel.postViewModels)
                        .tag(1)
                    ProfileVideoContentView(
                        user: user,
                        navigationPath: $navigationPath
                    )
                        .tag(2)
                    ProfileThemeView(user: user)
                        .tag(3)
                    LikedPostsView(likedPosts: [samplePost], user: user)
                        .tag(4)
                }
                .environmentObject(postsViewModel)

                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                navBar

            }
=======
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
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
<<<<<<< HEAD
    var navBar: some View {
        VStack {
            ZStack(alignment: .top)  {
                
                VariableBlurView()
                
                if userViewModel.user?.id == user.id {
                    HStack(spacing: 0) {
                        Spacer()
                        profileTabBar
                        Spacer()
                    }
                    .padding(.top, 60)
                } else {
                    HStack(spacing: 0) {
                        backButton
                        
                        profileTabBar

                        Spacer()
                        
                        FollowButton(userViewModel: userViewModel, otherUser: user)

                        SettingsButton(showSettings: $showSettings)
                    }
                    .padding(.top, 60)
                }
                   
                    if isExpanded {
                        
                    }
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: blurHeight)
            Spacer()
        }
    }
=======
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
    
    var backButton: some View {
        Button(action: {
            withAnimation(.spring()) {
                postsViewModel.selectedUser = nil  // Deselect the user
                
                // Handle navigation back
                if !navigationPath.isEmpty {
                    navigationPath.removeLast()
                }
<<<<<<< HEAD
                presentationMode.wrappedValue.dismiss()

            }
        }) {
            Image(systemName: "chevron.backward")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 18)
                .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(.white.opacity(0.25), lineWidth: 1)
                )
                .padding(.vertical, 3)
                .padding(.horizontal, 15)
        }
    }
    var profileTabBar: some View {
        ScrollViewReader { reader in
            HStack(spacing: 6) { // Adjust spacing as needed
                ForEach(titles.indices, id: \.self) { index in
                    Button(action: {
                        withAnimation(.spring()) {
                            selectedIndex = index
                        }
                    }) {
                        
                        RoundedRectangle(cornerRadius: 24)
                            .fill(selectedIndex == index ? Color.white : Color.gray)
                            .frame(width: selectedIndex == index ? 30 : 10, height: 5)
                            .matchedGeometryEffect(id: "tab\(index)", in: tabAnimation)
                    }
                }
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: selectedIndex)
=======
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
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
            }
        }
    }
}

#Preview {
<<<<<<< HEAD
    ProfileContentTabView(user: SampleData.userJohn, navigationPath: .constant(NavigationPath()))
        .environmentObject(PostsViewModel())
        .environmentObject(UserViewModel())
=======
    ProfileContentTabView(user: sampleUser, navigationPath: .constant(NavigationPath()))
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
}
