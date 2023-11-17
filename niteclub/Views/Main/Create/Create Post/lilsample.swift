//
//  lilsample.swift
//  niteclub
//
//  Created by +++ on 12/2/23.
//

import SwiftUI

struct lilsample: View {
    let items = [1, 2, 3, 4, 5] // Replace with last 10 images of gallery

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                VStack {
                    Button(action: {
                        // Open Camera
                    }) {
                        Blur(style: .dark)
                            .frame(width: 90, height: 106)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        // Open Gallery
                    }) {
                        Blur(style: .dark)
                            .frame(width: 90, height: 106)
                            .cornerRadius(12)
                    }
                }
                
                HStack {
                    ForEach(items, id: \.self) { item in
                        Blur(style: .dark)
                            .frame(width: 160, height: 220)
                            .cornerRadius(18)

                        // Additional view modifiers or content can be added here
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    lilsample()
}
