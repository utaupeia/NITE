//
//  MainScreen.swift
//  niteclub
//
//  Created by +++ on 11/15/23.
//

import SwiftUI

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
}
