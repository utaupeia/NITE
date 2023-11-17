//
//  storysample.swift
//  niteclub
//
//  Created by +++ on 11/25/23.
//

import SwiftUI

struct storysample: View {
    @Namespace private var animation
    @ObservedObject var viewModel: StoryViewModel
    
    @State private var isExpanded: Bool = false

    var body: some View {
        ZStack {
            // Horizontal ScrollView for story thumbnails
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.allStoryGroups, id: \.id) { storyGroup in
                        storyThumbnail(for: storyGroup)
                    }
                }
            }

            // Expanded story view
            if let expandedStory = viewModel.currentStory, isExpanded {
                expandedStoryView(for: expandedStory)
            }
        }
        // MARK: it is abruptly dismissing story but needs to happen on tap
        .onAppear {
            viewModel.onEndOfStories = {
                isExpanded = false
            }
        }
    }

    private func storyThumbnail(for group: StoryGroup) -> some View {
        let displayStory = group.stories.first(where: { !$0.seen }) ?? group.stories.first
        return VStack(alignment: .leading) {
            if let storyToDisplay = displayStory {
                Image(storyToDisplay.mediaURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: storyToDisplay.id, in: animation)
                    .frame(width: 96, height: 160)
                    .cornerRadius(12)
                    .clipped()
                    .onTapGesture {
                        withAnimation {
                            viewModel.selectStoryGroup(group)
                            isExpanded = true
                        }
                    }
            }
            Text(group.user.username)
                .font(.headline)
                .padding(.leading)
        }
    }

    private func expandedStoryView(for story: StoryItem) -> some View {
        ZStack {
            Color.black.opacity(0.85).ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring()) {
                        isExpanded = false
                    }
                }
            Image(story.mediaURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: story.id, in: animation)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack {
                Image(story.author.profilePicture)
                    .resizable()
                    .frame(width: 36, height: 60)
                    .cornerRadius(6)
                Text(story.author.username)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding()

            HStack(spacing: 0) {
                Button(action: { withAnimation { viewModel.previousStory() } }) {
                    Color.clear.frame(width: .infinity, height: 500)
                }
                Button(action: { withAnimation { viewModel.nextStory() } }) {
                    Color.clear.frame(width: .infinity, height: 500)
                }
            }
            .zIndex(4) // Above the image
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .zIndex(2)
        .onDisappear {
            isExpanded = false
        }
    }
}

let sampleViewModel = StoryViewModel(currentUser: SampleData.userYannie)

#Preview {
    storysample(viewModel: sampleViewModel)
}
