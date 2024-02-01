//
//  WaveformView.swift
//  niteclub
//
//  Created by +++ on 12/9/23.
//

import SwiftUI

struct WaveformView: View {
    @ObservedObject var audioVM: AudioPlayViewModel
    @State private var offset: CGFloat = 0
    // Assuming each bar is 2 points wide and spacing is 2 points
    private let barWidth: CGFloat = 2
    private let spacing: CGFloat = 2
    
    var body: some View {
        VStack(alignment: .center) {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    waveformBarStack
                        .frame(width: 300, height: geometry.size.height)
                        .offset(x: -offset)
                }
                .frame(width: geometry.size.width, height: 30)
            }
            .onReceive(audioVM.$playbackTime) { playbackTime in
                let playbackProgress = playbackTime / audioVM.totalDuration
                self.offset = CGFloat(playbackProgress) * 300
            }
            
            // playPauseButton (if needed)
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
    private var waveformBarStack: some View {
        HStack(alignment: .center, spacing: spacing) {
            ForEach(audioVM.soundSamples, id: \.self) { model in
                BarView(value: self.normalizeSoundLevel(level: model.magnitude), color: model.color)
            }
        }
    }
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let minLevel: Float = -60  // Minimum level of your audio samples
        let maxLevel: Float = 0    // Maximum level of your audio samples
        let uiMinHeight: CGFloat = 0
        let uiMaxHeight: CGFloat = 40
        // Normalize the level to a 0-1 range
        var normalizedLevel = (level - minLevel) / (maxLevel - minLevel)
        // Apply different exponent for higher levels
        if normalizedLevel > 0.75 { // Adjust threshold as needed
            // Apply stronger exponent for higher levels
            normalizedLevel = pow(normalizedLevel, 1.5) // Lower exponent for less amplification
        } else {
            // Keep lower levels less changed
            normalizedLevel = pow(normalizedLevel, 2.5) // Higher exponent for more amplification
        }
        // Scale to the UI range
        return CGFloat(normalizedLevel) * (uiMaxHeight - uiMinHeight) + uiMinHeight
    }
}

struct BarView: View {
    var value: CGFloat
    var color: Color
    var body: some View {
        ZStack {
            Rectangle()
                .fill(color)
                .cornerRadius(10)
                .frame(width: 2, height: value)
        }
    }
}


let audioPlayVM = AudioPlayViewModel(url: Bundle.main.url(forResource: "lovely", withExtension: "mp3")!)


#Preview {
    WaveformView(audioVM: audioPlayVM)
}

