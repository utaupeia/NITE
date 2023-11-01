//
//  TabBarContainerView.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import SwiftUI

struct TabBarContainerView<Content:View>: View {
    @Binding var selection: TabBarItem

    let content: Content
    @State private var  tabs: [TabBarItem] = [
        .radio, .disco, .notifs, .profile, .create
    ]
    @State private var scale : CGFloat = 1
    
    init(selection: Binding<TabBarItem>, userViewModel: UserViewModel, @ViewBuilder content: @escaping () -> Content) {
        self._selection = selection
        self.userViewModel = userViewModel  // Now userViewModel is initialized here
        self.content = content()  // 'content' is set here after 'userViewModel' has been initialized.
    }

    
    @EnvironmentObject var tabBarState: TabBarState
    @ObservedObject var userViewModel: UserViewModel  // Your view model

//    let partyScreen = PartyScreen()
    
    @State private var containerAppeared: Bool = false
    
    @State private var dragOffset: CGFloat = 0
    
    // YOUR PROFILE :
    @State private var showEdit: Bool = false
    
    @State private var showExtras: Bool = false
        
    @State private var showSettings: Bool = false
    
    @State private var partialCover: Bool = false
    //
    
    // SHOW USER PROFILES ON DISCO
    @State private var showUserProfile: Bool = false
    //
    @State private var followOverlay: Bool = false
    private var blurView: some View {
        let blurHeight: CGFloat
        let blurCornerRadius: CGFloat
        let blurHorizontalPadding: CGFloat
        let blurOpacity: Double
        switch selection {
        case .profile:
            blurHeight = partialCover ? .infinity : 155
            blurCornerRadius = 45
            blurHorizontalPadding = partialCover ? 0 : 15
            blurOpacity = 0.75
        case .disco:
            blurHeight = showUserProfile ? 240 : 66
            blurCornerRadius = 45
            blurHorizontalPadding = 15
            blurOpacity = 0.75
        default:
            blurHeight = 66
            blurCornerRadius = 45
            blurHorizontalPadding = 15
            blurOpacity = 0.75
        }
        return Blur(style: .dark)
            .frame(height: blurHeight)
            .frame(maxWidth: .infinity)
            .cornerRadius(blurCornerRadius)
            .padding(.horizontal, blurHorizontalPadding)
            .opacity(blurOpacity)
    }
    var body: some View {
        NavigationView {
            ZStack {
                
                content
                    .ignoresSafeArea()
                
                ZStack {
                    
                    VStack {
                        Spacer()
                        VStack(spacing: 0) {
                            if selection == .profile {
                                ProfileElements(viewModel: userViewModel, followsOverlay: $followOverlay)
                                    .padding(.vertical, 12)
                                    .foregroundColor(.white)
                            }
                            TabBarView(tabs: tabs, selection: $selection)
                        }
                        .background(
                            Blur(style: .dark)
                                .cornerRadius(42)
                    )
                        .padding(.horizontal, 12)
                        .padding(.bottom, 12)
                    }
                    .ignoresSafeArea()
                    
 //                    settings
                    if selection == .profile {
                        ZStack(alignment: .topTrailing) {
                            ZStack(alignment: .topTrailing) {
                                Blur(style: .dark)
                                    .frame(width: showSettings ? .infinity : 30)
                                    .frame(height: showSettings ? .infinity : 30)
                                    .cornerRadius(21)
                                    .opacity(showSettings ? 1.0 : 0.0)
                                    .edgesIgnoringSafeArea(showSettings ? .all : .bottom)
                                
//                                profilesettingssample()
//                                    .opacity(showSettings ? 1.0 : 0.0)
                                
                            }
                            /// dock
                            VStack {
                                HStack(spacing:0) {
                                    if showSettings {
//                                        cancelButton(action: {
//                                            showSettings.toggle()
//                                        })
                                        
                                    } else {
//                                        profileExtrasButton(fullScreenContainer: $partialCover, showExtras: $showExtras)
//                                            .opacity(showEdit ? 0.0 : 1.0)
                                    }
                                    Spacer()
                                                                        
//                                    profileSettingsButton(showSettings: $showSettings)
//                                        .opacity(showEdit || showExtras ? 0.0 : 1.0)
                                    
                                    
                                }
                                Spacer()
                            }
                        }
                    }
                    
                    //                    extras
                    if selection == .profile {
                        ZStack(alignment: .topLeading) {
                            ZStack(alignment: .topLeading) {
                                Blur(style: .systemMaterialDark)
                                    .frame(width: showExtras ? .infinity : 30)
                                    .frame(height: showExtras ? .infinity : 30)
                                    .cornerRadius(21)
                                    .opacity(showExtras ? 1.0 : 0.0)
                                //                                    .padding(.horizontal, 9)
                                    .edgesIgnoringSafeArea(showExtras ? .all : .bottom)
                                
//                                PartyScreen()
//                                    .opacity(showExtras ? 1.0 : 0.0)
                                
                            }
                            VStack {
                                HStack(spacing:0) {
                                    if showSettings {
//                                        cancelButton(action: {
//                                            showExtras.toggle()
//                                        })
                                        
                                    } else {
//                                        profileExtrasButton(fullScreenContainer: $partialCover, showExtras: $showExtras)
//                                            .opacity(showEdit ? 0.0 : 1.0)
                                    }
                                    Spacer()
                                    
                                    
//                                    profileSettingsButton(showSettings: $showSettings)
//                                        .opacity(showEdit || showExtras ? 0.0 : 1.0)
                                    
                                }
                                .opacity(showSettings ? 0.0 : 1.0)
                                Spacer()
                            }
                        }
                    }
                    
                    
                        VStack(alignment: .leading) {
                            ZStack(alignment: .top) {
//                                VariableBlurView()
//                                    .frame(maxWidth: .infinity)
//                                    .frame(height: followOverlay ? .infinity : 0)
//                                    .ignoresSafeArea()
                                
                                HStack {
                                    VStack {
                                        Button(action: {
                                            withAnimation(.spring()) {
                                                followOverlay = false
                                            }
                                        }) {
                                            Text("close")
                                                .padding()
                                        }
                                        .opacity(followOverlay ? 1.0 : 0.0)
                                    }
                                    Spacer()
                                }
//                                Follows()
//                                    .opacity(followOverlay ? 1.0 : 0.0)
                            }
                            
                            Spacer(minLength: 0)
                        }
                    
                }
                
            }
//            .onChange(of: tabBarState.isHidden) { _ in
//                withAnimation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0)) {
//                    containerAppeared = !tabBarState.isHidden
//                }
//            }
            
            .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
                self.tabs = value
        })
        }
    }
}

struct containersample_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        .radio, .disco, .notifs, .profile, .create
    ]
    static var previews: some View {
        TabBarContainerView(selection: .constant(tabs.first!), userViewModel: userviewModel) {
            Color.gray
        }
        .environmentObject(TabBarState())
    }
}

//struct containersample<Content:View>: View {
//    @Binding var selection: TabBarItem
//    let content: Content
//    @State private var  tabs: [TabBarItem] = [
//        .radio, .disco, .notifs, .profile, .create
//    ]
//    @State private var scale : CGFloat = 1
//    
//    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content)   {
//        self._selection = selection
//        self.content = content()
//    }
//    @EnvironmentObject var tabBarState: TabBarState
//        
//    let partyScreen = PartyScreen()
//    
//    @State private var containerAppeared: Bool = false
//    
//    @State private var dragOffset: CGFloat = 0
//    
//    // YOUR PROFILE :
//    @State private var showEdit: Bool = false
//    
//    @State private var showExtras: Bool = false
//        
//    @State private var showSettings: Bool = false
//    
//    @State private var partialCover: Bool = false
//    //
//    
//    // SHOW USER PROFILES ON DISCO
//    @State private var showUserProfile: Bool = false
//    //
//    @State private var followOverlay: Bool = false
//    private var blurView: some View {
//        let blurHeight: CGFloat
//        let blurCornerRadius: CGFloat
//        let blurHorizontalPadding: CGFloat
//        let blurOpacity: Double
//        switch selection {
//        case .profile:
//            blurHeight = partialCover ? .infinity : 155
//            blurCornerRadius = 45
//            blurHorizontalPadding = partialCover ? 0 : 15
//            blurOpacity = 0.75
//        case .disco:
//            blurHeight = showUserProfile ? 240 : 66
//            blurCornerRadius = 45
//            blurHorizontalPadding = 15
//            blurOpacity = 0.75
//        default:
//            blurHeight = 66
//            blurCornerRadius = 45
//            blurHorizontalPadding = 15
//            blurOpacity = 0.75
//        }
//        return Blur(style: .dark)
//            .frame(height: blurHeight)
//            .frame(maxWidth: .infinity)
//            .cornerRadius(blurCornerRadius)
//            .padding(.horizontal, blurHorizontalPadding)
//            .opacity(blurOpacity)
//    }
//    var body: some View {
//        NavigationView {
//            ZStack {
//                
//                content
//                    .ignoresSafeArea()
//                
//                ZStack {
//                    
//                    VStack {
//                        Spacer()
//                        VStack(spacing: 0) {
//                            if selection == .profile {
//                                ProfileElements(followsOverlay: $followOverlay)
//                                    .padding(.vertical, 12)
//                                    .foregroundColor(.white)
//                            }
//                            TabBarView(tabs: tabs, selection: $selection)
//                        }
//                        .background(
//                            Blur(style: .dark)
//                                .cornerRadius(42)
//                    )
//                        .padding(.horizontal, 12)
//                        .padding(.bottom, 12)
//                    }
//                    .ignoresSafeArea()
//                    
// //                    settings
//                    if selection == .profile {
//                        ZStack(alignment: .topTrailing) {
//                            ZStack(alignment: .topTrailing) {
//                                Blur(style: .dark)
//                                    .frame(width: showSettings ? .infinity : 30)
//                                    .frame(height: showSettings ? .infinity : 30)
//                                    .cornerRadius(21)
//                                    .opacity(showSettings ? 1.0 : 0.0)
//                                    .edgesIgnoringSafeArea(showSettings ? .all : .bottom)
//                                
//                                profilesettingssample()
//                                    .opacity(showSettings ? 1.0 : 0.0)
//                                
//                            }
//                            /// dock
//                            VStack {
//                                HStack(spacing:0) {
//                                    if showSettings {
//                                        cancelButton(action: {
//                                            showSettings.toggle()
//                                        })
//                                        
//                                    } else {
//                                        profileExtrasButton(fullScreenContainer: $partialCover, showExtras: $showExtras)
//                                            .opacity(showEdit ? 0.0 : 1.0)
//                                    }
//                                    Spacer()
//                                                                        
//                                    profileSettingsButton(showSettings: $showSettings)
//                                        .opacity(showEdit || showExtras ? 0.0 : 1.0)
//                                    
//                                    
//                                }
//                                Spacer()
//                            }
//                        }
//                    }
//                    
//                    //                    extras
//                    if selection == .profile {
//                        ZStack(alignment: .topLeading) {
//                            ZStack(alignment: .topLeading) {
//                                Blur(style: .systemMaterialDark)
//                                    .frame(width: showExtras ? .infinity : 30)
//                                    .frame(height: showExtras ? .infinity : 30)
//                                    .cornerRadius(21)
//                                    .opacity(showExtras ? 1.0 : 0.0)
//                                //                                    .padding(.horizontal, 9)
//                                    .edgesIgnoringSafeArea(showExtras ? .all : .bottom)
//                                
//                                PartyScreen()
//                                    .opacity(showExtras ? 1.0 : 0.0)
//                                
//                            }
//                            VStack {
//                                HStack(spacing:0) {
//                                    if showSettings {
//                                        cancelButton(action: {
//                                            showExtras.toggle()
//                                        })
//                                        
//                                    } else {
//                                        profileExtrasButton(fullScreenContainer: $partialCover, showExtras: $showExtras)
//                                            .opacity(showEdit ? 0.0 : 1.0)
//                                    }
//                                    Spacer()
//                                    
//                                    
//                                    profileSettingsButton(showSettings: $showSettings)
//                                        .opacity(showEdit || showExtras ? 0.0 : 1.0)
//                                    
//                                }
//                                .opacity(showSettings ? 0.0 : 1.0)
//                                Spacer()
//                            }
//                        }
//                    }
//                    
//                    
//                        VStack(alignment: .leading) {
//                            ZStack(alignment: .top) {
//                                VariableBlurView()
//                                    .frame(maxWidth: .infinity)
//                                    .frame(height: followOverlay ? .infinity : 0)
//                                    .ignoresSafeArea()
//                                
//                                HStack {
//                                    VStack {
//                                        Button(action: {
//                                            withAnimation(.spring()) {
//                                                followOverlay = false
//                                            }
//                                        }) {
//                                            Text("close")
//                                                .padding()
//                                        }
//                                        .opacity(followOverlay ? 1.0 : 0.0)
//                                    }
//                                    Spacer()
//                                }
//                                Follows()
//                                    .opacity(followOverlay ? 1.0 : 0.0)
//                            }
//                            
//                            Spacer(minLength: 0)
//                        }
//                    
//                }
//                
//            }
//            .onChange(of: tabBarState.isHidden) { _ in
//                withAnimation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0)) {
//                    containerAppeared = !tabBarState.isHidden
//                }
//            }
//            
//            .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
//                self.tabs = value
//        })
//        }
//    }
//}
//struct containersample_Previews: PreviewProvider {
//    static let tabs: [TabBarItem] = [
//        .radio, .disco, .notifs, .profile, .create
//    ]
//    static var previews: some View {
//        containersample(selection: .constant(tabs.first!)) {
//            Color.gray
//        }
//        .environmentObject(TabBarState())
//    }
//}

