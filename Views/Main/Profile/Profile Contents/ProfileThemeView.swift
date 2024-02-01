//
//  ProfileThemeView.swift
//  niteclub
//
//  Created by +++ on 11/2/23.
//

import SwiftUI

struct ProfileThemeView: View {
    
    var user: User

    let columns: [GridItem] = [
        GridItem(.flexible(),spacing: nil, alignment: nil),
        GridItem(.flexible(),spacing: nil, alignment: nil),
    ]
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns) {
                    ForEach(0..<6) { index in
                        VStack(alignment: .leading) {
                            Blur(style: .systemChromeMaterialDark)
                            .frame(height: 380)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(21)
                                
                            VStack(alignment: .leading) {
                                    
                                    Text("Theme Name")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.white.opacity(0.75))
                                    Text("CreaterName")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                    Text("Created on : 00/00/00")
                                        .font(.footnote)
                                        .foregroundColor(Color.white.opacity(0.25))
                                        .padding(.bottom)
                                }
                        }
                    }
                }         .padding(.top)
        }
        .padding(.horizontal, 6)
    }
}

#Preview {
    ProfileThemeView(user: sampleUser)
}
