//
//  MusicStream.swift
//  niteclub
//
//  Created by +++ on 12/9/23.
//

import SwiftUI
import AVKit

struct MusicStream: View {
    @ObservedObject var songViewModel: SongViewModel
    @StateObject private var audioPlayViewModel: AudioPlayViewModel
    
    init(songViewModel: SongViewModel) {
        self.songViewModel = songViewModel
        let url = songViewModel.song.mp3File // This is already a URL
        _audioPlayViewModel = StateObject(wrappedValue: AudioPlayViewModel(url: url))
    }


    var body: some View {
            VStack {
                Text(songViewModel.song.name)
                    .fontDesign(.monospaced)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                //button to go to profile
                Text(songViewModel.song.artist.username)
                    .fontDesign(.monospaced)
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                
                
                ZStack {

                    Image(songViewModel.song.coverArt)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 240, height: 240)
                        .clipped()
                        .cornerRadius(30)
                        .padding(6)
                        .overlay(
                            ZStack {
                                RoundedRectangle(cornerRadius: 36)
                                    .trim(from: 0, to: 1.0)
                                    .stroke(Color.gray.opacity(0.05), lineWidth: 5)

                                RoundedRectangle(cornerRadius: 36)
                                    .trim(from: 0, to: audioPlayViewModel.songProgress)
                                .stroke(Color.white, lineWidth: 5)
                                .animation(.easeInOut(duration: 0.2), value: audioPlayViewModel.songProgress)

                            }
                                .rotationEffect(.degrees(90))

                        )
                    
                    
                    Button(action: {
                        if audioPlayViewModel.isPlaying {
                            audioPlayViewModel.pauseAudio()
                        } else {
                            audioPlayViewModel.playAudio()
                        }
                    }) {
                        Image(systemName: audioPlayViewModel.isPlaying ? "pause.fill" : "play.fill")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 24, height: 24)
                    }
                }
                HStack {
                Button(action: {
                    // like song action
                }) {
                    Image(systemName: "heart")
                        .foregroundStyle(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(.white, lineWidth: 1.5)
                        )
                        .opacity(0.0)
                }
                .padding()
                    Spacer()

            }
                .frame(width: 240)
    //            WaveformView(audioVM: audioPlayViewModel)
                
                Spacer()
            }
            .padding(.top, 60)
        }
    }

let dummyURL = Bundle.main.url(forResource: "EVILJ0RDAN", withExtension: "mp3")!

let avm = AudioPlayViewModel(url: dummyURL)

#Preview {
    MusicStream(songViewModel: songViewModel)
}
