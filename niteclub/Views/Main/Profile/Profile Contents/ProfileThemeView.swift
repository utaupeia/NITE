//
//  ProfileThemeView.swift
//  niteclub
//
//  Created by +++ on 11/2/23.
//

import SwiftUI
<<<<<<< HEAD
import AVKit

struct ProfileThemeView: View {
    var user: User

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text("Theme Collection")
                    .foregroundColor(.white)
                Text("\(user.username)")
                    .font(.system(size: 13))
                    .opacity(0.5)
                    .foregroundColor(.white)
                
                LazyVGrid(columns: columns) {
                    ForEach(user.acquiredThemes, id: \.id) { theme in
                        ZStack(alignment: .bottomLeading) {
                            ZStack(alignment: .bottomLeading) {
                                // Display theme preview here
                                Image(theme.content.themeURL) // Replace with actual image loading logic
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width / 2 - 15, height: 300)
                                    .clipped()
                                    .cornerRadius(21)

                                HStack {
                                    if let creatorId = theme.creator,
                                       let creator = SampleData.user(for: creatorId) {
                                        
                                        Image(creator.profilePicture) // Profile picture
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 36, height: 60)
                                            .cornerRadius(6)

                                        VStack(alignment: .leading, spacing: 00) {
                                            Text(theme.name ?? "Unknown Theme")
                                                .font(.system(size: 13))
                                                .fontWeight(.regular)
                                                .foregroundColor(Color.white.opacity(0.75))
                                            
                                            Text("\(creator.username)")
                                                .font(.system(size: 13))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.white)
                                            
                                            Text("\(formatDate(theme.creationDate))") // Format date as needed
                                                .font(.system(size: 11))
                                                .foregroundColor(Color.white.opacity(0.25))
                                                .padding(.bottom)

                                        }
                                        .frame(height: 60)

                                    } else {
                                        // Default profile picture and theme name

                                        VStack(alignment: .leading) {
                                            Text(theme.name ?? "Unknown Theme")
                                                .font(.system(size: 13))
                                                .fontWeight(.regular)
                                                .foregroundColor(Color.white.opacity(0.75))

                                            Text("niteclub")
                                                .font(.system(size: 13))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                }
                                .padding(15)
                            }
                        }
                    }
                }
                .padding(.top)
            }
            .padding(.top, 30)
        }
        .padding(.horizontal, 6)
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    ProfileThemeView(user: SampleData.userJohn)
=======

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
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
}
