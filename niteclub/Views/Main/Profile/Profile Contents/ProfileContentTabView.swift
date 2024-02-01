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
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
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
    
    var backButton: some View {
        Button(action: {
            withAnimation(.spring()) {
                postsViewModel.selectedUser = nil  // Deselect the user
                
                // Handle navigation back
                if !navigationPath.isEmpty {
                    navigationPath.removeLast()
                }
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
            }
        }
    }
}

#Preview {
    ProfileContentTabView(user: SampleData.userJohn, navigationPath: .constant(NavigationPath()))
        .environmentObject(PostsViewModel())
        .environmentObject(UserViewModel())
}
