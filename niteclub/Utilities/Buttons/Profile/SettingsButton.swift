//
//  SettingsButton.swift
//  niteclub
//
//  Created by +++ on 12/2/23.
//

import SwiftUI

struct SettingsButton: View {
    @Binding var showSettings: Bool
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                showSettings.toggle()
            }
        }) {
            Image(systemName: "option")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 18)
                .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(.white.opacity(0.25), lineWidth: 1)
                )
                .padding(.vertical, 3)
                .padding(.horizontal, 15)
        }
    }
}


#Preview {
    SettingsButton(showSettings: .constant(false))
}
