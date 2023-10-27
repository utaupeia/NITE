//
//  ThirdStorySample.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import SwiftUI

struct ThirdStorySample: View {
    //    @StateObject private var tabBarState = TabBarState()
    
    // Namespace for the matched geometry effect
    @Namespace private var animation
    
    // Observing the ViewModel
    @ObservedObject var viewModel: StoryViewModel
    
    // State variables
    @State private var selectedStory: StoryItem? = nil
    @State private var isExpanded: Bool = false

    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    // Horizontal list of stories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(viewModel.currentStoryGroup?.stories ?? [], id: \.id) { story in
                                ZStack {
                                    // Story thumbnail
                                    Image(story.mediaURL) // Directly use the mediaURL string for a local image asset
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .matchedGeometryEffect(id: story.id, in: animation, isSource: !isExpanded)
                                        .frame(width: 96, height: 160)
                                        .cornerRadius(12)
                                        .clipped()
                                        .onTapGesture {
                                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                                                isExpanded = true
                                                selectedStory = story
                                                viewModel.markStoryAsSeen(story: story)  // Now this method should be recognized
                                            }
                                        }
                                        .zIndex(isExpanded ? 2 : 0)
                                    
                                    // If the story hasn't been viewed, we can show an overlay or other indicator
                                    if !story.seen {
                                        // Your overlay or "not seen" indicator here
                                        Color.black.opacity(0.4) // Example overlay
                                            .frame(width: 96, height: 160)
                                            .allowsHitTesting(false) // Allow taps to pass through
                                    }
                                }
                                .cornerRadius(12)
                            }
                        }
                        .padding(.all)
                    }
                    // Additional UI elements can continue here...
                }
            }
            
            // Fullscreen cover for the selected story content
            if isExpanded, let expandedStory = selectedStory {
                ZStack {
                    // Background overlay
                    Color.black.opacity(0.85)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring()) {
                                isExpanded = false
                            }
                        }
                    
                    // The content itself
                    Image(expandedStory.mediaURL) // Directly use the mediaURL string for a local image asset
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: expandedStory.id, in: animation)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                // Action for tapping the story (if needed)
                                // For example, move to the next story if tapped
                                viewModel.nextStory()
                            }
                        }
                        .zIndex(isExpanded ? 3 : 0)
                    
                    
                }
                .zIndex(2) // Ensure this layer is above other content
            }
        }
    }
}
let storyviewModel = StoryViewModel()

#Preview {
    ThirdStorySample(viewModel: storyviewModel)
}
