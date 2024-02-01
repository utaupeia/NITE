//
//  SelectedThemeView.swift
//  niteclub
//
//  Created by +++ on 11/24/23.
//

import SwiftUI

struct SelectedThemeView: View {
    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        ZStack {
            if let themeImageName = viewModel.user?.selectedTheme.content.themeURL {
                Image(themeImageName) // Load image directly from assets
                    .resizable()
                    .scaledToFill()
                    .clipped()
            } else {
                // Fallback image or view if the URL is not available
                Color.blue.opacity(0.7)
            }
//            Blur(style: .dark)
//                .opacity(0.0)

        }
        .frame(width: UIScreen.main.bounds.width, height: .infinity)
    }

    // Function to load an image from a URL string
    private func loadImageFromURLString(_ urlString: String) -> Image {
        if let url = URL(string: urlString), let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        } else {
            return Image("DefaultImage") // replace with your default image name
        }
    }
    private func loadImage(named imageName: String) -> Image {
        Image(imageName) // Assumes `imageName` is the name of an image in your asset catalog
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
