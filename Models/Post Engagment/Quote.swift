//
//  Quote.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import Foundation
import SwiftUI

struct Quote: Identifiable {
    var id: UUID
    var post: Post  // Reference to the original post
    var quotingUser: User  // User who created the quote
    var quoteText: String  // The text of the quote
    var timestamp: Date  // When the quote was created
    
    init(id: UUID = UUID(), post: Post, quotingUser: User, quoteText: String, timestamp: Date) {
        self.id = id
        self.post = post
        self.quotingUser = quotingUser
        self.quoteText = quoteText
        self.timestamp = timestamp
    }
}
