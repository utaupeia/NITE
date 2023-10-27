//
//  User.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import Foundation
import SwiftUI

struct User: Identifiable, Equatable {
    // USER STATUS :
        // DEVELOPER
        // MEMBER FOREVER
        // MEMBER
        // USER

    var id: UUID
    var username: String
    var profilePicture: String //Image
    // verified
    // birthdate
    // email
    // invited by what user
    // account number
    // routing number
    // date joined
    // following
    // followers
    // location (should be State from ID scan)
    // gender (from ID scan)
    
    // followsYou
    // isBlocked
    // has notifications ON
    
    
    // Initializer
    init(id: UUID = UUID(), username: String, profilePicture: String) {
        self.id = id
        self.username = username
        self.profilePicture = profilePicture
    }
}

class SessionManager {
    static let shared = SessionManager()  // Singleton instance

    private init() {}  // Prevents direct instantiation

    var currentUser: User?  // Currently logged-in user
}
