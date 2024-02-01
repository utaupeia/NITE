//
//  DmButton.swift
//  niteclub
//
//  Created by +++ on 12/4/23.
//

import SwiftUI

struct DmButton: View {
    @Binding var isDMVisible: Bool
    var onTapped: () -> Void  // Closure to execute on button tap

    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                isDMVisible = true
                onTapped()  // Call the closure
            }
        }) {
            RoundedRectangle(cornerRadius: 3)
                .stroke(.white, lineWidth: 1)
                .frame(width: 12, height: 12)
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 18)
                .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(.white.opacity(0.25), lineWidth: 1)
                )
                .padding(.vertical, 3)
                .padding(.trailing, 15)
                .padding(.leading, 6)
        }
    }
}
