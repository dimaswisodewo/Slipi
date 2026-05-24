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
    static let dryLeaves = AvailableTrack(name: "Dry Leaves", fileName: "dry-leaves", iconName: "leaf")
    static let fishMoving = AvailableTrack(name: "Fish Moving", fileName: "fish-moving", iconName: "fish")
    static let lightRain = AvailableTrack(name: "Light Rain", fileName: "light-rain", iconName: "cloud.rain")
    static let thunderStrike = AvailableTrack(name: "Thunder Strike", fileName: "thunder-strike", iconName: "bolt")
    static let waterFlowing = AvailableTrack(name: "Water Flowing", fileName: "water-flowing", iconName: "drop")
    static let windBlowing = AvailableTrack(name: "Wind Blowing", fileName: "wind-blowing", iconName: "wind")

    static let catalog: [AvailableTrack] = [
        dryLeaves,
        fishMoving,
        lightRain,
        thunderStrike,
        waterFlowing,
        windBlowing
    ]

    static func manifestTrack(name: String, fileName: String) -> AvailableTrack {
        AvailableTrack(name: name, fileName: fileName, iconName: "music.note")
    }
}
