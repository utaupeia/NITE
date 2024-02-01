//
//  Song.swift
//  niteclub
//
//  Created by +++ on 12/9/23.
//

import Foundation

struct Song {
    var name: String // Song Name
    var artist: User // User
    var coverArt: String // Image
    var mp3File: URL // URL to Mp3File

    // Duration handled in ViewModel
}
