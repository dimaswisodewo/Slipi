//
//  AppTab.swift
//  Slipi
//

import Foundation

enum AppTab: String, CaseIterable, Identifiable, Hashable {
    case mixer
    case settings
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .mixer: return "Mixer"
        case .settings: return "Settings"
        }
    }
    
    var icon: String {
        switch self {
        case .mixer: return "slider.horizontal.3"
        case .settings: return "gearshape.fill"
        }
    }
}
