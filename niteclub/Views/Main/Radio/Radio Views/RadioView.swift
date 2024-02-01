//
//  RadioView.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import SwiftUI
import AVKit

struct RadioView: View {
    @State private var isCreateSongEnabled = true
    @State private var selectedTab: Int = 1
    @Namespace private var tabAnimation
    let sampleSong = Song(
        name: "i don't have one of those",
        artist: SampleData.ekkstacy,  // Assuming SampleData.ii_ii is a valid Artist object
        coverArt: "ekkstacy",  // Assuming "COVER" is a valid image name or path
        mp3File: Bundle.main.url(forResource: "EVILJ0RDAN", withExtension: "mp3") ?? URL(fileURLWithPath: "")
    )
    var songViewModel: SongViewModel

    init() {
        songViewModel = SongViewModel(song: sampleSong)
    }

    var body: some View {
        ZStack {
            ZStack {
                // Possible Ad Placement
                Image("image16")
                    .resizable()
                    .clipped()
                Blur(style: .dark)
                    .opacity(0.95)
            }
            .ignoresSafeArea()

            
            TabView(selection: $selectedTab) {
                MusicLibrary()
                    .tag(0)
                
                MusicStream(songViewModel: songViewModel)
                    .tag(1)
                
                CreateSong()
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

            VStack {
                HStack(spacing: 90) {
                    ForEach(0..<3, id: \.self) { index in
                        Button(action: {
                            withAnimation(.spring()) {
                                selectedTab = index
                            }
                        }) {
                            
                            RoundedRectangle(cornerRadius: 24)
                                .fill(selectedTab == index ? Color.white : Color.gray)
                                .frame(width: selectedTab == index ? 60 : 20, height: 5)
                                .matchedGeometryEffect(id: "tabIndicator\(index)", in: tabAnimation)
                                .padding()
                        }
                    }
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: selectedTab)
                }
                Spacer()
            }
            .padding(.top, 60)
        }
    }
}

#Preview {
    RadioView()
}

struct TabIndicator: View {
    var selectedTab: Int
    var tabNumber: Int
    var namespace: Namespace.ID

    var body: some View {
        GeometryReader { geometry in
            if selectedTab == tabNumber {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .matchedGeometryEffect(id: "tabIndicator", in: namespace)
                    .frame(width: geometry.size.width, height: 30)
            } else {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 20, height: 20)
            }
        }
        .frame(height: 30)
    }
}

