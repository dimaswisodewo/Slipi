//
//  MixerEngine.swift
//  Slipi
//

import Foundation
import AVFoundation
import Combine

class MixerEngine: ObservableObject {
    static let shared = MixerEngine()
    
    private let audioEngine = AVAudioEngine()
    private let mainMixer = AVAudioMixerNode()
    
    // This is the array your SwiftUI views will look at
    @Published var tracks: [TrackChannel] = []
    @Published var isPlaying = false
    
    private init() {
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
        
        // Remove existing tracks properly
        while !tracks.isEmpty {
            removeTrack(id: tracks[0].id)
        }
        
        for (displayName, fileName) in manifest {
            addTrack(.manifestTrack(name: displayName, fileName: fileName))
        }
    }
    
    func activeTrack(for track: AvailableTrack) -> TrackChannel? {
        tracks.first { $0.trackID == track.id }
    }

    func isTrackActive(_ track: AvailableTrack) -> Bool {
        activeTrack(for: track) != nil
    }

    func addTrack(_ track: AvailableTrack) {
        guard activeTrack(for: track) == nil else { return }

        guard let fileURL = Bundle.main.url(forResource: track.fileName, withExtension: "wav") ??
                            Bundle.main.url(forResource: track.fileName, withExtension: "mp3") else {
            print("Could not find local file: \(track.fileName).wav or .mp3")
            return
        }
        
        do {
            let channel = try TrackChannel(track: track, fileURL: fileURL)
            
            // Attach the nodes to the engine
            audioEngine.attach(channel.playerNode)
            audioEngine.attach(channel.eqNode)
            audioEngine.attach(channel.speedNode)
            
            // Chain: Player -> EQ -> Speed -> Mixer
            let format = channel.file.processingFormat
            audioEngine.connect(channel.playerNode, to: channel.eqNode, format: format)
            audioEngine.connect(channel.eqNode, to: channel.speedNode, format: format)
            audioEngine.connect(channel.speedNode, to: mainMixer, format: format)
            
            // Add to our published array
            tracks.append(channel)
            
            // Always schedule the file so it's ready in the buffer
            scheduleLoop(channel)
            
            // Autoplay when a track is added
            if !isPlaying {
                isPlaying = true
                tracks.forEach { $0.playerNode.play() }
            } else {
                channel.playerNode.play()
            }
        } catch {
            print("Error initializing track \(track.name): \(error)")
        }
    }
    
    func removeTrack(id: UUID) {
        guard let index = tracks.firstIndex(where: { $0.id == id }) else { return }
        let channel = tracks.remove(at: index)
        
        // Stop and detach
        channel.playerNode.stop()
        
        audioEngine.disconnectNodeOutput(channel.playerNode)
        audioEngine.disconnectNodeOutput(channel.eqNode)
        audioEngine.disconnectNodeOutput(channel.speedNode)
        
        audioEngine.detach(channel.playerNode)
        audioEngine.detach(channel.eqNode)
        audioEngine.detach(channel.speedNode)
        
        if tracks.isEmpty {
            isPlaying = false
        }
    }
    
    private func scheduleLoop(_ channel: TrackChannel) {
        channel.playerNode.scheduleFile(channel.file, at: nil) { [weak self, weak channel] in
            guard let self = self, let channel = channel else { return }
            
            // Re-schedule when audio finishes to loop infinitely, but only if track still exists
            DispatchQueue.main.async {
                if self.tracks.contains(where: { $0.id == channel.id }) {
                    self.scheduleLoop(channel)
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
