//
//  ProfileEdit.swift
//  niteclub
//
//  Created by +++ on 1/21/24.
//

import SwiftUI

struct ProfileEdit: View {
    @ObservedObject var userViewModel: UserViewModel
    
    // Local state for editing
    @State private var editedProfilePicture: String = ""
    @State private var editedSelectedTheme: Theme = sampleTheme // Replace with your default theme
    @State private var viewNSFW: Bool = false
    @State private var privateAccount: Bool = false
    
    var body: some View {
        ZStack {
//            Color.gray.ignoresSafeArea()
            ScrollView {
                
                VStack{
                    HStack {
                        VStack(alignment:.leading, spacing: 15) {
                            // Display and option to edit the profile picture
                                
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                    Image(uiImage: UIImage(named: userViewModel.profilePicture) ?? UIImage(named: "DefaultImage")!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 78, height: 120)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                            
                            VStack(alignment:.leading, spacing: 0) {
                                Text("\(userViewModel.username)")
                                    .font(.system(size: 18))
                                    .bold()
                                
                                // Display the non-editable invited by information
                                HStack(spacing:6) {
                                    Text("invited by:".uppercased())
                                        .font(.system(size: 11))
                                    Text("\(userViewModel.invitedBy)")
                                        .font(.system(size: 14))
                                        .bold()
                                        .offset(y: -1)
                                }
                            }
                            .foregroundStyle(.white)
                            if userViewModel.user?.status == .default {
                                Button(action: {}) {
                                    HStack {
                                        RoundedRectangle(cornerRadius: 24)
                                            .frame(width: 60, height: 1.5)
                                            .foregroundStyle(.blue)
                                        
                                        Text("become a member".uppercased())
                                            .font(.system(size: 15))
                                            .foregroundStyle(.white)
                                        
                                        RoundedRectangle(cornerRadius: 24)
                                            .frame(width: 60, height: 1.5)
                                            .foregroundStyle(.blue)
                                    }
                                    .padding()
                                }
                            } else {
                                // if member show member since MM/YYYY
                                Text("member since".uppercased())
                                    .font(.system(size: 15))
                            }
                            
                            HStack {
                                // make link editable
                                Text("\(userViewModel.link)")
                                    .font(.system(size: 14))
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.leading, 12)
                                Spacer()
                            }
                            .padding(9)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.blue, lineWidth: 1.5)
                            )
                            
                        }
                        .padding()
                        Spacer()
                    }
                    
                    ThemeSelectionView(viewModel: userViewModel)
                    
                    HStack(spacing:0) {
                        Button(action: {
                            withAnimation(.spring()) {
                                privateAccount.toggle()
                            }
                        }) {
                            Image(systemName: privateAccount ? "lock" : "lock.open")
                                .fontDesign(.monospaced)
                                .font(.system(size: 12))
                                .frame(width: 60, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .trim(from: 0,
                                              to: privateAccount ? 1.0 : 0.25) // Adjust this value to control the amount of trim
                                        .stroke(privateAccount ? .blue : .white)
                                )
                                .foregroundStyle(privateAccount ? .blue : .white)
                                .padding(6)
                        }
                        
                        Button(action: {
                            withAnimation(.spring()) {
                                viewNSFW.toggle()
                            }
                        }) {
                            Text("NSFW")
                                .fontDesign(.monospaced)
                                .font(.system(size: 12))
                                .frame(width: 60, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .trim(from: 0,
                                              to: viewNSFW ? 1.0 : 0.25) // Adjust this value to control the amount of trim
                                        .stroke(viewNSFW ? .red : .white)
                                        .rotationEffect(.degrees(180))
                                )
                                .foregroundStyle(viewNSFW ? .red : .white.opacity(0.5))
                                .padding(6)

                        }

                        Button(action: {
                            withAnimation(.spring()) {
                            }
                        }) {
                            Text("Blocked")
                                .fontDesign(.monospaced)
                                .font(.system(size: 12))
                                .frame(width: 60, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .trim(from: 0,to: 1.0)
                                        .stroke(.white)
                                )
                                .padding(6)
                        }
                        .foregroundStyle(.white.opacity(0.5))
                        
                        Button(action: {
                            withAnimation(.spring()) {
                            }
                        }) {
                            Text("Delete Account")
                                .fontDesign(.monospaced)
                                .font(.system(size: 10))
                                .frame(width: 60, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .trim(from: 0,to: 1.0)
                                        .stroke(.white)
                                )
                                .padding(6)

                        }
                        .foregroundStyle(.white.opacity(0.2))
                        
                        Button(action: {
                            withAnimation(.spring()) {
                            }
                        }) {
                            Text("Logout")
                                .fontDesign(.monospaced)
                                .font(.system(size: 12))
                                .frame(width: 60, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .trim(from: 0,to: 1.0)
                                        .stroke(.white)
                                )
                                .padding(6)
                        }
                        .foregroundStyle(.white.opacity(0.2))                   

                    }
                    .frame(height: 120)
                    
                    Spacer()
                }
                VStack {
                    Button(action: saveEdits) {
                        Text("Save")
                            .foregroundStyle(.white)
                    }
                    .padding()
                    
                    
                }
                
            }
            .onAppear {
                loadUserDetails()
        }
        }
    }
    
    private func loadUserDetails() {
        // Load current user details into editable state
        editedProfilePicture = userViewModel.profilePicture
        editedSelectedTheme = userViewModel.selectedTheme
    }
    
    private var formattedDate: String {
        if let dateJoined = userViewModel.user?.dateJoined {
            return DateFormatter.monthYearFormatter.string(from: dateJoined)
        } else {
            return "Unknown"
        }
    }
    
    
    private func saveEdits() {
        // Update the userViewModel with new values
        userViewModel.updateProfilePicture(newImageURL: editedProfilePicture)
        userViewModel.updateSelectedTheme(editedSelectedTheme)
        // Add additional logic as needed for saving changes
    }
}

#Preview {
    ProfileEdit(userViewModel: UserViewModel())
}

extension DateFormatter {
    static let monthYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"  // "MMM" for abbreviated month, "yyyy" for full year
        return formatter
    }()
}
