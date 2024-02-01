//
//  TabBarContainerView.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import SwiftUI
import AVKit

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
<<<<<<< HEAD
//    @EnvironmentObject var userViewModel: UserViewModel

=======
    
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
    @State private var selectedUserViewModel: UserViewModel?

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

    @State private var selectedUser: User?
    @EnvironmentObject var postsViewModel: PostsViewModel
<<<<<<< HEAD
    @EnvironmentObject var storiesViewModel: StoriesViewModel
    @EnvironmentObject var sharedStoryState: SharedStoryState
    @Namespace var animationNamespace // Declare a namespace

    @Namespace private var namespace
    @EnvironmentObject var sharedViewModel: SharedViewModel
=======
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee

    var body: some View {
        NavigationView {
            ZStack {
                
                content
                    .ignoresSafeArea()
                
                ZStack {
                    
                    VStack {
                        Spacer()
                        VStack(spacing: 0) {
                            
                            if selection == .disco {
                                // Display the profile elements for the selected user
                                if let selectedUser = postsViewModel.selectedUser {
<<<<<<< HEAD
                                    // Create a new ViewModel for the selected user
                                    let selectedUserViewModel = UserViewModel(user: selectedUser)
                                    ProfileElements(viewModel: selectedUserViewModel, followsOverlay: $followOverlay)
                                        .padding(.vertical, 12)
                                }

=======
                                    ProfileElements(viewModel: UserViewModel(user: selectedUser), followsOverlay: $followOverlay)
                                        .padding(.vertical, 12)
                                }
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
                            }
                            
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
                
                if selection == .profile {
                    ZStack(alignment: .topLeading) {
                        ZStack(alignment: .topLeading) {
                            Blur(style: .systemMaterialDark)
                                .frame(width: showExtras ? .infinity : 30)
                                .frame(height: showExtras ? .infinity : 30)
                                .cornerRadius(21)
                                .opacity(showExtras ? 1.0 : 0.0)
                                .edgesIgnoringSafeArea(showExtras ? .all : .bottom)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        // dismiss settings
                                    }
                                }
                            
                            ExtrasScreen()
                                .opacity(showExtras ? 1.0 : 0.0)
                            
                            ProfileEdit(userViewModel: userViewModel)
                                .opacity(showSettings ? 1.0 : 0.0)
                        }
                        VStack {
                            HStack(spacing:0) {
//                                if showSettings {
//                                    CancelButton(action: {
//                                        withAnimation(.spring()) {
//                                            showExtras.toggle()
//                                        }
//                                    })
//                                } else {
                                    ExtrasButton(showExtras: $showExtras)
                                        .opacity(showSettings ? 0.0 : 1.0)

                                //                                }
                                Spacer()
                                
                                SettingsButton(showSettings: $showSettings)
                                    .opacity(showEdit || showExtras ? 0.0 : 1.0)

                            }
                            .offset(y: -14)
//                            .opacity(showSettings ? 0.0 : 1.0)
                            Spacer()
                        }
                    }
                }

                // POST ABOVE TABBAR
                if let selectedPost = sharedViewModel.selectedPost {
                    PopupPostView(postViewModel: selectedPost, namespace: namespace) {
                        sharedViewModel.selectedPost = nil
                    }
                    .zIndex(1)
                }
                
                if sharedStoryState.isExpanded && sharedStoryState.currentStoryIndex < storiesViewModel.stories.count {
                    ExpandedStoryView(
                        viewModel: storiesViewModel.stories[sharedStoryState.currentStoryIndex],
                        storiesViewModel: storiesViewModel,
                        isExpanded: $sharedStoryState.isExpanded,
                        animation: animationNamespace // Pass the namespace here
                    )
                }
                
            }
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
        TabBarContainerView(selection: .constant(tabs.first!), userViewModel: UserViewModel()) {
            Color.gray
        }
        .environmentObject(TabBarState())
        .environmentObject(PostsViewModel())
<<<<<<< HEAD
        .environmentObject(SharedViewModel())
        .environmentObject(StoriesViewModel(stories: SampleData.sampleStories, currentUser: SampleData.userJohn))
        .environmentObject(SharedStoryState())
        
=======
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
    }
}
