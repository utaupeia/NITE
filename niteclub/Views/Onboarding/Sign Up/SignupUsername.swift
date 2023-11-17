//
//  SignupUsername.swift
//  niteclub
//
//  Created by +++ on 11/19/23.
//

import SwiftUI

struct SignupUsername: View {
    //    @State private var username: String = ""
        @Binding var username: String
        @Binding var usernameSet: Bool
        var changeFlow: (Flow) -> Void
        @State private var isUsernameAvailable: Bool = false

        let existingUsernames = ["user123", "sampleuser", "usernameexists"] // Sample usernames

        var body: some View {
            VStack {
                TextField("username", text: usernameBinding)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .multilineTextAlignment(.center) // Use this for alignment if needed
                    .frame(width: 300)
                    .padding()
                    .background(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(!isUsernameAvailable && !username.isEmpty ? .red : .white)
                    )
    //                .onChange(of: username) { newUsername in
    //                    checkUsernameAvailability(newUsername: newUsername)
    //                }
                    .onChange(of: username) {
                        checkUsernameAvailability()
                    }

                Button(action: {
                    withAnimation(.spring()) {
                        changeFlow(.signUpBirthdate)
                        
                        username = self.username
                        usernameSet = true
                        
                    }
                }) {
                    Text("Continue")
                }
                .padding()
            }
        }
        
        private func checkUsernameAvailability() {
            isUsernameAvailable = !existingUsernames.contains(username) && !username.isEmpty
        }



        private var usernameBinding: Binding<String> {
            Binding(
                get: { self.username },
                set: {
                    var updatedUsername = $0.lowercased().filter { $0.isLowercase || $0.isNumber || $0 == "-" }

                    // Ensure the username is at least 2 characters long
                    if updatedUsername.count < 2 {
                        updatedUsername = ""  // Reset if not long enough
                    }

                    // Ensure it doesn't start or end with special characters
                    if updatedUsername.hasPrefix("*") || updatedUsername.hasPrefix("-") ||
                       updatedUsername.hasSuffix("*") || updatedUsername.hasSuffix("-") {
                        updatedUsername = String(updatedUsername.dropFirst())
                    }

                    self.username = updatedUsername
                }
            )
        }

    }


//#Preview {
//    SignupUsername()
//}
