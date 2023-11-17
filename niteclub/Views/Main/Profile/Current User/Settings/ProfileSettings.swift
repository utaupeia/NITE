//
//  ProfileSettings.swift
//  niteclub
//
//  Created by +++ on 12/2/23.
//

import SwiftUI

enum SelectedView {
    case profilepic, theme, linkedaccounts, changeEmail, browserLink, deleteAccount, logout , none
}

struct ProfileSettings: View {
    @Namespace private var animationNamespace
    @State private var selectedView: SelectedView = .none
    
    @State private var PrivateAccount: Bool = false
    @State private var ViewNSFW: Bool = false
    @State private var scale: CGFloat = 2.0
    var body: some View {
        
        ZStack(alignment: .center) {
//            Background()
// profile shit
            ScrollView {
                VStack(spacing: 12) {
                    HStack(alignment: .top, spacing: 12) {
                        
                        VStack(spacing: 12) {
                            
                            // prpfile
                            ZStack(alignment: .topLeading) {
                                Blur(style: .dark)
                                    .frame(width: UIScreen.main.bounds.width / 2 - 18 )
                                    .frame(height: UIScreen.main.bounds.width / 2 - 18 )
                                    .cornerRadius(21)
                                    .matchedGeometryEffect(id: "profileBlur", in: animationNamespace, isSource: selectedView != .profilepic)
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    Button(action: {
                                        // triggers photogallery profile picture edit
                                        withAnimation(.spring(response: 0.7, dampingFraction: 0.6, blendDuration: 0)) {
                                            selectedView = selectedView == .profilepic ? .none : .profilepic
                                        }
                                    }) {
                                        Image("image8")
                                            .resizable()
                                            .frame(width: 66, height: 100)
                                            .cornerRadius(12)
                                            .matchedGeometryEffect(id: "profilepic", in: animationNamespace, isSource: selectedView != .profilepic)
                                    }
                                    
                                    Text("username")
                                        .font(.system(size: 15))
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(.top, 6)
                                    Text("via : xyzuserabcdevg".uppercased())
                                        .font(.system(size: 10))
                                        .foregroundColor(.white)
                                    
                                }
                                .padding(.top, 12)
                                .padding(.leading, 12)
                                
                            }
                            .offset(x: selectedView == .none || selectedView == .profilepic ? 0 : -UIScreen.main.bounds.width)
                            .animation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0), value: selectedView)
                            .opacity(selectedView == .profilepic ? 0 : 1)
                            
                            ZStack(alignment: .topLeading) {
                                Blur(style: .dark)
                                    .frame(width: UIScreen.main.bounds.width / 2 - 18 )
                                    .frame(height: UIScreen.main.bounds.width / 2 - 18 )
                                    .cornerRadius(21)
                                VStack(alignment: .leading) {
                                    
                                    VStack(alignment: .leading) {
                                        Text("08.02.23")
                                            .foregroundColor(.white)
                                        Text("Member Since".uppercased())
                                            .font(.system(size: 12))
                                            .foregroundColor(.white)
                                    }
                                    .padding(.vertical, 3)
                                    VStack(alignment: .leading) {
                                        Text("01.02.24")
                                            .foregroundColor(.white)
                                        Text("Renew Date".uppercased())
                                            .font(.system(size: 12))
                                            .foregroundColor(.white)
                                    }
                                    .padding(.vertical, 3)
                                    
                                    Button(action: {
                                        // links to niteclub website for membership
                                    }) {
                                    VStack(alignment: .leading) {
                                            Text("NITECLUB 4EVR")
                                            .font(.system(size: 14))
                                            .foregroundColor(.white)
                                        }
                                        .padding(.vertical, 3)
                                    }
                                }
                                .padding(.top, 12)
                                .padding(.leading, 12)
                            }
                                .offset(x: selectedView == .none ? 0 : -UIScreen.main.bounds.width)
                                .animation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0), value: selectedView)
                            
                            ZStack(alignment: .center) {
                                    Blur(style: .dark)
                                    .frame(width: UIScreen.main.bounds.width / 2 - 15 )
                                    .frame(height: UIScreen.main.bounds.width / 3.2 - 15 )
                                    .cornerRadius(21)
                                    .matchedGeometryEffect(id: "emailBlur", in: animationNamespace, isSource: selectedView != .profilepic)
                                    VStack {
                                        // user email
                                        Text("emailxyzlongase@email.com")
                                            .font(.system(size: 12))
                                            .foregroundColor(.white)
                                            .matchedGeometryEffect(id: "email", in: animationNamespace, isSource: selectedView != .profilepic)
                                        
                                            .padding(6)
                                        Button(action: {
                                            withAnimation(.spring(response: 0.7, dampingFraction: 0.6, blendDuration: 1)) {
                                                selectedView = selectedView == .changeEmail ? .none : .changeEmail
                                            }
                                        }) {
                                            Text("change email".uppercased())
                                                .font(.system(size: 12))
                                                .foregroundColor(.white)
                                        }
                                        .padding(.top)
                                    }
                                }
                                .offset(x: (selectedView != .none && selectedView != .changeEmail) ? -UIScreen.main.bounds.width : 0)
                                .animation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0), value: selectedView)
                                .opacity(selectedView == .changeEmail ? 0 : 1)
                            
                        }
                        VStack(spacing: 12) {
                            
                            ZStack(alignment: .center) {
                                Blur(style: .dark)
                                    .frame(width: UIScreen.main.bounds.width / 2 - 18)
                                    .frame(height: 300)
                                    .cornerRadius(21)
                                    .matchedGeometryEffect(id: "themeBlur", in: animationNamespace, isSource: selectedView != .theme)
                                Button(action: {
                                    // theme library toggle
                                    withAnimation(.spring(response: 0.7, dampingFraction: 0.5, blendDuration: 0)) {
                                        selectedView = selectedView == .theme ? .none : .theme
                                    }
                                }) {
                                    Image("image29")
                                        .resizable()
                                        .cornerRadius(6)
                                        .matchedGeometryEffect(id: "theme", in: animationNamespace, isSource: selectedView != .theme)
                                        .padding(12)
                                }
                            }
                            .frame(height: 300)
                            .offset(y: selectedView == .none || selectedView == .theme ? 0 : -UIScreen.main.bounds.height)
                            .animation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0), value: selectedView)
                            .opacity(selectedView == .theme ? 0 : 1) // Set the opacity to 0 when selected
                            ZStack(alignment: .topLeading) {
                                Button(action: {
                                    withAnimation(.spring(response: 0.7, dampingFraction: 0.6, blendDuration: 1.0)) {
                                        selectedView = selectedView == .linkedaccounts ? .none : .linkedaccounts
                                    }
                                }) {
                                    Blur(style: .dark)
                                        .frame(width: UIScreen.main.bounds.width / 2 - 18 )
                                        .frame(height: UIScreen.main.bounds.width / 2 - 18 )
                                        .cornerRadius(21)
                                        .matchedGeometryEffect(id: "linkedBlur", in: animationNamespace, isSource: selectedView != .theme)
                                }
                                VStack(alignment: .leading) {
                                    
                                   
                                        VStack(alignment: .leading) {
                                            Text("spotify".uppercased())
                                                .font(.system(size: 15))
                                                .foregroundColor(.white)
                                            
                                            Text("musicaccount".uppercased())
                                                .font(.system(size: 12))
                                                .foregroundColor(.white)
                                        }
                                        .padding(.vertical, 3)
                                    
                                    Button(action: {
                                        
                                    }) {
                                        
                                        VStack(alignment: .leading) {
                                            Text("$")
                                                .foregroundColor(.white)
                                            
                                            Text("cashapp".uppercased())
                                                .font(.system(size: 12))
                                                .foregroundColor(.white)
                                        }
                                        .padding(.vertical, 3)
                                    }
                                    
                                    Button(action: {
                                        
                                    }) {
                                        
                                        Text("account #".uppercased())
                                            .foregroundColor(.white)
                                            .font(.system(size: 15))
                                            .padding(.vertical, 3)
                                    }
                                    
                                    Button(action: {
                                        
                                    }) {
                                        
                                        Text("routing #".uppercased())
                                            .foregroundColor(.white)
                                            .font(.system(size: 15))
                                            .padding(.vertical, 3)
                                    }
                                }
                                .padding(.top, 12)
                                .padding(.leading, 12)
                            }
                            .offset(x: selectedView == .none || selectedView == .linkedaccounts ? 0 : UIScreen.main.bounds.width)
                            .animation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0), value: selectedView)
                            .opacity(selectedView == .linkedaccounts ? 0 : 1)
                        }
                    }
                    .padding(.horizontal, 12)
                    
                    HStack(spacing: 12) {
                        Button(action: {
                            withAnimation(.spring()) {
                                PrivateAccount.toggle()
                            }
                        }) {
                            ZStack(alignment: .center) {
                                Blur(style: .dark)
                                    .frame(width: UIScreen.main.bounds.width / 2 - 18 )
                                    .frame(height: UIScreen.main.bounds.width / 4 - 18 )
                                    .cornerRadius(21)
                                
                                Text(PrivateAccount ? " private".uppercased() :  "public".uppercased())
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                                
                            }
                            .offset(x: selectedView == .none ? 0 : -UIScreen.main.bounds.width)
                            .animation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0), value: selectedView)
                        }
                        
                        Button(action: {
                            withAnimation(.spring()) {
                                ViewNSFW.toggle()
                            }
                        }) {
                            ZStack(alignment: .center) {
                                Blur(style: .dark)
                                    .frame(width: UIScreen.main.bounds.width / 2 - 18 )
                                    .frame(height: UIScreen.main.bounds.width / 4 - 18 )
                                    .cornerRadius(21)
                                
                                Text(ViewNSFW ? "nsfw on".uppercased() : "nsfw off".uppercased())
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                            }
                            .offset(x: selectedView == .none ? 0 : UIScreen.main.bounds.height)
                            .animation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0), value: selectedView)
                        }
                    }
                    
                    HStack(spacing: 12) {
                        Button(action: {
                            
                        }) {
                            ZStack(alignment: .center) {
                                Blur(style: .dark)
                                
                                Image(systemName: "hand.raised.fill")
                                    .font(.system(size: 21))
                                    .foregroundColor(.white)
                                
                            }
                            .frame(width: UIScreen.main.bounds.width / 4 - 15 )
                            .frame(height: UIScreen.main.bounds.width / 4 - 15 )
                            .cornerRadius(21)
                            .offset(x: selectedView == .none ? 0 : -UIScreen.main.bounds.width)
                            .animation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0), value: selectedView)
                        }
                        
                        Button(action: {
                            selectedView = selectedView == .browserLink ? .none : .browserLink
                        }) {
                            
                            ZStack(alignment: .center) {
                                Blur(style: .dark)
                                Image(systemName: "globe.europe.africa.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }
                            .frame(width: UIScreen.main.bounds.width / 4 - 15 )
                            .frame(height: UIScreen.main.bounds.width / 4 - 15 )
                            .cornerRadius(21)
                            .offset(x: (selectedView != .none && selectedView != .browserLink) ? -UIScreen.main.bounds.width : 0)
                            .animation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0), value: selectedView)
                        }
                        
                        Button(action: {
                            withAnimation(.spring()) {
                                selectedView = selectedView == .deleteAccount ? .none : .deleteAccount
                            }
                        }) {
                            
                            ZStack(alignment: .center) {
                                Blur(style: .dark)
                                    .frame(width: UIScreen.main.bounds.width / 4 - 15 )
                                    .frame(height: UIScreen.main.bounds.width / 4 - 15 )
                                    .cornerRadius(21)
                                    .matchedGeometryEffect(id: "deleteBlur", in: animationNamespace, isSource: selectedView != .deleteAccount)
                                
                                Image(systemName: "bolt.shield.fill")
                                    .font(.system(size: 21))
                                    .foregroundColor(.white)
                                    .matchedGeometryEffect(id: "delete", in: animationNamespace, isSource: selectedView != .deleteAccount)
                                
                            }
                            .offset(y: (selectedView != .none && selectedView != .deleteAccount) ? UIScreen.main.bounds.width : 0)
                            .animation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0), value: selectedView)
                            .opacity(selectedView == .deleteAccount ? 0 : 1) // Set the opacity to 0 when selected
                        }
                        
                        Button(action: {
                            withAnimation(.spring()) {
                                selectedView = selectedView == .logout ? .none : .logout
                            }
                        }) {
                            ZStack(alignment: .center) {
                                Blur(style: .dark)
                                    .matchedGeometryEffect(id: "blurView5", in: animationNamespace, isSource: selectedView != .logout)
                                    .frame(width: UIScreen.main.bounds.width / 4 - 15 )
                                    .frame(height: UIScreen.main.bounds.width / 4 - 15 )
                                Image(systemName: "rectangle.trailinghalf.inset.filled.arrow.trailing")
                                    .font(.system(size: 21))
                                    .foregroundColor(.white)
                                    .matchedGeometryEffect(id: "logout", in: animationNamespace, isSource: selectedView != .deleteAccount)
                                
                            }
                            .frame(width: UIScreen.main.bounds.width / 4 - 15 )
                            .frame(height: UIScreen.main.bounds.width / 4 - 15 )
                            .cornerRadius(21)
                            .offset(x: (selectedView != .none && selectedView != .logout) ? UIScreen.main.bounds.width : 0)
                            .animation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0), value: selectedView)
                        }
                    }
                }
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                        self.scale = 1 // Animate back to actual size
                    }
                }
                .padding(.top, 70)
            }
            
            if selectedView == .profilepic {
                ZStack {
                    Blur(style: .dark)
                        .cornerRadius(24)
                        .frame(width: 300, height: 400)
                        .matchedGeometryEffect(id: "profileBlur", in: animationNamespace, isSource: true)
                    Image("image8")
                        .resizable()
                        .frame(width: 120, height: 160)
                        .cornerRadius(12)
                        .matchedGeometryEffect(id: "profilepic", in: animationNamespace, isSource: true)
                    CloseButton {
                            selectedView = .none
                    }
                }
                .zIndex(selectedView == .profilepic ? 1 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0), value: selectedView)
                .padding(.horizontal, 12)
            }
            
            if selectedView == .theme {
                ZStack {
                    Blur(style: .dark)
                        .cornerRadius(24)
                        .frame(width: .infinity, height: .infinity).ignoresSafeArea()
                        .matchedGeometryEffect(id: "themeBlur", in: animationNamespace, isSource: true)
                    Image("image10")
                        .resizable()
                        .frame(width: 280, height: 580)
                        .cornerRadius(12)
                        .matchedGeometryEffect(id: "theme", in: animationNamespace, isSource: true)
                    CloseButton {
                            selectedView = .none
                    }
                }
                .zIndex(1)
                .ignoresSafeArea()
            }
            
            if selectedView == .linkedaccounts {
                ZStack(alignment: .center) {
                   
                        Blur(style: .dark)
                        .frame(width: 300, height: 300)
                        .cornerRadius(24)
                        .matchedGeometryEffect(id: "linkedBlur", in: animationNamespace, isSource: true)
                    
                    VStack(alignment: .leading) {
                        
                       
                            VStack(alignment: .leading) {
                                Text("spotify".uppercased())
                                    .font(.system(size: 15))
                                    .foregroundColor(.white)
                                
                                Text("musicaccount".uppercased())
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 3)
                        
                        Button(action: {
                            
                        }) {
                            
                            VStack(alignment: .leading) {
                                Text("$")
                                    .foregroundColor(.white)
                                
                                Text("cashapp".uppercased())
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 3)
                        }
                        
                        Button(action: {
                            
                        }) {
                            
                            Text("account #".uppercased())
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                                .padding(.vertical, 3)
                        }
                        
                        Button(action: {
                            
                        }) {
                            
                            Text("routing #".uppercased())
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                                .padding(.vertical, 3)
                        }
                    }
                    .padding(.top, 12)
                    .padding(.leading, 12)
                    
                    CloseButton {
                            selectedView = .none
                    }
                }
                .zIndex(1)
            }
            
            if selectedView == .changeEmail {
                
                ZStack(alignment: .center) {
                        Blur(style: .dark)
                        .frame(width: 300, height: 200)
                        .cornerRadius(24)
                        .matchedGeometryEffect(id: "emailBlur", in: animationNamespace, isSource: true)
                        VStack {
                            Text("emailxyzlongase@email.com")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .matchedGeometryEffect(id: "email", in: animationNamespace, isSource: true)
                                .padding(6)
                            Button(action: {
                                withAnimation(.spring()) {
                                    selectedView = selectedView == .changeEmail ? .none : .changeEmail
                                }
                            }) {
                                Text("change email".uppercased())
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                            }
                            .padding(.top)
                        }
                    }
            }
                        
            if selectedView == .deleteAccount {
                ZStack {
                    Color.black.opacity(0.75).ignoresSafeArea()
                    Blur(style: .dark)
                        .frame(width: 300, height: 150)
                        .cornerRadius(24)
                        .matchedGeometryEffect(id: "deleteBlur", in: animationNamespace, isSource: true)
                    Text("delete account".uppercased())
                        .font(.system(size: 21))
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "delete", in: animationNamespace, isSource: true)
                    CloseButton {
                            selectedView = .none
                    }
                }
            }
            
            if selectedView == .logout {
                ZStack {
                    Blur(style: .dark)
                        .frame(width: 300, height: 100)
                    .cornerRadius(24)
                    .matchedGeometryEffect(id: "blurView5", in: animationNamespace, isSource: true)
                    
                    Text("logout".uppercased())
                        .font(.system(size: 21))
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "logout", in: animationNamespace, isSource: true)
                    CloseButton {
                            selectedView = .none
                    }
                }
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
            }
        }
    }
}




#Preview {
    ProfileSettings()
}

struct CloseButton: View {
    var action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: action) {
                    withAnimation(.spring()) {
                        Text("close")
                    }
                }
            }
        }
    }
}
