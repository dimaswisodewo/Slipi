//
//  TrackChannel.swift
//  Slipi
//

import Foundation
import AVFoundation
import Combine

class TrackChannel: ObservableObject, ModelPassable {
    let id = UUID()
    let trackID: AvailableTrack.ID
    let name: String
    let iconName: String
    
    // Engine Nodes
    let playerNode = AVAudioPlayerNode()
    let speedNode = AVAudioUnitVarispeed()
    let eqNode = AVAudioUnitEQ(numberOfBands: 3)
    let file: AVAudioFile
    
    // SwiftUI Bindings (Updating these instantly modifies the audio stream)
    @Published var volume: Float = 1.0 { didSet { playerNode.volume = volume } }
    @Published var pan: Float = 0.0 { didSet { playerNode.pan = pan } }
    @Published var speed: Float = 1.0 { didSet { speedNode.rate = speed } }
    @Published var bass: Float = 0.0 { didSet { eqNode.bands[0].gain = bass } }
    @Published var mid: Float = 0.0 { didSet { eqNode.bands[1].gain = mid } }
    @Published var treble: Float = 0.0 { didSet { eqNode.bands[2].gain = treble } }
    
    init(track: AvailableTrack, fileURL: URL) throws {
        self.trackID = track.id
        self.name = track.name
        self.iconName = track.iconName
        self.file = try AVAudioFile(forReading: fileURL)
        setupEQBands()
    }
    
    private func setupEQBands() {
        eqNode.bands[0].frequency = 100  // Bass
        eqNode.bands[1].frequency = 1000 // Mid
        eqNode.bands[2].frequency = 5000 // Treble
        eqNode.bands.forEach { $0.filterType = .parametric }
    }

    func apply(_ savedTrack: SavedMixTrack) {
        volume = savedTrack.volume
        pan = savedTrack.pan
        speed = savedTrack.speed
        bass = savedTrack.bass
        mid = savedTrack.mid
        treble = savedTrack.treble
    }
}
