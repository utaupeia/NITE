//
//  VideoControlsView.swift
//  niteclub
//
//  Created by +++ on 1/7/24.
//

import SwiftUI
import AVKit

struct VideoControlsView: View {
    @ObservedObject var viewModel: VideoPlayerViewModel

    var onFullScreenTapped: () -> Void

    var body: some View {
        VStack {
            HStack {
                
                Spacer()
                
                Button(action: {
                    viewModel.toggleMute()
                }) {
                    Image(systemName: viewModel.isMuted ? "speaker.slash.fill" : "speaker.fill")
                        .foregroundColor(.white)
                }
                .padding()
            }
            Spacer()
            HStack(spacing: 0) {
                Button(action: {
                    viewModel.isPlaying ? viewModel.pause() : viewModel.play()
                }) {
                    Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                        .foregroundColor(viewModel.isPlaying ? .white : .white.opacity(0.75))
                        .padding()
                }

                //            Text(viewModel.currentTimeText)

                ZStack(alignment: .leading) {
                    GeometryReader { geometry in

                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 3)
                            .foregroundColor(.gray.opacity(0.25))

                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: CGFloat(viewModel.progress) * geometry.size.width, height: 3)
                            .foregroundColor(.white)
                            .animation(.linear(duration: 0.5), value: viewModel.progress)
                    }
                }
                .frame(height: 3)
    //            Text(viewModel.durationText)

                Button(action: onFullScreenTapped) {
                    Image(systemName: "square")
                        .foregroundColor(.white)
                }
                .padding()
            }
        }
    }
}

struct VideoControlsView_Previews: PreviewProvider {
    static var previews: some View {
        // Create and configure the viewModel
        let viewModel = createPreviewViewModel()

        // Create the VideoControlsView with the configured viewModel
        VideoControlsView(viewModel: viewModel) {
            // Fullscreen button action
            print("Fullscreen tapped")
        }
        .previewLayout(.sizeThatFits)
        .background(Color.black.opacity(0.25))
    }

    static func createPreviewViewModel() -> VideoPlayerViewModel {
        let sampleURL = URL(string: "https://www.example.com/samplevideo.mp4")!
        let viewModel = VideoPlayerViewModel(videoURL: sampleURL)

        // Set some sample data
        viewModel.currentTimeText = "00:15"
        viewModel.durationText = "03:30"
        viewModel.progress = 0.25 // 25%
        viewModel.isPlaying = true
        viewModel.isMuted = false

        return viewModel
    }
}
