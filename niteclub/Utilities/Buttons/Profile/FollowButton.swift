//
//  FollowButton.swift
//  niteclub
//
//  Created by +++ on 12/9/23.
//

import SwiftUI

extension User {
    func isFollowedBy(user: User) -> Bool {
        return user.following.contains(self.id)
    }
}

enum FollowState:Equatable, Hashable {
    case notFollowing(isFollowedByOther: Bool)
    case following(showOptions: Bool)
    case closeFriends(showFollowing: Bool)
    case unfollowing
    
}
// MARK: need to make unfollow button return follow or follow back depending on relationship
struct FollowButton: View {
    @ObservedObject var userViewModel: UserViewModel
    var otherUser: User  // Directly pass the 'otherUser' to the FollowButton
    @Namespace private var animationNamespace
    @State private var followState: FollowState = .following(showOptions: true)
    @State private var blurPosition: CGFloat = 0
    @State private var isButtonVisible = true
    @State private var autoTurnOffTimer: Timer?
    
    init(userViewModel: UserViewModel, otherUser: User) {
        self.userViewModel = userViewModel
        self.otherUser = otherUser
    }
    
    var body: some View {
        ZStack {
                ZStack(alignment: .center) {
                    // Blur
//                    if followState != .notFollowing(isFollowedByOther: true) && followState != .notFollowing(isFollowedByOther: false) {
//                        Blur(style: .dark)
//                            .cornerRadius(21)
//                            .frame(width: 28, height: 28)
//                            .offset(x: blurPosition)
//                            .matchedGeometryEffect(id: "background", in: animationNamespace)
//                    }
                    
                    HStack(spacing: 0) {
                        
                        if followState == .notFollowing(isFollowedByOther: true) {
                            Button("Follow Back") {
                                withAnimation {
                                    userViewModel.follow(user: otherUser)
                                    
                                    followState = .following(showOptions: false)
                                }
                            }
                            .font(.system(size: 12))
                            .fontDesign(.monospaced)
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 18)

                        } else if followState == .notFollowing(isFollowedByOther: false) {
                            Button("follow".uppercased()) {
                                withAnimation {
                                    userViewModel.follow(user: otherUser)
                                    
                                    followState = .following(showOptions: false)
                                    
                                }
                            }
                            .font(.system(size: 12))
                            .fontDesign(.monospaced)
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 18)
                            //                    .padding(.vertical, 6)
                            //                    .padding(.horizontal, 18)
                            

                        }
                        
                        
                        if case .following(let showOptions) = followState {
                            if showOptions {
                                Button(action: {
                                    // Move the blur immediately
                                    withAnimation {
                                        blurPosition = calculateBlurPosition(for: .unfollowing)
                                        userViewModel.unfollow(user: otherUser)
                                        userViewModel.removeCloseFriend(user: otherUser)
                                        
                                    }
                                    // Delay the state change to show Follow/Follow Back
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 1-second delay
                                        withAnimation {
                                            followState = .notFollowing(isFollowedByOther: true)
                                        }
                                    }
                                }) {
                                    Image(systemName: "person.fill.xmark.rtl")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white.opacity(0.25))
                                        .padding(.vertical, 5)
                                        .padding(.leading, 18)
                                        .padding(.trailing, 9)


                                }
                                
                                Button(action: {
                                    withAnimation {
                                        followState = .following(showOptions: !showOptions)
                                        
                                    }
                                }) {
                                    Image(systemName: "person.fill.checkmark")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 9)
                                }
                                
                                Button(action: {
                                    withAnimation {
                                        followState = .closeFriends(showFollowing: false)
                                        //                                        userViewModel.addCloseFriend(user: otherUser)
                                        userViewModel.addCloseFriend(user: otherUser)
                                        
                                    }
                                }) {
                                    Image(systemName: "heart")
                                        .font(.system(size: 12))
                                        .foregroundColor(.pink)
                                        .padding(.vertical, 5)
                                        .padding(.trailing, 18)
                                        .padding(.leading, 9)
                                }
                                
                            } else {
                                Button(action: {
                                    withAnimation {
                                        followState = .following(showOptions: true)
                                    }
                                }) {
                                    Image(systemName: "person.fill.checkmark")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 18)

                                }
                            }
                        }
                        
                        if case .closeFriends(let showFollowing) = followState {
                            if showFollowing {
                                Button(action: {
                                    withAnimation {
                                        followState = .following(showOptions: true)
                                        //                                        userViewModel.removeCloseFriend(user: otherUser)
                                        userViewModel.removeCloseFriend(user: otherUser)
                                        
                                    }
                                }) {
                                    Image(systemName: "person.fill.checkmark")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 18)
                                }
                                
                                
                                Button(action: {
                                    withAnimation {
                                        followState = .closeFriends(showFollowing: !showFollowing)
                                    }
                                }) {
                                    Image(systemName: "heart")
                                        .font(.system(size: 12))
                                        .foregroundColor(.pink)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 18)
                                }
                                
                            } else {
                                Button(action: {
                                    withAnimation {
                                        followState = .closeFriends(showFollowing: true)
                                    }
                                }) {
                                    Image(systemName: "heart.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(.pink)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 18)

                                }
                                
                            }
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(.white)
//                            .opacity(backgroundOpacity(for: followState))
                    )
                    .padding(.vertical, 3)
//                    .frame(width: 12, height: 12)
//                    .foregroundColor(.white)
//                    .padding(.vertical, 6)
//                    .padding(.horizontal, 18)
//                    .overlay(
//                    RoundedRectangle(cornerRadius: 24)
//                        .stroke(.white.opacity(0.25), lineWidth: 1)
//                    )
//                    .padding(.vertical, 3)
//                    .padding(.horizontal, 15)

                }
                .onChange(of: followState) {
                    // Pre ios17
                    //        .onChange(of: followState) { newState in
                    withAnimation {
                        blurPosition = calculateBlurPosition(for: followState)
                    }
                }
            //        .onChange(of: followState) { _ in
            .onChange(of: followState) {
                autoTurnOffTimer?.invalidate() // Invalidate any existing timer
                
                switch followState {
                case .following(true), .closeFriends(true):
                    // Start a new timer when one of these specific cases is active
                    autoTurnOffTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                        withAnimation {
                            switch followState {
                            case .following:
                                followState = .following(showOptions: false)
                            case .closeFriends:
                                followState = .closeFriends(showFollowing: false)
                            default:
                                break
                            }
                        }
                    }
                default:
                    break
                }
            }
        }
        .onAppear {
            // Move the follow state initialization here
            let otherUserFollowsYou = userViewModel.checkIfUserFollowsYou(otherUser: otherUser)
            followState = userViewModel.userIsFollowed ? .following(showOptions: false) : .notFollowing(isFollowedByOther: otherUserFollowsYou)
        }

    }
    
    // ... existing functions ...
    
    // Call this function in all button actions to reset the timer
    private func resetTimer() {
        autoTurnOffTimer?.invalidate()
        autoTurnOffTimer = nil
    }
    
    private func handleButtonTap() {
        // Show buttons and start a timer to auto-dismiss them after 2 seconds
        isButtonVisible = true
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            // Auto-dismiss buttons after 2 seconds
            isButtonVisible = false
        }
    }
    
    private func backgroundOpacity(for state: FollowState) -> Double {
        switch state {
        case .following(showOptions: true), .closeFriends(showFollowing: true),
                .notFollowing(isFollowedByOther: true), .notFollowing(isFollowedByOther: false):
            return 1.0
        default:
            return 0.0
        }
    }
    
    private func calculateBlurPosition(for state: FollowState) -> CGFloat {
        // Calculate and return the position based on the state
        // Placeholder values, adjust based on your layout
        switch state {
        case .notFollowing(isFollowedByOther: true):
            return 0 // Position for "Follow Back" button
        case .notFollowing(isFollowedByOther: false):
            return 0 // Position for "Follow" button
        case .following(showOptions: false):
            return 0 // Position for "Following" button
        case .following(showOptions: true):
            return 0 // Position for "Following" button with options
        case .closeFriends(showFollowing: false):
            return 0 // Position for "Close Friends" button
        case .closeFriends(showFollowing: true):
            return 24 // Position for "Close Friends" button with options
        case .unfollowing:
            return -50 // Position for Unfollowing (adjust as needed)
            
        }
    }
}


#Preview {
    FollowButton(userViewModel: UserViewModel(), otherUser: SampleData.userEmma)
}

//    init(userViewModel: UserViewModel, otherUser: User) {
//        self.userViewModel = userViewModel
//        self.otherUser = otherUser
//
//        // Check the following state between current user and otherUser
//        userViewModel.checkIfUserIsFollowed(otherUser: otherUser)
//        let otherUserFollowsYou = userViewModel.checkIfUserFollowsYou(otherUser: otherUser)
//
//        // Initialize the followState based on the follow status
//        if userViewModel.userIsFollowed {
//            _followState = State(initialValue: .following(showOptions: false))
//        } else {
//            _followState = State(initialValue: .notFollowing(isFollowedByOther: otherUserFollowsYou))
//        }
//    }
