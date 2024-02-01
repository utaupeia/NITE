//
//  AudioPlayViewModel.swift
//  niteclub
//
//  Created by +++ on 12/9/23.
//

import Foundation
import AVKit
import SwiftUI
import Combine

class AudioPlayViewModel: ObservableObject {
    private var timer: Timer?
    @Published var isPlaying: Bool = false
    @Published var soundSamples = [AudioPreviewModel]()
    @Published var index = 0
    @Published var playbackTime: Double = 0
    @Published var totalDuration: Double = 0
    var sampleCount: Int

    let url: URL
    var dataManager: ServiceProtocol
    @Published var player: AVPlayer!
    @Published var session: AVAudioSession!
    
    init(url: URL, dataManager: ServiceProtocol = Service.shared) {
        self.url = url
        self.dataManager = dataManager
        self.sampleCount = 0 // Initialize with 0, will be calculated based on audio length
        self.player = AVPlayer(url: url)
        
        visualizeAudio()
        setupAudioSession()
        setupPlayer()
    }
    
    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session setup error: \(error)")
        }
    }
    
    private func setupPlayer() {
        player = AVPlayer(url: self.url)
        Task {
            await calculateDuration()
        }
        addPeriodicTimeObserver()
    }

        private func calculateDuration() async {
        let asset = AVURLAsset(url: self.url)
        
        do {
            // Asynchronously load the duration key of the asset
            let durationKey = try await asset.load(.duration)
            let durationInSeconds = CMTimeGetSeconds(durationKey)
            DispatchQueue.main.async {
                self.totalDuration = durationInSeconds
            }
        } catch {
            print("Error loading duration: \(error)")
            DispatchQueue.main.async {
                self.totalDuration = 0
            }
        }
    }

    
    private func addPeriodicTimeObserver() {
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.playbackTime = CMTimeGetSeconds(time)
        }
    }
    
    func startTimer() {
        let interval: TimeInterval = 0.1  // Update every 0.1 seconds for smoother progress
        guard interval > 0 else {
            print("Invalid timer interval")
            return
        }

        DispatchQueue.main.async {
            self.timer?.invalidate()  // Invalidate any existing timer
            self.timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
                self?.updateSampleColors()
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }


    var songProgress: CGFloat {
        guard totalDuration > 0 else { return 0.0 }
        return 1.0 - CGFloat(playbackTime / totalDuration) // Invert the progress
    }

    
    private func updateSampleColors() {
        if self.index < self.soundSamples.count {
            withAnimation(Animation.linear) {
                self.soundSamples[self.index].color = Color.black
            }
            self.index += 1
        } else {
            stopTimer()
        }
    }
    
    private func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        self.player.pause()
        self.player.seek(to: .zero)
        stopTimer()
        self.isPlaying = false
        resetSampleColors()
    }
    
    private func resetSampleColors() {
        self.soundSamples = self.soundSamples.map { var model = $0; model.color = Color.gray; return model }
    }
    
 
    func playAudio() {
        if player == nil {
            player = AVPlayer(url: url)
        }
        player?.play()
        isPlaying = true
        // Any additional setup for playing audio
    }

    func pauseAudio() {
        player?.pause()
        isPlaying = false
        // Any additional teardown or pause handling
    }
    
    func countDuration() async -> Double {
        guard let duration = try? await player.currentItem?.asset.load(.duration) else {
            return 0
        }

        return CMTimeGetSeconds(duration)
    }
    
    func formattedTime(for duration: Double) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60

        if minutes < 10 {
            return String(format: "%d.%02d", minutes, seconds)
        } else {
            return String(format: "%02d.%02d", minutes, seconds)
        }
    }

    
    func visualizeAudio() {
        dataManager.buffer(url: url, samplesCount: sampleCount) { results in
            DispatchQueue.main.async {
                self.soundSamples = results
            }
        }
    }
    
    func removeAudio() {
        do {
            try FileManager.default.removeItem(at: url)
            NotificationCenter.default.post(name: Notification.Name("hide_audio_preview"), object: nil)
        } catch {
            print("Error removing audio file: \(error)")
        }
    }
}
struct AudioPreviewModel: Hashable {
    var magnitude: Float
    var color: Color
}
