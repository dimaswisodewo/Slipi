//
//  AppRoute.swift
//  Slipi
//
//  Created by Meynabel Dimas Wisodewo on 17/05/26.
//

import Foundation
import SwiftUI

/// Represents the navigation destinations within the app.
enum AppRoute: Hashable, Identifiable {
    /// The main mixer view.
    case mixer
    /// A sheet displaying the mixer controls.
    case mixerSheet
    /// A sheet displaying the sleep timer.
    case timerSheet
    /// An equalizer adjustment view for a specific track.
    case equalizer(track: TrackChannel)
    
    var id: Self { self }
}

/// A centralized router that manages navigation state, including path stacks, presented sheets, and full-screen covers.
@Observable
class NavigationRouter {
    // MARK: - State Properties
    
    /// The currently selected tab in the main tab bar.
    var selectedTab: AppTab = .home
    
    /// Navigation paths for each tab, enabling independent back-stacks.
    var paths: [AppTab: [AppRoute]] = [
        .home: [],
        .favorites: [],
        .me: []
    ]
    
    /// A stack of presented sheets. Supports multiple stacked sheets.
    var presentedSheets: [AppRoute] = []
    
    /// A stack of presented full-screen covers.
    var presentedFullScreenCovers: [AppRoute] = []
    
    // MARK: - Computed Properties
    
    /// A convenience property to access or set the primary (first) presented sheet.
    /// - Setting to a new value appends it to the stack if not already present.
    /// - Setting to `nil` clears all presented sheets.
    var presentedSheet: AppRoute? {
        get { presentedSheets.first }
        set {
            if let newValue = newValue {
                if !presentedSheets.contains(newValue) {
                    presentedSheets.append(newValue)
                }
            } else {
                presentedSheets.removeAll()
            }
        }
    }
    
    // MARK: - Navigation Methods
    
    /// Pushes a new route onto the current tab's navigation path.
    func push(_ route: AppRoute) {
        paths[selectedTab]?.append(route)
    }
    
    /// Removes the last route from the current tab's navigation path.
    func pop() {
        if let currentPath = paths[selectedTab], !currentPath.isEmpty {
            paths[selectedTab]?.removeLast()
        }
    }
    
    /// Clears the navigation path for the current tab, returning to the root view.
    func popToRoot() {
        paths[selectedTab]?.removeAll()
    }
    
    // MARK: - Presentation Methods
    
    /// Presents a sheet by adding a route to the stack.
    func presentSheet(_ route: AppRoute) {
        presentedSheets.append(route)
    }
    
    /// Presents a full-screen cover by adding a route to the stack.
    func presentFullScreenCover(_ route: AppRoute) {
        presentedFullScreenCovers.append(route)
    }
    
    /// Dismisses the top-most presented sheet.
    func dismissSheet() {
        if !presentedSheets.isEmpty {
            presentedSheets.removeLast()
        }
    }
    
    /// Dismisses the top-most presented full-screen cover.
    func dismissFullScreenCover() {
        if !presentedFullScreenCovers.isEmpty {
            presentedFullScreenCovers.removeLast()
        }
    }
    
    /// Dismisses all presented sheets and full-screen covers.
    func dismiss() {
        presentedSheets.removeAll()
        presentedFullScreenCovers.removeAll()
    }
}
