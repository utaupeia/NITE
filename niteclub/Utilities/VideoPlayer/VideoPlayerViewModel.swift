//
//  VideoPlayerViewModel.swift
//  niteclub
//
//  Created by +++ on 1/2/24.
//

import Combine
import AVFoundation

class VideoPlayerViewModel: ObservableObject {
    @Published var player: AVPlayer
    @Published var isPlaying = false
    @Published var currentTimeText = "00:00"
    @Published var durationText = "00:00"
    @Published var progress: Double = 0.0
    @Published var isMuted = false
    @Published var remainingTimeText = ""

    private var playbackCompletionObserver: Any?
    private var timeObserverToken: Any?
    private var statusObserver: AnyCancellable?  // Combine cancellable for status observation
    private var rateObserver: AnyCancellable?  // Combine cancellable for rate observation

    init(videoURL: URL) {
        let playerItem = AVPlayerItem(url: videoURL)
        self.player = AVPlayer(playerItem: playerItem)
        setupPlayerObservers()
        setupPlaybackCompletionObserver()

    }

    // Load video with a given URL
    func loadVideo(url: URL) {
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
    }


    private func setupPlayerObservers() {

        // Observe player time updates for countdown
        let interval = CMTime(value: 1, timescale: 2) // Update every 0.5 seconds
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.updateTimeDisplay(time: time) // Update the current time display
            self?.updateProgress(currentTime: CMTimeGetSeconds(time)) // Update the progress
        }
        
        // Observe readyToPlay status
        statusObserver = player.currentItem?.publisher(for: \.status).sink { [weak self] status in

            if status == .readyToPlay {
                self?.initializeCountdown()
            }
        }
        rateObserver = player.publisher(for: \.rate).sink { [weak self] rate in
            self?.isPlaying = rate > 0
        }
        
    }

    private func initializeCountdown() {
        guard let duration = player.currentItem?.duration else {
            return
        }
        let totalSeconds = CMTimeGetSeconds(duration)
        if !totalSeconds.isNaN {
            DispatchQueue.main.async {
                self.remainingTimeText = self.formatTime(seconds: totalSeconds)
            }
        } else {
        }
    }

    private func updateCountdown(time: CMTime) {
        guard let duration = player.currentItem?.duration else { return }
        let durationSeconds = CMTimeGetSeconds(duration)
        let currentSeconds = CMTimeGetSeconds(time)
        let remainingSeconds = max(0, Int(durationSeconds - currentSeconds))

        DispatchQueue.main.async {
            self.remainingTimeText = ":\(remainingSeconds)"
        }
    }

    private func formatTime(seconds: Double) -> String {
        let totalSeconds = Int(seconds)
        let seconds = totalSeconds % 60
        return String(format: ":%02d", seconds)
    }

    private func updateTimeDisplay(time: CMTime) {
        let currentSeconds = CMTimeGetSeconds(time)
        currentTimeText = formatTime(seconds: currentSeconds)
        
        // Update the progress
        updateProgress(currentTime: currentSeconds)
    }

    private func updateProgress(currentTime: Double) {
        guard let duration = player.currentItem?.duration else { return }
        let totalDurationSeconds = CMTimeGetSeconds(duration)
        DispatchQueue.main.async {
            self.progress = totalDurationSeconds > 0 ? currentTime / totalDurationSeconds : 0
        }
    }

    private func updateDurationDisplay() {
        guard let duration = player.currentItem?.duration else { return }
        let totalSeconds = CMTimeGetSeconds(duration)
        durationText = formatTime(seconds: totalSeconds)
    }
    
    private func setupPlaybackCompletionObserver() {
        playbackCompletionObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { [weak self] _ in
            self?.resetVideoPlayback()
        }
    }

    private func resetVideoPlayback() {
        player.seek(to: .zero)
        // Optionally, you can also pause the video or change any flags
        // self.isPlaying = false
        // self.player.pause()
    }

    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func toggleMute() {
        isMuted.toggle()
        player.isMuted = isMuted
    }

    func generateThumbnailFrames() {

    }
    
    deinit {
        if let token = timeObserverToken {
            player.removeTimeObserver(token)
        }
        statusObserver?.cancel()
        rateObserver?.cancel()
        
        if let observer = playbackCompletionObserver {
            NotificationCenter.default.removeObserver(observer)
        }

    }

}



