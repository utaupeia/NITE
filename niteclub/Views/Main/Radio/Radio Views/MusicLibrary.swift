//
//  MusicLibrary.swift
//  niteclub
//
//  Created by +++ on 1/19/24.
//

import SwiftUI
import AVKit

struct MusicLibrary: View {
    // Sample array of songs
    let songs = [
        Song(name: "EVILJ0RDAN", artist: SampleData.userEmma, coverArt: "COVER", mp3File: Bundle.main.url(forResource: "EVILJ0RDAN", withExtension: "mp3") ?? URL(fileURLWithPath: "")),
        Song(name: "Lovely", artist: SampleData.bobby, coverArt: "image21", mp3File: Bundle.main.url(forResource: "lovely", withExtension: "mp3") ?? URL(fileURLWithPath: "")),
        // Add more songs as needed
    ]

    var body: some View {
        VStack {
            ForEach(songs, id: \.name) { song in
                SongView(songViewModel: SongViewModel(song: song))
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
}

#Preview {
    MusicLibrary()
}
