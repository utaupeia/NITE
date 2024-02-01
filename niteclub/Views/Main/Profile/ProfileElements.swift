//
//  ProfileElements.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import SwiftUI

struct ProfileElements: View {
    @ObservedObject var viewModel: UserViewModel  // assuming viewModel is passed in, or could be created from a User object

    @Binding var followsOverlay: Bool
    @State private var isAuthUser = false
    @State private var isMember = true
    
    var body: some View {
// USERNAME
                
        ZStack {
            HStack(alignment: .top) {
                        
                            VStack(alignment: .leading,spacing: 3) {
                                Button(action: {
    //                                profileFullScreen.toggle()
                                }) {
                                    Image(viewModel.profilePicture)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 42, height: 70)
                                        .cornerRadius(6)
                                        .padding(.horizontal, 15)
                                        .clipped()
                                }
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    //                            name / follows you (if)
                                    HStack {
                                        Text(viewModel.username)
    //                                        .matchedGeometryEffect(id: "username", in: animation)
                                            .font(.system(size: 15))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        
                                    }
                                       Button(action: {
                                           
                                       }) {
                                           HStack(spacing: 1) {
                                               Text("invited by :".uppercased())
                                                   .font(.system(size: 11))
                                                   .foregroundColor(.white)
                                               
                                               Text(viewModel.invitedBy)
                                                   .font(.system(size: 11))
                                                   .fontWeight(.semibold)
                                                   .foregroundColor(.white)
                                               
                                           }
                                       }
                                    
                                    if isMember {
                                        Button(action: {
                                            
                                        }) {
                                            HStack(spacing: 1) {
                                                Text("link :".uppercased())
                                                    .font(.system(size: 11))
                                                    .foregroundColor(.white)
                                                
                                                Text(viewModel.link)
                                                    .font(.system(size: 11))
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                                
                                            }
                                        }
                                    }
                                    
                                    if isAuthUser {
                                        HStack(alignment: .top, spacing: 3) {
                                            HStack(spacing: -5) {
                                                Image("p23")
                                                    .resizable()
                                                    .frame(width: 25)
                                                    .frame(height: 36)
                                                    .cornerRadius(4)
                                                Image("liluzi")
                                                    .resizable()
                                                    .frame(width: 25)
                                                    .frame(height: 36)
                                                    .cornerRadius(4)
                                                Image("sky")
                                                    .resizable()
                                                    .frame(width: 25)
                                                    .frame(height: 36)
                                                    .cornerRadius(4)
                                            }
                                            VStack(alignment: .leading, spacing: 0) {
                                                HStack {
                                                    Text("followed by".uppercased())
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 11))
                                                    
                                                }
                                                Text("user1, user2, user3".uppercased())
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 11))
                                                HStack {
                                                    Text("and x others".uppercased())
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 11))
                                                    
                                                }
                                            }
                                        }
                                        .padding(.top, 4)
                                    } else {
                                        
                                    }
                                }
                                .padding(.horizontal, 15)
                            }
                            .padding(.top, 6 )
                        
                            Spacer()
                        
                            VStack(alignment: .trailing) {
                                
                                    VStack(alignment: .trailing, spacing: 5) {
                                        
                                        Button(action: {
                                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0)) {
                                                followsOverlay.toggle()
                                                // index in following tab
                                            }
                                        }) {
                                            VStack(alignment: .trailing, spacing: 0) {
                                                
                                                Text("\(viewModel.followingCount)")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 13))
                                                    .fontWeight(.semibold)
                                                
                                                Text("following".uppercased())
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 11))
                                            }
                                            .padding(.horizontal, 15)
                                        }
                                        
                                         Button(action: {
                                             withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0)) {
                                                 followsOverlay.toggle()
                                                 // index in followers tab
                                             }
                                         }) {
                                             VStack(alignment: .trailing, spacing: 0) {
                                                 
                                                 Text("\(viewModel.followerCount)")
                                                     .foregroundColor(.white)
                                                     .font(.system(size: 13))
                                                     .fontWeight(.semibold)
                                                 
                                                 Text("followers".uppercased())
                                                     .foregroundColor(.white)
                                                     .font(.system(size: 11))
                                             }
                                             .padding(.horizontal, 15)
                                         }
                                        
                                        
                                        VStack(alignment: .trailing, spacing: 0) {
                                            
                                            Text("\(viewModel.lurkingCount)")
                                                .foregroundColor(.white)
                                                .font(.system(size: 13))
                                                .fontWeight(.semibold)
                                            
                                            Text("lurking".uppercased())
                                                .foregroundColor(.white)
                                                .font(.system(size: 11))
                                        }
                                        .padding(.horizontal, 15)
                                        
                                    }
                                    .padding(6)
                                
                            }
                    }
            .frame(width: .infinity)
        }
        
    }
}


#Preview {
    ProfileElements(viewModel: UserViewModel(), followsOverlay: .constant(false))
}
