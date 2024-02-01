//
//  musicLibraryButton.swift
//  niteclub
//
//  Created by +++ on 12/9/23.
//

import SwiftUI

struct musicLibraryButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
                Image(systemName: "menubar.rectangle")
                .padding()
        }
    }
}
