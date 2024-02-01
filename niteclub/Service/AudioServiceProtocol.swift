//
//  AudioServiceProtocol.swift
//  niteclub
//
//  Created by +++ on 12/9/23.
//

import Foundation
import AVFoundation
import Combine

protocol ServiceProtocol {
    func buffer(url: URL, samplesCount: Int, completion: @escaping([AudioPreviewModel]) -> ())
}

class Service: ServiceProtocol {
    static let shared: ServiceProtocol = Service()

    // Function to process audio file and return a set of samples for visualization
    func buffer(url: URL, samplesCount: Int, completion: @escaping([AudioPreviewModel]) -> ()) {
        // Perform audio processing on a background thread to avoid blocking the UI
        DispatchQueue.global(qos: .userInteractive).async {
            // Ensure the samplesCount is valid to avoid division by zero
            guard samplesCount > 0 else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }

            do {
                // Handle local and potentially remote audio files
                let cur_url = url
                if url.absoluteString.hasPrefix("https://") {
                    // Add logic here to handle remote files
                }
                
                // Load the audio file for reading
                let file = try AVAudioFile(forReading: cur_url)

                // Create a buffer to read audio samples
                let format = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: file.fileFormat.sampleRate, channels: file.fileFormat.channelCount, interleaved: false)
                let buf = AVAudioPCMBuffer(pcmFormat: format!, frameCapacity: AVAudioFrameCount(file.length))
                try file.read(into: buf!)
                
                // Extract the raw audio samples from the buffer
                let frameLength = Int(buf!.frameLength)
                let samples = Array(UnsafeBufferPointer(start: buf!.floatChannelData![0], count: frameLength))

                // Calculate the chunk size for each sample set
                let chunkSize = samples.count / samplesCount
                // Ensure the chunk size is valid
                guard chunkSize > 0 else {
                    DispatchQueue.main.async {
                        completion([])
                    }
                    return
                }

                // Divide the samples into chunks
                let chunkedSamples = samples.chunked(into: chunkSize)

                // Process each chunk to calculate its magnitude
                var result = [AudioPreviewModel]()
                for chunk in chunkedSamples {
                    let magnitude = self.calculateMagnitude(for: chunk)
                    result.append(AudioPreviewModel(magnitude: magnitude, color: .gray))
                }

                // Return the processed samples on the main thread
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                // Handle any errors during audio processing
                print("Audio Error: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }

    // Function to calculate the magnitude of a chunk of audio samples
    private func calculateMagnitude(for samples: [Float]) -> Float {
        // Calculate the average power of the samples
        let power = samples.map { $0 * $0 }.reduce(0, +) / Float(samples.count)
        // Convert the power to a decibel scale
        return 10 * log10f(power)
    }
}

// Extension to divide an array into chunks of a given size
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

