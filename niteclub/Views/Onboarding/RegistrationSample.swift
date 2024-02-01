//
//  RegistrationSample.swift
//  niteclub
//
//  Created by +++ on 1/26/24.
//

import SwiftUI

struct RegistrationSample: View {
    @StateObject var viewModel = UserViewModel()
    @State private var username: String = ""
    @State private var inviteCode: String = ""
    // Other state properties...

    var body: some View {
        VStack {
            TextField("Username", text: $username)
            TextField("Invite Code", text: $inviteCode)
            // Other input fields...

            Button("Register") {
//                viewModel.registerUser(
//                    withInviteCode: inviteCode,
//                    username: username,
//                    profilePicture: "profilePicUrl",
//                    selectedTheme: Theme.defaultTheme,
//                    dateJoined: Date(),
//                    location: "userLocation"
//                )
            }
        }
    }
}


#Preview {
    RegistrationSample()
}
