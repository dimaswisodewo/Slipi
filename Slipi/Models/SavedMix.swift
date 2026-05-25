//
//  SavedMix.swift
//  Slipi
//

import Foundation
import SwiftData

@Model
final class SavedMix {
    @Attribute(.unique) var id: UUID
    var title: String
    var createdAt: Date
    var updatedAt: Date

    @Relationship(deleteRule: .cascade, inverse: \SavedMixTrack.mix)
    var tracks: [SavedMixTrack]

    init(
        id: UUID = UUID(),
        title: String,
        tracks: [SavedMixTrack],
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.title = title
        self.tracks = tracks
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    var orderedTracks: [SavedMixTrack] {
        tracks.sorted { lhs, rhs in
            if lhs.order == rhs.order {
                return lhs.trackID < rhs.trackID
            }

            return lhs.order < rhs.order
        }
    }
}

@Model
final class SavedMixTrack {
    var trackID: String
    var name: String
    var fileName: String
    var iconName: String
    var order: Int
    var volume: Float
    var pan: Float
    var speed: Float
    var bass: Float
    var mid: Float
    var treble: Float
    var mix: SavedMix?

    init(
        trackID: String,
        name: String,
        fileName: String,
        iconName: String,
        order: Int,
        volume: Float,
        pan: Float,
        speed: Float,
        bass: Float,
        mid: Float,
        treble: Float
    ) {
        self.trackID = trackID
        self.name = name
        self.fileName = fileName
        self.iconName = iconName
        self.order = order
        self.volume = volume
        self.pan = pan
        self.speed = speed
        self.bass = bass
        self.mid = mid
        self.treble = treble
    }
}
