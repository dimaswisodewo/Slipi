//
//  AppRoute.swift
//  Slipi
//
//  Created by Meynabel Dimas Wisodewo on 17/05/26.
//

import Foundation
import SwiftUI

enum AppRoute: Hashable, Identifiable {
    case mixer
    case equalizer(track: TrackChannel)
    
    var id: Self { self }
}

@Observable
class NavigationRouter {
    var selectedTab: AppTab = .home
    var paths: [AppTab: [AppRoute]] = [
        .home: [],
        .favorites: [],
        .me: []
    ]
    var presentedSheet: AppRoute?
    var presentedFullScreenCover: AppRoute?
    
    func push(_ route: AppRoute) {
        paths[selectedTab]?.append(route)
    }
    
    func pop() {
        if let currentPath = paths[selectedTab], !currentPath.isEmpty {
            paths[selectedTab]?.removeLast()
        }
    }
    
    func popToRoot() {
        paths[selectedTab]?.removeAll()
    }
    
    func presentSheet(_ route: AppRoute) {
        presentedSheet = route
    }
    
    func presentFullScreenCover(_ route: AppRoute) {
        presentedFullScreenCover = route
    }
    
    func dismissSheet() {
        presentedSheet = nil
    }
    
    func dismissFullScreenCover() {
        presentedFullScreenCover = nil
    }
    
    func dismiss() {
        dismissSheet()
        dismissFullScreenCover()
    }
}
