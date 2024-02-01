//
//  SearchButton.swift
//  niteclub
//
//  Created by +++ on 12/4/23.
//

import SwiftUI

struct SearchButton: View {
    @Binding var isExpanded: Bool
    @Binding var blurHeight: CGFloat
    let maxHeight: CGFloat
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                isExpanded.toggle()
                blurHeight = isExpanded ? maxHeight : 100
            }
        }) {
            Circle()
                .stroke(.white, lineWidth: 1)
                .frame(width: 12, height: 12)
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(.white.opacity(0.25), lineWidth: 1)
                )
                .padding(.vertical, 3)
                .padding(.trailing, 6)
                .padding(.leading, 15)
        }
    }
}
