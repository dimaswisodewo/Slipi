//
//  AppRoute+Modifier.swift
//  Slipi
//

import SwiftUI

// MARK: - View Modifiers

/// The primary view modifier for the root navigation stack.
/// It configures the navigation destination handler and initializes the recursive sheet and full-screen cover stacks.
struct RouterViewModifier: ViewModifier {
    @Environment(NavigationRouter.self) private var router

    func body(content: Content) -> some View {
        content
            .navigationDestination(for: AppRoute.self) { route in
                AppRouterView.handleNavigation(route)
            }
            // Initialize recursive presentation stacks starting at index 0
            .modifier(SheetStackModifier(index: 0))
            .modifier(FullScreenCoverStackModifier(index: 0))
    }
}

/// A modifier that enables recursive sheet presentation.
/// By passing an index, it allows SwiftUI to present a stack of sheets by applying the next modifier to the sheet's content.
struct SheetStackModifier: ViewModifier {
    @Environment(NavigationRouter.self) private var router
    let index: Int

    func body(content: Content) -> some View {
        content
            .sheet(item: Binding(
                get: { router.presentedSheets.indices.contains(index) ? router.presentedSheets[index] : nil },
                set: { newValue in
                    // If sheet is dismissed manually (e.g., swipe down), update the router state.
                    // We remove the subrange to ensure that if a middle sheet is dismissed, everything above it is also cleared.
                    if newValue == nil && router.presentedSheets.indices.contains(index) {
                        router.presentedSheets.removeSubrange(index...)
                    }
                }
            )) { route in
                AppRouterView.handlePresentation(route)
                    // Apply the same modifier to the sheet content with an incremented index for further sheets.
                    .withAppRouter(at: index + 1)
            }
    }
}

/// A modifier that enables recursive full-screen cover presentation.
/// Similar to SheetStackModifier, it allows for stacking multiple full-screen covers.
struct FullScreenCoverStackModifier: ViewModifier {
    @Environment(NavigationRouter.self) private var router
    let index: Int

    func body(content: Content) -> some View {
        content
            .fullScreenCover(item: Binding(
                get: { router.presentedFullScreenCovers.indices.contains(index) ? router.presentedFullScreenCovers[index] : nil },
                set: { newValue in
                    if newValue == nil && router.presentedFullScreenCovers.indices.contains(index) {
                        router.presentedFullScreenCovers.removeSubrange(index...)
                    }
                }
            )) { route in
                AppRouterView.handleFullScreenCover(route)
                    // Apply the same modifier to the cover content with an incremented index for further covers.
                    .withFullScreenRouter(at: index + 1)
            }
    }
}

// MARK: - Router View Factory

/// A wrapper view for the sleep timer sheet that connects to persistent storage.
struct TimerSheetPresentationView: View {
    @AppStorage(AppStorageKey.defaultSleepTimerMinutes) private var defaultSleepTimerMinutes = 60
    
    var body: some View {
        DefaultSleepTimerSettingsView(defaultSleepTimerMinutes: $defaultSleepTimerMinutes)
            .presentationBackground(.black)
    }
}

/// A factory that maps `AppRoute` cases to their corresponding SwiftUI Views.
struct AppRouterView {
    /// Handles push-based navigation destinations.
    @ViewBuilder
    static func handleNavigation(_ route: AppRoute) -> some View {
        switch route {
        case .mixer:
            MixerContainerView()
        default:
            EmptyView()
        }
    }
    
    /// Handles sheet-based presentations.
    @ViewBuilder
    static func handlePresentation(_ route: AppRoute) -> some View {
        switch route {
        case .mixerSheet:
            MixerBottomSheet(mixer: MixerEngine.shared)
                .presentationDetents([.medium, .large])
                .presentationBackground(.black)
        case .timerSheet:
            TimerSheetPresentationView()
        case .equalizer(let track):
            AudioTuning(track: track)
                .presentationDetents([.medium, .large])
                .presentationBackground(.black)
        default:
            EmptyView()
        }
    }
    
    /// Handles full-screen cover presentations.
    @ViewBuilder
    static func handleFullScreenCover(_ route: AppRoute) -> some View {
        switch route {
        default:
            EmptyView()
        }
    }
}

// MARK: - View Extensions

extension View {
    /// Entry point for applying the navigation router to a view hierarchy.
    func withAppRouter() -> some View {
        self.modifier(RouterViewModifier())
    }
    
    /// Internal helper to apply recursive sheet modifiers.
    fileprivate func withAppRouter(at index: Int) -> some View {
        self.modifier(SheetStackModifier(index: index))
    }

    /// Internal helper to apply recursive full-screen cover modifiers.
    fileprivate func withFullScreenRouter(at index: Int) -> some View {
        self.modifier(FullScreenCoverStackModifier(index: index))
    }
}
