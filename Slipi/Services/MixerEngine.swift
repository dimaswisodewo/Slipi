//
//  MixerEngine.swift
//  Slipi
//

import Foundation
import AVFoundation
import Combine

class MixerEngine: ObservableObject {
    private let audioEngine = AVAudioEngine()
    private let mainMixer = AVAudioMixerNode()
    
    // This is the array your SwiftUI views will look at
    @Published var tracks: [TrackChannel] = []
    @Published var isPlaying = false
    
    init() {
        audioEngine.attach(mainMixer)
        audioEngine.connect(mainMixer, to: audioEngine.mainMixerNode, format: nil)
        
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
            try audioEngine.start()
        } catch {
            print("Could not start audio engine or set session: \(error)")
        }
    }
    
    deinit {
        audioEngine.stop()
    }
    
    /// Pass a dictionary of ["Track Display Name": "filename_in_xcode"]
    func loadLocalManifest(_ manifest: [String: String]) {
        // Stop current playbacks and reset
        stop()
        tracks.removeAll()
        
        for (displayName, fileName) in manifest {
            // Find the local file in the app bundle
            guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "wav") else {
                print("Could not find local file: \(fileName).wav")
                continue
            }
            
            do {
                let channel = try TrackChannel(name: displayName, fileURL: fileURL)
                
                // Attach the nodes to the engine
                audioEngine.attach(channel.playerNode)
                audioEngine.attach(channel.eqNode)
                audioEngine.attach(channel.speedNode)
                
                // Chain: Player -> EQ -> Speed -> Mixer
                let format = channel.file.processingFormat
                audioEngine.connect(channel.playerNode, to: channel.eqNode, format: format)
                audioEngine.connect(channel.eqNode, to: channel.speedNode, format: format)
                audioEngine.connect(channel.speedNode, to: mainMixer, format: format)
                
                // Schedule looping playback
                scheduleLoop(channel)
                
                // Add to our published array
                tracks.append(channel)
            } catch {
                print("Error initializing track \(displayName): \(error)")
            }
        }
    }
    
    private func scheduleLoop(_ channel: TrackChannel) {
        channel.playerNode.scheduleFile(channel.file, at: nil) { [weak self] in
            // Re-schedule when audio finishes to loop infinitely
            DispatchQueue.main.async {
                if self?.isPlaying == true {
                    self?.scheduleLoop(channel)
                }
            }
        }
    }
    
    func togglePlayPause() {
        if isPlaying {
            tracks.forEach { $0.playerNode.pause() }
            isPlaying = false
        } else {
            tracks.forEach { $0.playerNode.play() }
            isPlaying = true
        }
    }
    
    func stop() {
        tracks.forEach { $0.playerNode.stop() }
        isPlaying = false
    }
}
