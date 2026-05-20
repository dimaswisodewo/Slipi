//
//  ModelPassable.swift
//  Slipi
//

import Foundation

/// A protocol that provides default Hashable and Equatable implementations
/// for any Identifiable model, making it easy to pass through SwiftUI navigation routes.
protocol ModelPassable: Identifiable, Hashable {}

extension ModelPassable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
