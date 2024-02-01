//
//  UserCard.swift
//  niteclub
//
//  Created by +++ on 10/27/23.
//

import SwiftUI

struct UserCard: View {
    @ObservedObject var viewModel: UserViewModel  // assuming viewModel is passed in, or could be created from a User object
    let cardBackgroundWidth: CGFloat = 200
    let cardBackgroundHeight: CGFloat = 130
    var dateToDisplay: Date

    @Binding var navigationPath: NavigationPath
    var onTap: () -> Void // Closure to be called on tap

    var body: some View {
        Button(action: {
            viewModel.performNavigation()

            onTap() // Call the onTap closure

        }) {
            ZStack {
                Image(viewModel.selectedTheme.content.themeURL)
                    .resizable()
                    .scaledToFill()
                    .frame(width: cardBackgroundWidth)
                    .frame(height: cardBackgroundHeight)
                    .clipped()
                    .cornerRadius(21.0)
                
                Blur(style: .regular)
                    .frame(width: cardBackgroundWidth - 12)
                    .frame(height: cardBackgroundHeight - 12)
                    .opacity(0.9)
                    .cornerRadius(18.0)
                    .shadow(radius: 3)
                
                VStack(spacing: 0) {
                    HStack {
                        VStack(alignment: .leading) {
                            
                            Image(viewModel.profilePicture)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 42, height: 70)
                                .cornerRadius(6)
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text(viewModel.username)
                                    .font(.system(size: 10))
                                    .fontWeight(.bold)
                                
                                Text("USERNAME / ユーザー名".uppercased())
                                    .font(.system(size: 6))
                                
                            }
                        }
                        Spacer()
                        
                        // User details
                        VStack(alignment: .trailing) {
                            VStack(alignment: .trailing) {
                                Text("\(viewModel.location)")
                                    .font(.system(size: 8))
                                Text("COUNTRY / 国".uppercased())
                                    .font(.system(size: 6))
                                
                            }
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("\(viewModel.followerCount)")
                                    .font(.system(size: 8))
                                
                                Text("following".uppercased())
                                    .font(.system(size: 6))
                                
                            }
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("\(viewModel.followerCount)")
                                    .font(.system(size: 8))
                                Text("followers".uppercased())
                                    .font(.system(size: 6))
                                
                            }
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text(monthYearFormatter.format(date: dateToDisplay).uppercased())
                                    .font(.system(size: 8))
                                Text("以来のメンバー".uppercased())
                                    .font(.system(size: 6))
                                
                            }
                        }
                        // Additional details can be added here
                        
                    }
                    .padding(12)
                    .frame(width: cardBackgroundWidth - 12)
                    .frame(height: cardBackgroundHeight - 12)
                    .onAppear {
                        //                    viewModel.loadSelectedTheme()
                    }
                }
            }
            .onAppear {
                viewModel.navigateToProfile = { userID in
                    withAnimation(.spring()) {
                        navigationPath.append(userID)
                    }
                }
            }
        }
    }

    // Helper method to format Date
    private func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

let sampleTheme = Theme(
    id: UUID(),
    name: "Sample Theme",
<<<<<<< HEAD
    content: ThemeContent(id: UUID(), themeURL: "image31"), // This URL is just a placeholder
=======
    content: Theme(themeURL: "image33"), // This URL is just a placeholder
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
    price: 0.0, // It's a free theme in this example
    creationDate: Date(),
    approved: true // This sample theme is approved
)

// Initialize the ViewModel with the sample user
//let currentUser = SampleData.userEmma

//let userviewModel = UserViewModel(user: SampleData.userJohn) // or any other sample user

#Preview {
    UserCard(viewModel: UserViewModel(), dateToDisplay: Date(), navigationPath: .constant(NavigationPath()), onTap: {})
    
}
