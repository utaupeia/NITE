//
//  ThemeView.swift
//  niteclub
//
//  Created by +++ on 11/24/23.
//

import SwiftUI

// MARK: Replace with actual image loading logic in the real app

struct ThemeView: View {
    let theme: Theme

    var body: some View {
        ZStack {

            // Load and display a local image or a system symbol as a placeholder
            // Replace with your actual image loading logic in the real app
            Image(theme.content.themeURL)
                .resizable()
                .scaledToFill()
                .clipped()
            
            Blur(style: .dark)
            // using for now to distort image for visibility
        }
        .ignoresSafeArea()
    }
}


struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample theme for the preview
        let sampleThemeContent = ThemeContent(id: UUID(), themeURL: "image35")
        let sampleTheme = Theme(id: UUID(), name: "Sample Theme", content: sampleThemeContent, price: 1.99, creationDate: Date(), creator: UUID(), approved: true)

        // Return the ThemeView for preview
        ThemeView(theme: sampleTheme)
            .previewLayout(.sizeThatFits)
    }
}



//#Preview {
//    ThemeView()
//}
