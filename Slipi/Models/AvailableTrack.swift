//
//  AvailableTrack.swift
//  Slipi
//
//  Created by Meynabel Dimas Wisodewo on 24/05/26.
//

import Foundation

struct AvailableTrack: ModelPassable {
    let id = UUID()
    let name: String
    let fileName: String
}
