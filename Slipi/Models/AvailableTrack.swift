//
//  AvailableTrack.swift
//  Slipi
//
//  Created by Meynabel Dimas Wisodewo on 24/05/26.
//

import Foundation

struct AvailableTrack: ModelPassable {
    var id: String { fileName }

    let name: String
    let fileName: String
    let iconName: String
}

extension AvailableTrack {
    static let autumnForest = AvailableTrack(name: "Autumn Forest", fileName: "autumn-forest", iconName: "leaf.fill")
    static let crickets = AvailableTrack(name: "Crickets", fileName: "crickets", iconName: "ladybug")
    static let deepBrownNoise = AvailableTrack(name: "Deep Brown Noise", fileName: "deep-brown-noise", iconName: "waveform")
    static let dryLeaves = AvailableTrack(name: "Dry Leaves", fileName: "dry-leaves", iconName: "leaf")
    static let fishMoving = AvailableTrack(name: "Fish Moving", fileName: "fish-moving", iconName: "fish")
    static let greenNoise = AvailableTrack(name: "Green Noise", fileName: "green-noise", iconName: "waveform")
    static let icySnow = AvailableTrack(name: "Icy Snow", fileName: "icy-snow", iconName: "snowflake")
    static let lightRain = AvailableTrack(name: "Light Rain", fileName: "light-rain", iconName: "cloud.rain")
    static let morningBirdsong = AvailableTrack(name: "Morning Birdsong", fileName: "morning-birdsong", iconName: "bird")
    static let sunnyDay = AvailableTrack(name: "Sunny Day", fileName: "sunny-day", iconName: "sun.max")
    static let thunderStrike = AvailableTrack(name: "Thunder Strike", fileName: "thunder-strike", iconName: "bolt")
    static let waterFlowing = AvailableTrack(name: "Water Flowing", fileName: "water-flowing", iconName: "drop")
    static let windBlowing = AvailableTrack(name: "Wind Blowing", fileName: "wind-blowing", iconName: "wind")
    static let winterForest = AvailableTrack(name: "Winter Forest", fileName: "winter-forest", iconName: "tree")

    static let catalog: [AvailableTrack] = [
        autumnForest,
        crickets,
        deepBrownNoise,
        dryLeaves,
        fishMoving,
        greenNoise,
        icySnow,
        lightRain,
        morningBirdsong,
        sunnyDay,
        thunderStrike,
        waterFlowing,
        windBlowing,
        winterForest
    ]

    static func manifestTrack(name: String, fileName: String) -> AvailableTrack {
        AvailableTrack(name: name, fileName: fileName, iconName: "music.note")
    }
}
