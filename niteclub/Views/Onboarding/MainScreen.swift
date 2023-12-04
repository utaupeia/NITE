//
//  MainScreen.swift
//  niteclub
//
//  Created by +++ on 11/15/23.
//

import SwiftUI

struct MainScreen: View {
    @State private var showSignUp: Bool = true
    var body: some View {
        ZStack {
//            Image("image25")
//                .resizable()
//                .scaledToFill()
//                .clipped()
//                .overlay( Blur(style: .light).opacity(0.95))
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            VStack {
                VariableBlurView()
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: 130)
                    .border(.green)
                Spacer()
                VariableBlurView()
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: 120)
                    .rotationEffect(Angle(degrees: 180))
                    .border(.green)


            }
            .ignoresSafeArea()
            
            // buttons
            VStack {
                Button(action: {
                    
                })
                {
                    Text("signup")
                        .foregroundColor(.white)
                        .padding()
                        .border(.red)
                }
                
                //swipe gesture from up to down = signup
                Spacer()
                

                Button(action: {
                    
                })
                {
                    Text("signin")
                        .foregroundColor(.white)
                        .padding()
                }
            .border(.red)
                //swipe gesture from down to up = signin
            }
            
            if showSignUp {
                signUpView()
            }
        }
    }
}

struct signUpView: View {
    @State private var username: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var email: String = ""
    @State private var showInviteView: Bool = false

    var body : some View {
        VStack {
            
            TextField("Username", text: usernameBinding)
                .padding()
                .border(.red)
                .autocapitalization(.none)
                .disableAutocorrection(true)

            
            DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                .padding()
            
            TextField("Email", text: $email)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .padding()
            .border(.red)

        }
    }
}

extension signUpView {
    private var usernameBinding: Binding<String> {
        Binding(
            get: { self.username },
            set: {
                var updatedUsername = $0.lowercased().filter { $0.isLowercase || $0.isNumber || $0 == ":" }

                // Ensure the username is at least 2 characters long
                if updatedUsername.count < 2 {
                    updatedUsername = ""  // Reset if not long enough
                }

                // Ensure it doesn't start or end with special characters
                if updatedUsername.hasPrefix("*") || updatedUsername.hasPrefix(":") ||
                   updatedUsername.hasSuffix("*") || updatedUsername.hasSuffix(":") {
                    updatedUsername = String(updatedUsername.dropFirst())
                }

                self.username = updatedUsername
            }
        )
    }
}



#Preview {
    MainScreen()
}
