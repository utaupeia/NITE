//
//  VideoPlayerView.swift
//  niteclub
//
//  Created by +++ on 1/1/24.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @ObservedObject var viewModel: VideoPlayerViewModel

    var body: some View {
        ZStack {
            // Show the thumbnail image or a placeholder while the video is loading
            
            // Video player
            VideoPlayer(player: viewModel.player)
  
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        if let videoURL = Bundle.main.url(forResource: "samplevideo", withExtension: "mov") {
            let viewModel = VideoPlayerViewModel(videoURL: videoURL)
            VideoPlayerView(viewModel: viewModel)
        } else {
            Text("Video file not found.")
        }
    }
}

struct VideoPlayer: UIViewControllerRepresentable {
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
}

