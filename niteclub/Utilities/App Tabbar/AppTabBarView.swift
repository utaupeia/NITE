//
//  AppTabBarView.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import SwiftUI

struct AppTabBarView: View {
    @State private var selection: String = "profile"
    @State private var tabSelection: TabBarItem = .profile
    @StateObject private var tabBarState = TabBarState()
    @StateObject var userviewModel = UserViewModel(user: sampleUser)
    @State private var discoselection = 0 // This will be passed to DiscoTabView
    @StateObject private var postsViewModel = PostsViewModel()
    @StateObject private var engagementViewModel = SharedViewModel()
    var body: some View {
        
        ZStack {
//            SelectedThemeView(theme: userviewModel.user.selectedTheme)

            TabBarContainerView(selection: $tabSelection, userViewModel: userviewModel) {

                CreatePostView(viewModel: CreatePostViewModel())
                    .ignoresSafeArea()
                    .tabBarItem(tab: .create, selection: $tabSelection)

                DiscoTabView(selection: $discoselection)
                    .ignoresSafeArea()
                    .tabBarItem(tab: .disco, selection: $tabSelection)

                ProfileContentTabView(user: sampleUser, navigationPath: .constant(NavigationPath()))
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
        }
    }
}

#Preview {
    AppTabBarView()
}
