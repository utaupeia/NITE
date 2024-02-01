//
//  Advertisement.swift
//  niteclub
//
//  Created by +++ on 1/29/24.
//

import Foundation
import Combine
import UIKit
import SwiftUI

enum AdType: String {
    case banner
    case fullscreen
}

struct AdModel: Identifiable {
    var id: String // Unique identifier for the ad
    var type: AdType // Type of the ad
    var mediaURL: String // URL // URL of the ad image
    var businessName: String // Name of the business
    var websiteLink: URL // URL to be opened when ad is clicked
    var displayDuration: TimeInterval? // Optional, mainly for fullscreen ads
}

class AdViewModel: ObservableObject {
    var impressionsCount = 0
    var clicksCount = 0

    @Published var currentAdIndex = 0
    @Published var currentAd: AdModel? {
        didSet {
            startTimer()
        }
    }
    private var ads: [AdModel] = []
    private var timer: AnyCancellable?
    private let defaultDuration: TimeInterval = 10

    init() {
        loadAds() // Load ads initially
    }

    func loadAds() {
        // Load your ads into the `ads` array
        // For now, we'll use dummy data
        ads = [
            AdModel(id: "1", type: .banner, mediaURL: "aesop", businessName: "aesop", websiteLink: URL(string: "https://example.com")!),
            AdModel(id: "2", type: .banner, mediaURL: "margiela", businessName: "maison margiela", websiteLink: URL(string: "https://example.com")!),
            AdModel(id: "3", type: .banner, mediaURL: "Sodas", businessName: "UnitedSodasOfAmerica", websiteLink: URL(string: "https://example.com")!),
            AdModel(id: "4", type: .banner, mediaURL: "image33", businessName: "RandomBiniz", websiteLink: URL(string: "https://example.com")!)

        ]
        currentAd = ads.first

        nextAd()
    }

    func nextAd() {
        if !ads.isEmpty {
            withAnimation(.easeInOut) {
                currentAdIndex = (currentAdIndex + 1) % ads.count
                currentAd = ads[currentAdIndex]
            }
        }
    }



    private func startTimer() {
        stopTimer()
        
        let duration = currentAd?.displayDuration ?? defaultDuration
        timer = Timer.publish(every: duration, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.nextAd()
            }
    }

    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }

    func recordImpression() {
        impressionsCount += 1
        // Implement logic to save/send impression data
    }
    
    func recordClick() {
        guard let currentAd = currentAd else { return }
        clicksCount += 1
        // Additional logic for handling click
        openURL(currentAd.websiteLink)
    }

    private func openURL(_ url: URL) {
        // Ensure this is executed on the main thread, as it involves UI update
        DispatchQueue.main.async {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }


}
