//
//  TabBarView.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import SwiftUI

struct TabBarView: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    
    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .padding(.horizontal,20)
                    .padding(.vertical, 12)
                    .contentShape(Rectangle())  // Set the content shape to Rectangle
                    .onTapGesture{
                        switchToTab(tab: tab)
                    }
//                Long tap gesture for Disco to return to HUB // Maybe HUB preview
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        .radio, .disco, .notifs, .profile, .create
    ]
    static var previews: some View {
        
        VStack {
           
            TabBarView(tabs: tabs, selection:  .constant(tabs.first!))
        }
    }
}

extension TabBarView  {
    
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(tab.iconName)
                .renderingMode(.template)
            
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(selection == tab ? tab.color : Color.white.opacity(0.4))
    }
    
    private func switchToTab(tab: TabBarItem) {
        withAnimation(.easeInOut) {
            selection = tab
        }
    }
}
