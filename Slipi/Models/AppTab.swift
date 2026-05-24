//
//  AppTab.swift
//  Slipi
//

import Foundation

enum AppTab: String, CaseIterable, Identifiable, Hashable {
    case home
    case favorites
    case me
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .favorites: return "Favorites"
        case .me: return "Me"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "music.note.house.fill"
        case .favorites: return "heart.fill"
        case .me: return "person.fill"
        }
    }
}
