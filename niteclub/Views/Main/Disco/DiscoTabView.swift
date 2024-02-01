//
//  DiscoTabView.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import SwiftUI
import AVKit

class TabSelection: ObservableObject {
    @Published var selection: Int = 0
}

//struct DiscoView: Identifiable {
//    let id: Int
//    let view: AnyView
//}

struct DiscoTabView: View {
    @State private var selectedTab = 0
    var discoNames = ["Following", "Pics", "Stories", "Text", "Themes", "Videos"]
    @State private var showingPopup = false
    @ObservedObject var tabSelection = TabSelection()
    @State private var navigationPath = NavigationPath()
    @State private var isDMVisible: Bool = false
    @State private var blurHeight: CGFloat = 100
    @State private var isExpanded: Bool = false
    var maxHeight: CGFloat = UIScreen.main.bounds.height
    
    @StateObject var viewModel = UserViewModel()

    var body: some View {
        NavigationStack(path: $navigationPath) {
        
            ZStack {
                Image("image35")
                    .resizable()
                    .overlay(Blur(style: .dark))
                    .ignoresSafeArea()
                TabView(selection: $selectedTab) {
                    
                    FollowingDisco()
                        .tag(0)
                    
                    TextDisco()
                        .tag(1)
                    
                    ImageDisco()
                        .tag(2)
                    
                    StoryDisco()
                        .tag(3)
                    
                    VideoDisco()
                        .tag(4)
                    
                    ThemeDisco()
                        .tag(5)
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .ignoresSafeArea()
                .opacity(isDMVisible ? 0.0 : 1.0)
                
                navBar
                    .opacity(isDMVisible ? 0.0 : 1.0)

                if isExpanded {
                    SearchScreen(viewModel: viewModel)
                }
                if isDMVisible {
                    MessageTabView(isDMVisible: $isDMVisible)
                }
            }
        }
    }
    var navBar: some View {
        VStack {
            ZStack(alignment: .top)  {
                
                VariableBlurView()
                
                HStack(spacing: 0) {
                    Spacer()
                    SearchButton(isExpanded: $isExpanded, blurHeight: $blurHeight, maxHeight: maxHeight)
                    
                    DmButton(isDMVisible: $isDMVisible) {
//                        navigationPath.append(MessageTabView())

                    }
                }
                .padding(.top, 50)
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: blurHeight)
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DiscoTabView()
        .environmentObject(TabBarState())
        .environmentObject(PostsViewModel())
        .environmentObject(StoriesViewModel(stories: SampleData.sampleStories, currentUser: SampleData.userJohn))
        .environmentObject(SharedStoryState())
}
