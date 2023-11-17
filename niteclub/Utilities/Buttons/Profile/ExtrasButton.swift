//
//  ExtrasButton.swift
//  niteclub
//
//  Created by +++ on 12/2/23.
//

import SwiftUI

struct ExtrasButton: View {
    @Binding var fullScreenContainer: Bool
    @Binding var showExtras: Bool
    var body: some View {
        Button(action:  {
            withAnimation(.spring()) {
                showExtras.toggle()
            }
        }) {
            Circle()
                .foregroundColor(.black.opacity(0.15))
                .frame(width: 30, height: 30)
                .padding(.horizontal, 15)
                .padding(.vertical, 6)
                .overlay(
                Image(systemName: "square.stack")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.white)
                )
        }
    }
}

//#Preview {
//    ExtrasButton()
//}
