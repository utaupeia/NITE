//
//  ProfileNavBar.swift
//  niteclub
//
//  Created by +++ on 12/10/23.
//

import SwiftUI

struct otherUserProfileNavBar: View {
    @ObservedObject var userViewModel: UserViewModel
    @State private var blurHeight: CGFloat = 100
    @State private var isExpanded: Bool = false

    @Binding var showSettings: Bool

//    var isCurrentUserProfile: Bool {
//        userViewModel.user.id == otherUser.id
//    }
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack {
                ZStack(alignment: .top)  {
                    
                    VariableBlurView()
                    
                    VStack {
                        
                            otherProfileNavitems(userViewModel: userViewModel,
                                                 showSettings: $showSettings)
                        
                        if isExpanded {
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: blurHeight)
                .ignoresSafeArea()
                Spacer()
            }
            
        }
    }
}
struct ProfileNavBar: View {
//    @ObservedObject var userViewModel: UserViewModel // ViewModel for the current user
//    var otherUser: User // The other user's data

    @State private var navigationPath = NavigationPath()
//    @Environment(\.presentationMode) var presentationMode
    @State private var showNavMenu: Bool = false // write longtap gesture to menu button
    @State private var blurHeight: CGFloat = 100
    @State private var isExpanded: Bool = false
    var maxHeight: CGFloat = UIScreen.main.bounds.height
    
// profile Nav
    @Binding var showExtras: Bool
    @Binding var showSettings: Bool
// other profile Nav


    @EnvironmentObject var tabBarState: TabBarState
    var body: some View {
        VStack {
            ZStack(alignment: .top)  {
                
                VariableBlurView()
                
                VStack {
                    ProfileNavitems(showExtras: $showExtras,
                                    showSettings: $showSettings) // Your own profile's nav items
                    
                    if isExpanded {
                        
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: blurHeight)
            .ignoresSafeArea()
            Spacer()
        }
    }
}

#Preview {
    ProfileNavBar(showExtras: .constant(false), showSettings: .constant(false)
    )
}

struct otherProfileNavitems: View {
    @ObservedObject var userViewModel: UserViewModel // ViewModel for the current user
    @Binding var showSettings: Bool

    var body: some View {
        HStack(spacing: 0)  {

            BackButton()

            Spacer()
            
//            FollowButton(userViewModel: userViewModel)

            SettingsButton(showSettings: $showSettings)

            
        }
        .padding(.top, 45)
    }
}

struct ProfileNavitems: View {
    @Binding var showExtras: Bool
    @Binding var showSettings: Bool
    var body: some View {
        HStack(spacing: 0)  {
            ExtrasButton(showExtras: $showExtras)
            Spacer()
            SettingsButton(showSettings: $showSettings)
        }
        .padding(.top, 45)    }
}
