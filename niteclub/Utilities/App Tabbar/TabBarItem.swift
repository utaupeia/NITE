//
//  TabBarItem.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    
    case radio, disco, notifs, profile, create
    
    var iconName: String {
        switch self {
        case .radio: return "Radioicon"
        case .disco: return "Discoicon"
        case .notifs: return "Notificon"
        case .profile: return "Profileicon"
        case .create: return "Createicon"
        }
    }
    
    var title: String {
        switch self {
        case .radio: return "radio"
        case .disco: return "disco"
        case .notifs: return "notifs"
        case .profile: return "profile"
        case .create: return "create"
        }
    }
    
    var color: Color {
        switch self {
        case .radio: return Color.white
        case .disco: return Color.white
        case .notifs: return Color.white
        case .profile: return Color.white
        case .create: return Color.white
        }
    }
}
