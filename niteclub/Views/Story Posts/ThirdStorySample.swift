//
//  ThirdStorySample.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import SwiftUI

struct story: Identifiable {
    let id = UUID() // Unique identifier
    let storyName: String // The name of your image in the assets
    var hasBeenViewed: Bool = false // View status
}
// Sample data
let sampleStories: [story] = [
    story(storyName: "image1"),
    story(storyName: "image2"),
    story(storyName: "image3"),
    story(storyName: "image4"),
    story(storyName: "image5")
]
let gridStories: [story] = [
    story(storyName: "image6"),
    story(storyName: "image7"),
    story(storyName: "image8"),
    story(storyName: "image9"),
    story(storyName: "image10")
]
struct ThirdStorySample: View {
    @Namespace private var animation
    @State private var selectedStory: story? = nil
    @State private var isExpanded: Bool = false
    @State private var stories: [story] = sampleStories
    let columns: [GridItem] = [
        GridItem(.flexible(),spacing: nil, alignment: nil),
        GridItem(.flexible(),spacing: nil, alignment: nil),
    ]
    @State private var gridStoriesData: [story] = gridStories
    @StateObject private var tabBarState = TabBarState()
    var body: some View {
        ZStack {
//            Background()
            ScrollView {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach($stories) { $eachStory in
                                ZStack {
                                    Image(eachStory.storyName) // Use the storyName property
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .matchedGeometryEffect(id: eachStory.id, in: animation, isSource: !isExpanded)
                                        .frame(width: 96, height: 160)
                                        .cornerRadius(12)
                                        .onTapGesture {
                                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                                                isExpanded = true
                                                selectedStory = eachStory
                                                eachStory.hasBeenViewed = true  // Mark as viewed when story is tapped
                                            }
                                        }
                                    .zIndex(isExpanded ? 2 : 0)
                                    
                                    if !eachStory.hasBeenViewed {
                                        VariableBlurView()
                                            .frame(width: 96, height: 160)
                                            .allowsHitTesting(false) // Allow taps to pass through
                                    }
                                }
                                .cornerRadius(12)
                            }
                        }
                        .padding(.all)
                    }
                    
                    
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 3) {
                        ForEach(gridStoriesData) { gridStory in
                            // This is a simplified view for each story in the grid. You may want to create a custom view.
                                Image(gridStory.storyName)
                                .resizable()
                                .matchedGeometryEffect(id: gridStory.id, in: animation, isSource: !isExpanded)
                                .frame(height: 300)
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(18)
                            // Handling selection to expand the story, if needed
                            .onTapGesture {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                                    isExpanded = true
                                    selectedStory = gridStory
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            // Fullscreen cover
            if isExpanded, let expandedStory = selectedStory {
                ZStack {
                    Blur(style: .dark)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring()) {
                                isExpanded = false
                            }
                        }
                    Image(expandedStory.storyName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: expandedStory.id, in: animation) // using the unique ID for matchedGeometryEffect
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onTapGesture {
                            withAnimation(.spring()) {
//                                isExpanded = false
                                // Resetting the selected story here as well
//                                selectedStory = nil
                            }
                        }
                        .zIndex(isExpanded ? 3 : 0)
                    
                }
                .zIndex(2) // Make sure the overlay is on top of everything else
                .onAppear {
                    tabBarState.isHidden = true
                }
                .onDisappear {
                    tabBarState.isHidden = false
                }
            }
        }
    }
}
//struct storyEngagementElements: View {
////    var storyGroup: StoryGroup
////    var animation: Namespace.ID
////    @Binding var isExpanded: Bool // This needs to be passed from the parent view
//    @State private var currentImageIndex: Int = 0
//    let likeAction: () -> Void
//    let closeAction: () -> Void
//    let replyAction: () -> Void
//    var body: some View {
//        
//        ZStack {
//            VStack {
//                // Circles story tracker indicator
////                HStack {
////                    ForEach(storyGroup.stories.first!.images.indices, id: \.self) { index in
////                        Circle()
////                            .frame(width: 8, height: 8)
////                            .foregroundColor(index == currentImageIndex ? .white : .gray)
////                    }
////                }
////                .padding()
//                Spacer()
//                
//            }
//            
//            // Close Button
//            VStack {
//                HStack(alignment: .top) {
//                    Button(action: closeAction) {  // This action is provided when you use this button
//                        Image(systemName: "xmark")
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(
//                        Blur(style: .dark)
//                            .frame(width: 40, height: 40)
//                            .cornerRadius(20)
//                        )
//                    }
//                    Spacer()
//                    VStack(alignment: .trailing) {
//                        Button(action: {
////                             navigate to profile
//                        }) {
//                            Image("image4")
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 45, height: 75)
//                                .cornerRadius(9)
//                                .clipped()
//                        }
//                        // other user username
//                        Text("username")
//                            .foregroundColor(.white)
//                            .font(.system(size: 15, weight: .bold))
//                        Text("time remaining")
//                            .foregroundColor(.white)
//                            .font(.system(size: 13, weight: .medium))
//                    }
//                    .padding(.horizontal, 15)
//                    .padding(.vertical, 6)
//                }
//                Spacer()
//            }
//            .padding()
//            
//            // Action Buttons
//            VStack {
//                Spacer()
//                HStack {
//                    Button(action: likeAction) {  // This action is provided when you use this button
//                        Image(systemName: "heart")
//                            .padding()
//                            .background(Color.white.opacity(0.6))
//                            .clipShape(Circle())
//                    }
//                    
//                    Spacer()
//                    
//                    Button(action: replyAction) {  // This action is provided when you use this button
//                        Image(systemName: "arrowshape.turn.up.left")
//                            .padding()
//                            .background(Color.white.opacity(0.6))
//                            .clipShape(Circle())
//                    }
//                }
//                .padding()
//            }
//        }
//    }
//}
//let storyviewModel = StoryViewModel()

#Preview {
    ThirdStorySample()
}
