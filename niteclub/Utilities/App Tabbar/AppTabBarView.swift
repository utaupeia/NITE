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
    
    var body: some View {
        
        TabBarContainerView(selection: $tabSelection) {

            CreatePostView()
                .ignoresSafeArea()
                .tabBarItem(tab: .create, selection: $tabSelection)

            DiscoMainView()
                .ignoresSafeArea()
                .tabBarItem(tab: .disco, selection: $tabSelection)

            ProfileContentView()
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
    }
}

#Preview {
    AppTabBarView()
}
