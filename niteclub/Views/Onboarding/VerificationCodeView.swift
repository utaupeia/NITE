//
//  VerificationCodeView.swift
//  niteclub
//
//  Created by +++ on 11/19/23.
//

import SwiftUI

// MARK : 
// - Need to create user if user is new 
// - Need to login and authenticate if user is existing

struct VerificationCodeView: View {
    var changeFlow: (Flow) -> Void
    @State private var enteredCode: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedField: Int?
    @State private var isCodeCorrect: Bool? = nil

    let sampleVerificationCode = "123456" // Sample verification code

    var body : some View {
        VStack {
            Spacer()
            
            HStack(spacing: 10) {
                ForEach(0..<6, id: \.self) { index in
                    TextField("", text: $enteredCode[index])
                        .focused($focusedField, equals: index)
                        .frame(width: 40, height: 60)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .border(isCodeCorrect == false ? Color.red : Color.white)
                        .onChange(of: enteredCode[index], initial: false) {
                            handleCodeChange(for: index)
                        }

//                        .onChange(of: enteredCode[index]) { newValue in
//                            let filtered = newValue.filter { "0123456789".contains($0) }
//                            if filtered.count > 1 {
//                                enteredCode[index] = String(filtered.prefix(1))
//                            } else {
//                                enteredCode[index] = filtered
//                                if filtered.count == 1 && index < 5 {
//                                    focusedField = index + 1
//                                }
//                            }
//                        }
                    
                }
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                let code = enteredCode.joined()
                isCodeCorrect = code == sampleVerificationCode
                if isCodeCorrect == true {
                    withAnimation(.spring()) {
//                        changeFlow(whateverNextFlowIs) // Replace with the actual next flow
                    }
                }
            }) {
                Text("Submit")
            }
            .disabled(enteredCode.contains(where: { $0.isEmpty }))
            .padding()

            Button(action: {
                // Resend code logic here
                enteredCode = Array(repeating: "", count: 6)
                focusedField = 0
            }) {
                Text("Resend Code")
            }
            .padding()
        }
    }
    private func handleCodeChange(for index: Int) {
        if enteredCode[index].count == 1 && index < 5 {
            focusedField = index + 1
        } else if enteredCode[index].count > 1 {
            enteredCode[index] = String(enteredCode[index].prefix(1))
        }
    }

}

//#Preview {
////    VerificationCodeView()
//}
