//
//  SubscriptionView.swift
//  niteclub
//
//  Created by +++ on 12/2/23.
//

import SwiftUI

struct SubscriptionView: View {
    @State private var selectedTab = 0

    let entries = ["After Hours","View Lurkers", "See Mutuals" , "View Other User Details", "Theme Exclusives" , "Event Exclusives", "+ Many Upcoming Features" ]

    let creations = ["Create Music" , "Longer Stories" , "Video Post" , "Multi Media Post" , "Increased Character Limit" , "Link in Bio"]
    
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    VStack {
                        Button(action: {})
                        {
                        ZStack {
                            Image("image40")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 240, height: 200)
                                .cornerRadius(18)
                                .clipped()
                            Blur(style: .systemThinMaterialDark)
                                    .frame(width: 240, height: 200)
                                    .cornerRadius(18)
                            Text("niteclub monthly")
                                .fontDesign(.serif)
                                .foregroundColor(.white.opacity(0.75))
                            }
                        }
                        .padding(4)
                        .shadow(color: .black.opacity(0.25), radius: 12)
                        .padding(.top)
                        
                        HStack {
                            Text("tap to pay".uppercased())
                                .foregroundColor(.white.opacity(0.75))
                                .font(.system(size: 15))
                                .fontDesign(.serif)
                                .padding()

                            Spacer()
                            Text("$ 29.99 / Month".uppercased())
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                                .fontDesign(.serif)
                                .padding()
                        }

                        Spacer()
                        ScrollView {
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Enhanced Experience")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                        
                                ForEach(entries, id: \.self) { entry in
                                    HStack {
                                        Text(entry)
                                            .foregroundColor(.white.opacity(0.75))
                                        Spacer()
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                            .padding()
                            .background(
                                Blur(style: .dark)
                                    .cornerRadius(24)
                            )
                            .padding(.horizontal)

                            VStack(alignment: .leading, spacing: 15) {
                                Text("Creator Hub")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                        
                                ForEach(creations, id: \.self) { creation in
                                    HStack {
                                        Text(creation)
                                            .foregroundColor(.white.opacity(0.75))
                                        Spacer()
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                            .padding()
                            .background(
                                Blur(style: .dark)
                                    .cornerRadius(24)
                            )
                            .padding(.horizontal)
                        }

                    }
                    .tag(0)

                    
                    VStack {
                        Button(action: {})
                        {
                            ZStack {
                                Image("image42")
                                    .resizable()
                                    .frame(width: 340, height: 200)
                                    .cornerRadius(24)
                                Blur(style: .systemChromeMaterial)
                                    .frame(width: 340, height: 200)
                                    .cornerRadius(24)
                                
                                Text("NITECLUB              FOREVER")
                                    .fontDesign(.serif)
                                    .font(.system(size: 15))
                                    .foregroundColor(.white)
                            }
                            .padding(4)
                            .shadow(color: .blue.opacity(0.8), radius: 20)
                            .padding(.top)
                        }
                            Text("tap to become a member".uppercased())
                                .font(.system(size: 15))
                                .fontDesign(.serif)
                                .padding()
                                .foregroundColor(.white)
                    
                        Spacer()
                        ScrollView {
                                VStack(alignment: .leading, spacing: 15) {
                                    HStack {
                                        Text("Niteclub Forever")
                                            .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        Spacer()
                                        Text("$300")
                                            .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .fontDesign(.serif)

                                    }

                                    HStack {
                                        Text("One time purchase of Membership , comes with an aluminimum Member Card, which will provide access to future events, experiences, and goods. Shipping F/W24")
                                            .foregroundColor(.white.opacity(0.75))
                                        Spacer()
                                    }
                                    
                                }
                                .padding()
                                .background(
                                    Blur(style: .dark)
                                        .cornerRadius(24)
                                )
                                .padding(.horizontal)
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Enhanced Experience")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                        
                                ForEach(entries, id: \.self) { entry in
                                    HStack {
                                        Text(entry)
                                            .foregroundColor(.white.opacity(0.75))
                                        Spacer()
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                            .padding()
                            .background(
                                Blur(style: .dark)
                                    .cornerRadius(24)
                            )
                            .padding(.horizontal)

                            VStack(alignment: .leading, spacing: 15) {
                                Text("Creator Hub")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                        
                                ForEach(creations, id: \.self) { creation in
                                    HStack {
                                        Text(creation)
                                            .foregroundColor(.white.opacity(0.75))
                                        Spacer()
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                            .padding()
                            .background(
                                Blur(style: .dark)
                                    .cornerRadius(24)
                            )
                            .padding(.horizontal)
                        }

                    }
                    .tag(1)

                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }

        }
        .edgesIgnoringSafeArea(.vertical)
    }
}

#Preview {
    SubscriptionView()
}
