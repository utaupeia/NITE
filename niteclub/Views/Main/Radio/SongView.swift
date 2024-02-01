//
//  SongView.swift
//  niteclub
//
//  Created by +++ on 12/9/23.
//

import SwiftUI
import AVKit

struct SongView: View {
    @ObservedObject var songViewModel: SongViewModel
    @StateObject private var audioPlayViewModel: AudioPlayViewModel
    
    init(songViewModel: SongViewModel) {
        self.songViewModel = songViewModel
        let url = songViewModel.song.mp3File // This is already a URL
        _audioPlayViewModel = StateObject(wrappedValue: AudioPlayViewModel(url: url))
    }


    var body: some View {
            HStack {

                ZStack {
                    Image(songViewModel.song.coverArt)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .cornerRadius(6)
                    .clipped()
                    
                    Button(action: {
                        if audioPlayViewModel.isPlaying {
                            audioPlayViewModel.pauseAudio()
                        } else {
                            audioPlayViewModel.playAudio()
                        }
                    }) {
                        Image(systemName: audioPlayViewModel.isPlaying ? "pause.circle" : "play.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.white)
                    }

                }
                
                HStack {

                    VStack( alignment: .leading, spacing: 0) {
                    Text(songViewModel.song.name)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .fontDesign(.monospaced)

                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/)
                        {Text("- \(songViewModel.song.artist.username)")
                                .font(.system(size: 15))
                                .foregroundStyle(.white)
                        }
                        
                        HStack {
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: geometry.size.width, height: 5)

                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color.white)
                                        .frame(width: CGFloat(audioPlayViewModel.playbackTime / audioPlayViewModel.totalDuration) * geometry.size.width, height: 5)
                                        .animation(.linear(duration: 0.5), value: audioPlayViewModel.playbackTime)

                                }
                            }
                            .frame(height: 5)

                            HStack {
                                // playback time of song
                                Text(audioPlayViewModel.formattedTime(for: audioPlayViewModel.playbackTime))
                                    .opacity(0.5)
                                Text("/")
                                Text(audioPlayViewModel.formattedTime(for: audioPlayViewModel.totalDuration))
                                    .opacity(0.5)

                            }
                            .fontDesign(.monospaced)
                            .font(.system(size: 15))
                            

                        }
                        Spacer(minLength: 0)
                        
                    }
                    Spacer(minLength: 0)

                }
                .frame(height: 60)
            }
            .padding(12)
            .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.white)
            )
        }
    }

let mp3FileURL = Bundle.main.url(forResource: "EVILJ0RDAN", withExtension: "mp3")
let mp3FilePath = mp3FileURL?.path ?? "" // Convert URL to String

let sampleSong = Song(
    name: "EVILJ0RDAN",
    artist: SampleData.donna,
    coverArt: "COVER",
    mp3File: Bundle.main.url(forResource: "lovely", withExtension: "mp3") ?? URL(fileURLWithPath: "") // Use the String path
)

let songViewModel = SongViewModel(song: sampleSong)

#Preview {
    SongView(songViewModel: songViewModel)
        .padding()
}
