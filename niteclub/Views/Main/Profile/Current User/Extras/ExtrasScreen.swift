//
//  ExtrasScreen.swift
//  niteclub
//
//  Created by +++ on 12/2/23.
//

import SwiftUI

struct ExtrasScreen: View {
    var body: some View {
        ZStack {
            TabView {
                SubscriptionView()
                .tabItem { Text("subscription") }
                
                InviteView()
                    .tabItem { Text("Invite") }
                
                CreateThemeView()
                    .tabItem { Text("Theme") }
                
            }
            .tabViewStyle(PageTabViewStyle())
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ExtrasScreen()
}
