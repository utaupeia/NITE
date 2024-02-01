//
//  StoryPostView.swift
//  niteclub
//
//  Created by +++ on 1/8/24.
//

import SwiftUI
import AVKit

struct StoryPostView: View {
    @ObservedObject var viewModel: StoryPostViewModel

    var body: some View {
        ZStack {
            // Media display (image or video)
            if viewModel.storyPost.media == .image, let imageUrl = viewModel.storyPost.imageUrl {
                // Replace with your actual image loading logic
                Image(imageUrl)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            } else if viewModel.storyPost.media == .video, let videoUrl = viewModel.storyPost.videoUrl, let url = URL(string: videoUrl) {
                VideoPlayer(player: AVPlayer(url: url))
            }
        }
    }
}

extension StoryViewModel {
    func pauseProgress() {
        progressTimer?.invalidate()
    }

    func resumeProgress() {
        startProgressForCurrentPost()
    }
}


struct StoryPostView_Previews: PreviewProvider {
    static var previews: some View {

        let viewModel = StoryPostViewModel(storyPost: SampleData.mfstory)

        StoryPostView(viewModel: viewModel)
    }
}
