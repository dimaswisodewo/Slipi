//
//  AppRoute+Modifier.swift
//  Slipi
//

import SwiftUI

struct RouterViewModifier: ViewModifier {
    @Environment(NavigationRouter.self) private var router

    func body(content: Content) -> some View {
        @Bindable var routerBindable = router
        content
            .navigationDestination(for: AppRoute.self) { route in
                handleNavigation(route)
            }
            .sheet(item: $routerBindable.presentedSheet) { route in
                handlePresentation(route)
            }
            .fullScreenCover(item: $routerBindable.presentedFullScreenCover) { route in
                handleFullScreenCover(route)
            }
    }
    
    @ViewBuilder
    private func handleNavigation(_ route: AppRoute) -> some View {
        switch route {
        case .mixer:
            MixerContainerView()
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private func handlePresentation(_ route: AppRoute) -> some View {
        switch route {
        case .mixerSheet:
            MixerBottomSheet(mixer: MixerEngine.shared)
                .presentationDetents([.medium, .large])
                .presentationBackground(.black)
        case .equalizer(let track):
            AudioTuning(track: track)
                .presentationDetents([.medium, .large])
                .presentationBackground(.black)
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private func handleFullScreenCover(_ route: AppRoute) -> some View {
        switch route {
        default:
            EmptyView()
        }
    }
}

extension View {
    func withAppRouter() -> some View {
        self.modifier(RouterViewModifier())
    }
}
