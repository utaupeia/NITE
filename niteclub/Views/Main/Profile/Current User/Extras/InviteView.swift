//
//  InviteView.swift
//  niteclub
//
//  Created by +++ on 12/2/23.
//

import SwiftUI

struct InviteView: View {
    var body: some View {
        ZStack {
            Image("image37")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 400)
                .cornerRadius(30)
                .clipped()
            VStack {
                Spacer()
                Text("invite code")
                    .foregroundColor(.white)
                    .fontDesign(.serif)
                    .padding()
            }
        }
        .frame(width: 200, height: 400)
    }
}

#Preview {
    InviteView()
}
