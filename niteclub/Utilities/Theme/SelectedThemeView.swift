//
//  SelectedThemeView.swift
//  niteclub
//
//  Created by +++ on 11/24/23.
//

import SwiftUI

struct SelectedThemeView: View {
    let user: User  // The user whose selected theme is to be displayed

    var body: some View {
        ZStack {

            // Load and display a local image or a system symbol as a placeholder
            // Replace with your actual image loading logic in the real app
            Image(user.selectedTheme.content.themeURL)
                .resizable()
                .scaledToFill()
//                .frame(width: UIScreen.main.bounds.width)
//                .frame(height: .infinity)
                .clipped()
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            Blur(style: .dark)
                .opacity(0.85)
            // using for now to distort image for visibility
        }
        .frame(width: UIScreen.main.bounds.width)
        .frame(height: .infinity)
//        .border(.red)
//        .ignoresSafeArea()
    }
}

//struct SelectedThemeView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        // Return the ThemeView for preview
//        SelectedThemeView(user: SampleData.userEmma)
//            .previewLayout(.sizeThatFits)
//    }
//}

//#Preview {
//    SelectedThemeView()
//}
