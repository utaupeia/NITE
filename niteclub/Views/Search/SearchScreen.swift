//
//  SearchScreen.swift
//  niteclub
//
//  Created by +++ on 12/7/23.
//

import SwiftUI

struct SearchScreen: View {
    @ObservedObject var viewModel: UserViewModel
    @State private var searchQuery: String = ""
    @State private var navigationPath = NavigationPath()
    @State private var randomUsers: [User]
    @State private var pastSearches = [String]() // Array to store past searches

    @State var AutoScroll = false
    private let totalContentWidth: CGFloat = 1950 // Adjust based on the total width of your cards

    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        // Initialize randomUsers here
        _randomUsers = State(initialValue: viewModel.randomUsers)
    }

    let rows = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ZStack {
//            Color.gray.ignoresSafeArea()
            VStack(spacing: 0) {
                
                VStack {
                    if searchQuery.isEmpty {
                        Text("Trending Members")
                            .padding()
                            .frame(width: UIScreen.main.bounds.width ,alignment: .leading)
                            .bold()
                            .foregroundStyle(.white)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 30) {
                                ForEach(randomUsers, id: \.id) { user in
                                    UserCard(viewModel: UserViewModel(user: user), dateToDisplay: user.dateJoined, navigationPath: $navigationPath, onTap: {})
                                    // ADD follow button to each card
                                }
                            }
                            .offset(x: AutoScroll ? -totalContentWidth / 2 : 0)
                            .padding(.leading, 15)
                        }
                        //                    .animation(Animation.linear(duration: 20).repeatForever(autoreverses: false), value: AutoScroll)
                        //                    .onAppear {
                        //                        self.AutoScroll.toggle()
                        //                    }
                    }
                }
                // ,make animation spring trending off page
                .offset(y: searchQuery.isEmpty ? 0 : -200)
                
                TextField("Search Niteclub", text: $searchQuery)
                    .foregroundStyle(.white)
                    .onChange(of: searchQuery) {
                        withAnimation(.spring()) {
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(.white.opacity(0.5), lineWidth: 1.0)
                    )
                    .padding()
                    .padding(.top,searchQuery.isEmpty ? 0 : 30)

                VStack(spacing: 0) {
                Text("Recent Searches")
                    .padding()
                    .frame(width: UIScreen.main.bounds.width ,alignment: .leading)
                    .bold()
                    .foregroundStyle(.white)
                    .opacity(searchQuery.isEmpty && !viewModel.pastSearchedUsers.isEmpty ? 1.0 : 0.0)
                // Conditionally display either past searched users or search results
                if searchQuery.isEmpty && !viewModel.pastSearchedUsers.isEmpty {
                    // ScrollView for past searched users
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(viewModel.pastSearchedUsers, id: \.id) { user in
                                VStack {
                                    UserCard(viewModel: UserViewModel(user: user), dateToDisplay: user.dateJoined, navigationPath: $navigationPath, onTap: {})
                                    
                                    Button(action: {withAnimation(.spring()) {viewModel.removeSearchedUser(user)}
                                    }) {
                                        Image(systemName: "xmark.circle")
                                            .foregroundColor(.red)
                                            .padding(12)
                                    }
                                }
                            }
                            .padding(.horizontal, 15)
                        }
                    }
                } else {
                    // ScrollView for current search results
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, alignment: .top, spacing: 30) {
                            ForEach(viewModel.filteredUsers(searchQuery), id: \.id) { user in
                                UserCard(viewModel: UserViewModel(user: user), dateToDisplay: user.dateJoined, navigationPath: $navigationPath, onTap: {
                                    viewModel.addUserToPastSearches(user)
                                    
                                })
                            }
                        }
                        .frame(height: 330)
                    }
                }
            }
                Spacer(minLength: 10)
                }
            .padding(.top, 60)

        }
    }
}


#Preview {
    SearchScreen(viewModel: UserViewModel())
}
