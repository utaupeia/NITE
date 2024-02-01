//
//  createSongButton.swift
//  niteclub
//
//  Created by +++ on 12/9/23.
//

import SwiftUI

struct createSongButton: View {
    @Binding var selectedTab: Int  // Add this line
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                
                selectedTab = 1  // Set selectedTab to 1
            }
        }) {
            Image(systemName: "folder.badge.plus")
                .padding()
        }
    }
}


