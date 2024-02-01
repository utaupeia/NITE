//
//  MainScreen.swift
//  niteclub
//
//  Created by +++ on 11/15/23.
//

import SwiftUI

<<<<<<< HEAD
enum Flow {
    case mainScreen
    
    case inviteCode
    
    case signUpEmail
    case signUpBirthdate
    case signUpUsername

    case profilePicEntry
    
    case verificationCode
    
    case signIn
}

enum EmailStatus {
    case unchecked
    case exists
    case new
    case verified
}

struct MainView: View {
    @State private var currentFlow: Flow = .mainScreen

    @State private var email: String = ""
    @State private var username: String = ""
    @State private var emailSet: Bool = false
    @State private var usernameSet: Bool = false

    @State private var offset: CGFloat = 0

    var body: some View {
        ZStack {
            Color.black.opacity(0.28).ignoresSafeArea()
            
            switch currentFlow {
            case .mainScreen:
                mainScreenView
            case .inviteCode:
                InviteCodeView(changeFlow: { currentFlow = $0 })
            case .signUpEmail:
                SignupEmail(email: $email,emailSet: $emailSet, changeFlow: { currentFlow = $0 })
            case .signUpBirthdate:
                SignupBirthdate(changeFlow: { currentFlow = $0 })
            case .signUpUsername:
                SignupUsername(username: $username,usernameSet: $usernameSet, changeFlow: { currentFlow = $0 })
            case .profilePicEntry:
                ProfilePicEntryView(changeFlow: { currentFlow = $0 })
            case .verificationCode:
                VerificationCodeView(changeFlow: { currentFlow = $0 })
            case .signIn:
                SignInEmail(email: $email, emailSet: $emailSet, changeFlow: {currentFlow = $0 })
            }
            
            if currentFlow == .mainScreen {
            } else {
                VStack {
                    HStack(alignment: .top) {
                        
                        Button(action: {
                            withAnimation(.spring()) {
                                offset = 0 // Reset the offset to 0
                                currentFlow = .mainScreen
                            }
                        })
                        {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.white)
                                .frame(width: 24, height: 24)
                        }
                        .padding(.top, 30)
                        .padding(.leading, 30)

                        Spacer()
                        
                        VStack {
                            if emailSet {
                                
                                Text("\(email)")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            
                            if usernameSet {
                                Text("\(username)")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding()
                            }
                        }
                        .padding()
                        .background(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(.white)
                        )
                        .padding(30)

                    }
                    Spacer()
                }
            }
        }
    }
    private var mainScreenView: some View {
        VStack {
            Button("sign up") {
                withAnimation(.spring()) {
                    offset = UIScreen.main.bounds.height // Move the buttons off-screen down
                    
                    currentFlow = .inviteCode
                }
            }
            .foregroundColor(.white)
            .padding(30)
//            .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
            
            Spacer()
            
            Button("sign in") {
                withAnimation(.spring()) {
                    offset = -UIScreen.main.bounds.height // Move the buttons off-screen upwards
                    currentFlow = .signIn
                }
            }
            .foregroundColor(.white)
            .padding(30)
//            .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
        }
        .offset(y: offset) // Apply the offset here
    }
}

#Preview {
    MainView()
=======
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
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
}
