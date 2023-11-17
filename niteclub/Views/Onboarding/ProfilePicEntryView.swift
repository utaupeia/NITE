//
//  ProfilePicEntryView.swift
//  niteclub
//
//  Created by +++ on 11/19/23.
//

import SwiftUI

struct ProfilePicEntryView: View {
    var changeFlow: (Flow) -> Void

    var body : some View {
        
        ZStack {
            Button(action: {
            }) {
                RoundedRectangle(cornerRadius: 24)
                    .frame(width: 108, height: 180)
            }
            
            VStack {
                Spacer()
                Button(action: {
                    changeFlow(.verificationCode)

                })
                {
                    Text("enter niteclub")
                }
                .padding()
            }
        }
    }
}

//#Preview {
//    ProfilePicEntryView()
//}
