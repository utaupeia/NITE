//
//  TabBarPreferenceKey.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import Foundation
import SwiftUI
import Combine

struct TabBarItemsPreferenceKey: PreferenceKey {
    
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
    
}
struct TabBarItemViewModifier: ViewModifier {
    
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}
extension View {
    
    func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
            modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}
class TabBarState: ObservableObject {
    @Published var isHidden: Bool = false
}
