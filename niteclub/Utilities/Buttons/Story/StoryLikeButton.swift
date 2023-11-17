//
//  StoryLikeButton.swift
//  niteclub
//
//  Created by +++ on 11/15/23.
//

import SwiftUI

struct StoryLikeButton: View {
    var body: some View {
        Blur(style: .dark)
            .frame(width: 30)
            .frame(height: 30)
            .cornerRadius(15)
    }
}

#Preview {
    StoryLikeButton()
}
