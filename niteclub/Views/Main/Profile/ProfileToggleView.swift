//
//  ProfileToggleView.swift
//  niteclub
//
//  Created by +++ on 11/11/23.
//

import SwiftUI


struct ProfileToggleView: View {
    @StateObject private var viewModel: UserViewModel
    @State private var isCurrentUser = true
    @State private var followsOverlay: Bool = false

    // Persistent references to the current user and another user
    private var currentUser: User
    private var otherUser: User

    init(currentUser: User, otherUser: User) {
        self.currentUser = currentUser
        self.otherUser = otherUser
        _viewModel = StateObject(wrappedValue: UserViewModel())
    }

    var body: some View {
        ZStack {
            Color.gray
            VStack {
                ProfileElements(viewModel: viewModel, followsOverlay: $followsOverlay)

                Button(action: {
                }) {
                    Text("Switch to \(isCurrentUser ? "Other User" : "Current User")")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
        }
    }

}

// Sample data for the preview
struct ProfileToggleView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample user for the preview
        let sampleCurrentUser = User(username: "guy1", profilePicture: "image3", selectedTheme: sampleTheme, dateJoined: Date(), location: "nyc") // Initialize with sample data
        let sampleOtherUser = User(username: "mryuh34", profilePicture: "image8", selectedTheme: sampleTheme, dateJoined: Date(), location: "az") // Initialize with sample data

        ProfileToggleView(currentUser: sampleCurrentUser, otherUser: sampleOtherUser)
    }
}

