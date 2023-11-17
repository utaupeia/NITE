//
//  StoryView.swift
//  niteclub
//
//  Created by +++ on 11/25/23.
//

//import SwiftUI
//
//struct StoryView: View {
//    @State private var progress: Double = 0
//    let story: StoryItem
//    let currentUser: User  // The user who is viewing the story
//
//    private var timeRemaining: TimeInterval {
//        max(story.postedDate.timeIntervalSinceNow + story.expiresAfter, 0)
//    }
//
//    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//
//    var body: some View {
//        VStack {
//            HStack {
//                // Profile Picture
//                Image(story.author.profilePicture) // Placeholder for profile picture
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 50, height: 50)
//                    .clipShape(Circle())
//
//                // Username
//                Text(story.author.username)
//                    .font(.headline)
//
//                Spacer()
//
//                // Time remaining
//                Text(timeString(from: timeRemaining))
//                    .font(.subheadline)
//            }
//            .padding()
//
//            Spacer()
//
//            // Story Content
//            Image(story.mediaURL) // Placeholder for the actual media content
//                .resizable()
//                .scaledToFit()
//
//            Spacer()
//        }
//        .onReceive(timer) { _ in
//            // Update the progress of the story
//            let totalDuration = story.expiresAfter
//            let elapsedTime = Date().timeIntervalSince(story.postedDate)
//            self.progress = elapsedTime / totalDuration
//        }
//        .onAppear {
//            // Initialize progress
//            let totalDuration = story.expiresAfter
//            let elapsedTime = Date().timeIntervalSince(story.postedDate)
//            self.progress = elapsedTime / totalDuration
//        }
//    }
//
//    private func timeString(from timeInterval: TimeInterval) -> String {
//        let minutes = Int(timeInterval) / 60 % 60
//        let seconds = Int(timeInterval) % 60
//        return String(format: "%02i:%02i", minutes, seconds)
//    }
//}
//
//let sampleStory = SampleData.johnStories[0]
//
//#Preview {
//    StoryView(story: sampleStory, currentUser: SampleData.userJohn)
//}
