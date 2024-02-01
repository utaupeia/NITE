//
//  EngagementTabView.swift
//  niteclub
//
//  Created by +++ on 1/20/24.
//

import SwiftUI

struct EngagementTabView: View {
    @State private var selectedTab: Int = 0
    @Namespace private var tabAnimation
    
    @State private var quoteText: String = ""

    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            TabView(selection: $selectedTab) {
                FirstTabView(selectedTab: $selectedTab)
                    .tag(0)
                
                SecondTabView()
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            VStack {
                
                if selectedTab == 1 {
                    TextField("Quote", text: $quoteText)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(.white, lineWidth: 1)
                        )
                        .padding()
                }
                
                Image("image25") // Replace "yourImageName" with your image name
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: selectedTab == 0 ? 300: 200, height: selectedTab == 0 ? 400 : 200)

                Spacer()
                
                ScrollView {
                    VStack {
                        // quotes
                        ForEach(0..<5, id: \.self) { _ in
                            Rectangle()
                                .stroke(.white, lineWidth: 1)
                                .frame(width: 300, height: 100)
                                .padding(4)
                        }

                    }
                }
            }
            .padding(.top, selectedTab == 0 ? 0 : 50)

            
            ZStack {
                VStack {
                    HStack{
                        Button("Cancel") {
                            withAnimation(.spring()) {
                                
                            }
                            
                        }
                        .foregroundStyle(.white)
                        .padding()
                        
                        Spacer()
                        
                        Button(selectedTab == 0 ? "Repost" : "Back") {
                            withAnimation(.spring()) {
                                if selectedTab == 1 {
                                    selectedTab = 0
                                } else {
                                    // REPOST POST
                                }
                            }
                            
                        }
                        .foregroundStyle(.white)
                        .padding()
                        
                        Button(selectedTab == 1 ? "Post" : "Quotes") {
                            withAnimation(.spring()) {
                                if selectedTab == 0 {
                                    selectedTab = 1
                                } else {
                                    // POST QUOTE
                                }
                            }
                            
                        }
                        .foregroundStyle(.white)
                        .padding()
                    }
                    Spacer()
                    if selectedTab == 0 {
                    HStack {
                            Button( "Like") {
                                withAnimation(.spring()) {
                                    // Like
                                }
                                
                            }
                            .foregroundStyle(.white)
                            .padding()
                        
                        Spacer()
                        Button( "comment") {
                            withAnimation(.spring()) {
                                // Like
                            }
                            
                        }
                        .foregroundStyle(.white)
                        .padding()
                        
                    }
                }
                }
            }

        }
    }
}

#Preview {
    EngagementTabView()
}

struct FirstTabView: View {
    @Binding var selectedTab: Int

    var body: some View {
        VStack {
            HStack {
                Spacer()

            }
            Spacer()
        }
    }
}

struct SecondTabView: View {
    var body: some View {
        Text("")
    }
}

