//
//  ProfileVideoContentView.swift
//  niteclub
//
//  Created by +++ on 11/2/23.
//

import SwiftUI

struct ProfileVideoContentView: View {
    var user: User

    
       let columns: [GridItem] = [
           GridItem(.flexible(),spacing: nil, alignment: nil),
       ]
       
       var body: some View {
           
           ScrollView(showsIndicators: false) {
                   LazyVGrid(columns: columns) {
                                   ForEach(0..<20) { index in
                                       Blur(style: .dark)
                                           .frame(width: .infinity)
                                           .frame(height: 200)
                                           .cornerRadius(24)
//                                       LandscapeVideoPostView()
                       }
                   }
               
               .padding(.top, 100)
           }
           .padding(.horizontal, 6)
       }
   }


#Preview {
    ProfileVideoContentView(user: sampleUser)
}
