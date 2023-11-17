//
//  SignupBirthdate.swift
//  niteclub
//
//  Created by +++ on 11/19/23.
//

import SwiftUI

struct SignupBirthdate: View {
    var changeFlow: (Flow) -> Void

    @State private var month: String = ""
    @State private var day: String = ""
    @State private var year: String = ""

    // Define the Field enum inside the SignUpBirthdate struct
    enum Field {
        case month, day, year
    }

    @FocusState private var focusedField: Field?

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                TextField("MM", text: $month)
                    .focused($focusedField, equals: .month)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(9)
                    .border(.white)
//                    .onChange(of: month) {
//                        if day.count == 2 {
//                            focusedField = .day
//                        }
//                    }
//                    .onChange(of: month) { newValue in
//                        if newValue.count == 2 {
//                            focusedField = .day
//                        }
//                    }

                Text("/")
                    .foregroundColor(.white)
                    .padding()
                
                TextField("DD", text: $day)
                    .focused($focusedField, equals: .day)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(9)
                    .border(.white)
//                    .onChange(of: day) {
//                        if month.count == 2 {
//                            focusedField = .year
//                        }
//                    }
//                    .onChange(of: day) { newValue in
//                        if newValue.count == 2 {
//                            focusedField = .year
//                        }
//                    }

                Text("/")
                    .foregroundColor(.white)
                    .padding()

                TextField("YY", text: $year)
                    .focused($focusedField, equals: .year)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(9)
                    .border(.white)
            }
            .padding()
            .padding()
            
            Button(action: {
                if isValidBirthdate(month: month, day: day, year: year) {
                    changeFlow(.profilePicEntry)
                    // Process the birthdate here
                } else {
                    // Handle invalid birthdate
                }
            }) {
                Text("Next")
            }
            .padding()
        }
        .onAppear {
            focusedField = .month
        }
    }

    private func isValidBirthdate(month: String, day: String, year: String) -> Bool {
        // Add validation logic for the birthdate here
        return true
    }
}

//#Preview {
//    SignupBirthdate()
//}
