//
//  AppTabBarView.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import SwiftUI
import AVKit

struct AppTabBarView: View {
    @State private var selection: String = "profile"
    @State private var tabSelection: TabBarItem = .profile
    @StateObject private var tabBarState = TabBarState()
<<<<<<< HEAD
    @StateObject var userviewModel = UserViewModel()
    @State private var discoselection = 0 // This will be passed to DiscoTabView
    @StateObject private var postsViewModel = PostsViewModel()
    @StateObject private var storiesViewModel = StoriesViewModel(stories: SampleData.sampleStories, currentUser: SampleData.userJohn)
    @StateObject private var sharedStoryState = SharedStoryState()
    @StateObject private var engagementViewModel = SharedViewModel()
=======
    @StateObject var userviewModel = UserViewModel(user: sampleUser)
    @State private var discoselection = 0 // This will be passed to DiscoTabView
    @StateObject private var postsViewModel = PostsViewModel()

>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
    var body: some View {
        
        ZStack {
//            SelectedThemeView(theme: userviewModel.user.selectedTheme)
            SelectedThemeView(viewModel: userviewModel)

            TabBarContainerView(selection: $tabSelection, userViewModel: UserViewModel(user: SampleData.userJohn)) {

<<<<<<< HEAD
                CreatePostView(viewModel: CreatePostViewModel(currentUser: SampleData.userJohn), adViewModel: AdViewModel())
                    .ignoresSafeArea()
                    .tabBarItem(tab: .create, selection: $tabSelection)

                DiscoTabView()
                    .ignoresSafeArea()
                    .tabBarItem(tab: .disco, selection: $tabSelection)
=======
            DiscoTabView(selection: $discoselection)
                .ignoresSafeArea()
                .tabBarItem(tab: .disco, selection: $tabSelection)

            ProfileContentTabView(user: sampleUser, navigationPath: .constant(NavigationPath()))
                .ignoresSafeArea()
                .tabBarItem(tab: .profile, selection: $tabSelection)
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee

                ProfileContentTabView(user: SampleData.userJohn, navigationPath: .constant(NavigationPath()))
                    .ignoresSafeArea()
                    .tabBarItem(tab: .profile, selection: $tabSelection)

                NotificationView()
                    .ignoresSafeArea()
                    .tabBarItem(tab: .notifs, selection: $tabSelection)

                RadioView()
                    .ignoresSafeArea()
                    .tabBarItem(tab: .radio, selection: $tabSelection)

            }
            .environmentObject(tabBarState)
            .environmentObject(postsViewModel) 
            .environmentObject(engagementViewModel)
            .environmentObject(userviewModel)
            .environmentObject(storiesViewModel)
            .environmentObject(sharedStoryState)
        }
<<<<<<< HEAD
=======
        .environmentObject(tabBarState)
        .environmentObject(postsViewModel) // PostsViewModel to DiscoTabView + Children

>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
    }
}

#Preview {
    AppTabBarView()
}
