//
//  RadioNavBar.swift
//  niteclub
//
//  Created by +++ on 12/9/23.
//

import SwiftUI

struct RadioNavBar: View {
    @Binding var selectedTab: Int
    var namespace: Namespace.ID

    var body: some View {
        HStack {
            ForEach(0..<3, id: \.self) { index in
                Button(action: {
                    withAnimation {
                        selectedTab = index
                    }
                }) {
                    TabIndicator(selectedTab: selectedTab, tabNumber: index, namespace: namespace)
                }
            }
        }
    }
}


//#Preview {
//    RadioNavBar(selectedTab: Int)
//        .environmentObject(TabBarState())
//}


//struct RadioNavBar_Previews: PreviewProvider {
//    // Create a static dummy state for the preview
//    @State static var selectedTabPreview: Int = 0
//
//    static var previews: some View {
//        // Pass a binding to the dummy state to RadioNavBar
//        RadioNavBar(selectedTab: $selectedTabPreview)
//            .environmentObject(TabBarState()) // Add this if your view relies on TabBarState environment object
//    }
//}
