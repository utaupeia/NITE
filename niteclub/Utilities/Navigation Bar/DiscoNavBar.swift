//
//  DiscoNavBar.swift
//  niteclub
//
//  Created by +++ on 12/4/23.
//

import SwiftUI

struct DiscoNavBar: View {
    @State private var navigationPath = NavigationPath()
//    @Environment(\.presentationMode) var presentationMode
    @State private var showNavMenu: Bool = false // write longtap gesture to menu button
    
    @State private var blurHeight: CGFloat = 100
    @State private var isExpanded: Bool = false
    var maxHeight: CGFloat = UIScreen.main.bounds.height
    
    @State private var isDMVisible: Bool = false
    let discoNames: [String]
    @Binding var selection: Int
    @Binding var showingPopup: Bool
    @EnvironmentObject var tabBarState: TabBarState
    @EnvironmentObject var postsVM: PostsViewModel

    var body: some View {
        

            ZStack {
                VStack {
                    ZStack(alignment: .top)  {
                        
                        VariableBlurView()
                        
                        VStack {
                            HStack(spacing: 0)  {
                                // this should disappear on a time delay, maybe a second
                                Text(discoNames[selection])
                                    .font(.system(size: 13))
                                    .fontWeight(.regular)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 12)
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            self.showingPopup = true
                                        }
                                    }
                                    .opacity(isExpanded ? 0.0 : 1.0)
                                
                                Spacer()
                                
                                SearchButton(isExpanded: $isExpanded, blurHeight: $blurHeight, maxHeight: maxHeight)
                                
                                DmButton(isDMVisible: $isDMVisible) {
                                
                                }
                                    .opacity(isExpanded ? 0.0 : 1.0)
                            }
                            .padding(.top, 45)
                            
                            if isExpanded {
                                SearchScreen(viewModel: UserViewModel())
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: blurHeight)
                    .ignoresSafeArea()
                    Spacer()
                }
                
                if isDMVisible {
                    //                DMs(isDMVisible: $isDMVisible)
                    //                    .transition(.opacity.animation(.easeInOut))
                }
            }
            .navigationDestination(for: User.self) { user in
                ProfileContentTabView(user: user, navigationPath: $navigationPath)
                    .environmentObject(UserViewModel())
                    .environmentObject(PostsViewModel())
                    .environmentObject(postsVM.userViewModel)

            }
        }
    }

#Preview {
    DiscoNavBar(discoNames: ["Disco 1", "Disco 2", "Disco 3"],
                selection: .constant(0),
                showingPopup: .constant(false))
    .environmentObject(TabBarState())
}
