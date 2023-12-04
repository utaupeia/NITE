//
//  ProfileImageContentView.swift
//  niteclub
//
//  Created by +++ on 10/31/23.
//

import SwiftUI

struct ProfileImageContentView: View {
    var user: User

    let sampleimages = ["p23"]
    let imageNames = ["story1", "story2", "story3", "story4"]
    let imageNames2 = ["album8","album9"]
    @State private var isGridView = true
    @State private var showHiddenImages = false
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(spacing: 0) {
                
                // Full view button
                HStack {
                    Button(action: {
                        withAnimation {
                            isGridView.toggle()
                        }
                    }) {
                        Text(isGridView ? "Full View" : "Grid View")
                            .padding()
                            .foregroundColor(.white)
                            .cornerRadius(12)
                }
                    Spacer()
                }
                // Define columns based on the view type
                let columns: [GridItem] = isGridView ? [
                    GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2),
                    GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2),
                    GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2)
                ] : [GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 2)]
                LazyVGrid(columns: columns, spacing: 2) {
                    // Display your images
                    ForEach(0..<12) { index in
                        Blur(style: .dark)
                            .frame(maxWidth: .infinity)
                            .frame(height: isGridView ? 240 : 500)
//                        height of list view will be whatever the height of the image is
//                        and will be able to swipe if multi pic
                    }
                    if showHiddenImages {
                        // hidden images, on bottom, long press should provide overlay that allows you to show image again in normal loop
                        ForEach(0..<6) { index in
                            Blur(style: .light)
                                .frame(maxWidth: .infinity)
                                .frame(height: isGridView ? 240 : 500)
                        }
                    }
                }
                .cornerRadius(24)
                .padding(.horizontal, 3)
                
                // only if profile is yours
                Button(action: {
                    withAnimation {
                        showHiddenImages.toggle()
                    }
                }) {
                    Text(showHiddenImages ? "Hide Hidden" : "Show Hidden")
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
        }
    }
}


#Preview {
    ProfileImageContentView(user: sampleUser)
}
