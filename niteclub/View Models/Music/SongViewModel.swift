//
//  SongViewModel.swift
//  niteclub
//
//  Created by +++ on 12/9/23.
//

import Foundation
import AVFoundation
import Combine

class SongViewModel: ObservableObject {
    @Published var song: Song
    @Published var duration: String = ""
    private var cancellables = Set<AnyCancellable>()
    init(song: Song) {
        self.song = song
    }
}


