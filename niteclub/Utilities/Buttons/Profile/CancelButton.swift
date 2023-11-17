//
//  CancelButton.swift
//  niteclub
//
//  Created by +++ on 12/2/23.
//

import SwiftUI

struct CancelButton: View {
    var action: () -> Void = {}
    var body: some View {
        Button(action: action) {
            Circle()
                .foregroundColor(.black.opacity(0.15))
                .frame(width: 30, height: 30)
                .padding(.horizontal, 15)
                .padding(.vertical, 6)
                .overlay(
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.white)
                )
        }
    }
}


#Preview {
    CancelButton()
}
