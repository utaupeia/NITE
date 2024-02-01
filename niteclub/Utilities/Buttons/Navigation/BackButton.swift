//
//  BackButton.swift
//  niteclub
//
//  Created by +++ on 12/10/23.
//

import SwiftUI

struct BackButton: View {

    var body: some View {
            Button(action:  {
                withAnimation(.spring()) {
// back button with navstack 
                }
            }) {
                Circle()
                    .foregroundColor(.black.opacity(0.15))
                    .frame(width: 30, height: 30)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 6)
                    .overlay(
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 6, height: 12)
                        .foregroundColor(.white)
                    )
            }
        }
    }

#Preview {
    BackButton()
}
