//
//  DiscoTabView.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import SwiftUI

class TabSelection: ObservableObject {
    @Published var selection: Int = 0
}

struct DiscoView: Identifiable {
    let id: Int
    let view: AnyView
}

struct DiscoTabView: View {
    @EnvironmentObject var viewModel: PostsViewModel // Access PostsViewModel from the environment

    @EnvironmentObject var tabBarState: TabBarState
    @ObservedObject var tabSelection = TabSelection()
    
    @Binding var selection: Int
    
    @State private var showingPopup = false
    
    @State private var navigationPath = NavigationPath()

    var discoNames = ["Following", "Pics", "Stories", "Text", "Themes", "Videos"]

    @Namespace private var matchedNamespace
    var body: some View {
        
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color.black.opacity(0.75).ignoresSafeArea()
                TabView(selection: $tabSelection.selection) {
                    FollowingDisco(navigationPath: $navigationPath)
                        .matchedGeometryEffect(id: "followingContent", in: matchedNamespace)
                        .tag(0)
                    
                    ImageDisco()
                        .tag(1)
                    
                    StoryDisco()
                        .tag(2)
                    
                    TextDisco(navigationPath: $navigationPath)
                        .tag(3)
                                        
                    ThemeDisco()
                        .tag(4)
                    
                    VideoDisco()
                        .tag(5)
                    
                }
                .ignoresSafeArea()
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))  // hides the tab indicators
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                discoNavBar(discoNames: discoNames, selection: $tabSelection.selection, showingPopup: $showingPopup)
                if showingPopup {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                self.showingPopup = false
                            }
                        }
                    VStack {
                        VStack {
                            ForEach(discoNames.indices, id: \.self) { index in
                                Text(discoNames[index])
                                    .font(.system(size: 15))
                                    .fontWeight(.regular)
                                    .foregroundColor(.white)
                                    .opacity(tabSelection.selection == index ? 1.0 : 0.5) // Change opacity based on selection
                                    .padding()
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            self.tabSelection.selection = index
                                            self.showingPopup = false
                                        }
                                    }
                            }
                        }
                        .padding()
                        .background(Blur(style: .dark))
                        .cornerRadius(20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        
//                        NavigationLink(destination: Hub().environmentObject(tabBarState)) {
//                            Text("HUB")
//                                .foregroundColor(.white)
//                        }
                    }
                }
                
            }
            .navigationDestination(for: User.self) { user in
                ProfileContentTabView(user: user, navigationPath: $navigationPath)  // Define navigation destination
            }
        }
        .onAppear {
            tabSelection.selection = selection
        }
    }
}

#Preview {
    DiscoTabView(selection: .constant(0))
        .environmentObject(TabBarState())
        .environmentObject(PostsViewModel())
}

struct discoNavBar: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showNavMenu: Bool = false // write longtap gesture to menu button
    
    @State private var blurHeight: CGFloat = 100
    @State private var isExpanded: Bool = false
    var maxHeight: CGFloat = UIScreen.main.bounds.height
    
    @State private var isDMVisible: Bool = false
    let discoNames: [String]
    @Binding var selection: Int
    @Binding var showingPopup: Bool
    @EnvironmentObject var tabBarState: TabBarState
    var body: some View {
        
        ZStack {
//                       Background()
            VStack {
                ZStack(alignment: .top)  {
                    
                    VariableBlurView()
                    
                    VStack {
                        HStack(spacing: 0)  {
//                            discoBackToggle()
//                                .opacity(isExpanded ? 0.0 : 1.0)
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
                            
//                            SearchButton(isExpanded: $isExpanded, blurHeight: $blurHeight, maxHeight: maxHeight)
                            
//                            DMButton(isDMVisible: $isDMVisible)
                                .opacity(isExpanded ? 0.0 : 1.0)
                        }
                        .padding(.top, 45)
                        
//                        if isExpanded {
////                            DiscoSearch()
//                                .onAppear {
//                                    tabBarState.isHidden = true
//                                }
//                                .onDisappear {
//                                    tabBarState.isHidden = false
//                                }
//                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: blurHeight)
//                .gesture(
//                    DragGesture(minimumDistance: 15)
//                        .onChanged { value in
//                            let newHeight = blurHeight + (value.translation.height * 0.5)
//                            blurHeight = min(max(newHeight, 100), maxHeight)
//                            if blurHeight >= maxHeight {
//                                isExpanded = true
//                            } else if blurHeight <= 100 {
//                                isExpanded = false
//                            }
//                        }
//                )
                
                .ignoresSafeArea()
                Spacer()
            }
            
//            if isDMVisible {
//                DMs(isDMVisible: $isDMVisible)
//                    .transition(.opacity.animation(.easeInOut))
//            }
        }
    }
}

#Preview {
    DiscoTabView(selection: .constant(0))
            .environmentObject(TabBarState())
            .environmentObject(PostsViewModel())

}
