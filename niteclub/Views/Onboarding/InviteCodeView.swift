//
//  InviteCodeView.swift
//  niteclub
//
//  Created by +++ on 11/19/23.
//

import SwiftUI

struct InviteCodeView: View {
    var changeFlow: (Flow) -> Void
    @State private var enteredCode: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedField: Int?
    @State private var isCodeCorrect: Bool? = nil

    let sampleInviteCode = "ABC123" // invite code needs to tethered to a user

    var body: some View {
        VStack {
            Spacer()

            HStack {
                ForEach(0..<6, id: \.self) { index in
                    TextField("", text: $enteredCode[index])
                        .focused($focusedField, equals: index)
                        .frame(width: 40, height: 60)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .border(isCodeCorrect == false ? Color.red : Color.white)
                        .textContentType(.oneTimeCode)
                        .keyboardType(.asciiCapable)
                        .onChange(of: enteredCode[index]) {
                            moveToNextField(after: index)
                        }
//                        .onChange(of: enteredCode[index]) { _ in
//                            moveToNextField(after: index)
//                        }
                }
            }
            .padding()

            Spacer()

            Button(action: {
                let code = enteredCode.joined()
                isCodeCorrect = code == sampleInviteCode
                if isCodeCorrect == false {
                    resetCodeFields()  // Call the reset function when the code is incorrect
                } else {
                    changeFlow(.signUpEmail)
                }

            }) {
                Text("Submit")
            }
            .padding()
        }
        .onAppear {
            focusedField = 0
        }
    }
    
    private func resetCodeFields() {
        enteredCode = Array(repeating: "", count: 6)
        focusedField = 0
    }


    private func moveToNextField(after currentIndex: Int) {
        if enteredCode[currentIndex].count > 1 {
            enteredCode[currentIndex] = String(enteredCode[currentIndex].first!)
        }

        if currentIndex < 5 && enteredCode[currentIndex].count == 1 {
            focusedField = currentIndex + 1
        }
    }
}


//#Preview {
//    InviteCodeView()
//}
