//
//  SignInEmail.swift
//  niteclub
//
//  Created by +++ on 11/19/23.
//

import SwiftUI

struct SignInEmail: View {
    //    @State private var email: String = ""
        @Binding var email: String
        @Binding var emailSet: Bool

        var changeFlow: (Flow) -> Void
        
        @State private var emailStatus: EmailStatus = .unchecked

        // Sample existing emails for testing
        let existingEmails = ["test@example.com", "user@existing.com", "sample@domain.com"]

        var body : some View {
            VStack {
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    TextField("email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundColor(.white)
                        .padding()
                        .multilineTextAlignment(.center) // Use this for alignment if needed
                        .frame(width: 300)
                        .background(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(.white)
                        )
    //                    .onChange(of: email, perform: { value in
    //                        checkEmail()
    //                    })
                    // pre ios17 ^ post ios17 --
                    
                        .onChange(of: email) {
                            checkEmail()
                        }


                    Spacer()
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring()) {
                        if emailStatus == .verified {
                            withAnimation(.spring()) {
                                changeFlow(.verificationCode)
                            }
                        } else {
                            // Optionally handle the case where the email is not verified
                        }
                    }
                    // Add else part if needed
                }) {
                    Text("Button")
                }
                .disabled(emailStatus != .verified)  // Disable the button unless the email is verified
                .padding()

            }
        }
        
        private func checkEmail() {
            emailStatus = .unchecked
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if isValidEmail(email) {
                    emailStatus = existingEmails.contains(email) ? .verified : .new
                }
            }
        }
    

        private func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: email)
        }
    }
//
//#Preview {
//    SignInEmail()
//}
