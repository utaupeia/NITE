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
    @StateObject var userviewModel = UserViewModel()
    @State private var discoselection = 0 // This will be passed to DiscoTabView
    @StateObject private var postsViewModel = PostsViewModel()
    @StateObject private var storiesViewModel = StoriesViewModel(stories: SampleData.sampleStories, currentUser: SampleData.userJohn)
    @StateObject private var sharedStoryState = SharedStoryState()
    @StateObject private var engagementViewModel = SharedViewModel()
    var body: some View {
        
        ZStack {
//            SelectedThemeView(theme: userviewModel.user.selectedTheme)
            SelectedThemeView(viewModel: userviewModel)

            TabBarContainerView(selection: $tabSelection, userViewModel: UserViewModel(user: SampleData.userJohn)) {

                CreatePostView(viewModel: CreatePostViewModel(currentUser: SampleData.userJohn), adViewModel: AdViewModel())
                    .ignoresSafeArea()
                    .tabBarItem(tab: .create, selection: $tabSelection)

                DiscoTabView()
                    .ignoresSafeArea()
                    .tabBarItem(tab: .disco, selection: $tabSelection)

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
    }
}

#Preview {
    AppTabBarView()
}
