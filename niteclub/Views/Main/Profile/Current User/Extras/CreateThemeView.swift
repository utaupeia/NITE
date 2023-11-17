//
//  CreateThemeView.swift
//  niteclub
//
//  Created by +++ on 12/2/23.
//

import SwiftUI
// MARK: make text fields for creation of theme ( name / release date / notes / quantity ) 
struct CreateThemeView: View {
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                HStack {
                    // cancel button ?
                    
                    // upload theme button  ? reference music create
                }
                
            }
            HStack {
                VStack(alignment: .leading) {
                    
                    Button(action: {
                                    print("Square button tapped!")
                    }) {
                        ZStack {
                            Blur(style: .dark)
                                .frame(width: 140, height: 260)
                            .cornerRadius(21)
                            
                        }
                    }
                    
                    Text("Theme Name / textfield entry")
                        .padding()
                    
                    Text("qunatity selector")
                        .padding()
                    Text("Price")
                        .padding()
                    Text("release date")
                        .padding()
                    Text("Notes to developers")
                        .padding()
                    
                }
                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}






#Preview {
    CreateThemeView()
}
