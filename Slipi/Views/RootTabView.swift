//
//  RootTabView.swift
//  Slipi
//

import SwiftUI

struct RootTabView: View {
    @Environment(NavigationRouter.self) private var router
    private let mixer = MixerEngine.shared
    
    var body: some View {
        @Bindable var routerBindable = router
        
        ZStack {
            ForEach(AppTab.allCases) { tab in
                NavigationStack(path: $routerBindable.paths[tab] ?? .constant([])) {
                    tabContentView(for: tab)
                        .withAppRouter()
                }
                .opacity(router.selectedTab == tab ? 1 : 0)
                .allowsHitTesting(router.selectedTab == tab)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            VStack(spacing: 0) {
                FloatingMiniPlayerView(mixer: mixer)

                CustomTabBarView()
            }
            .background(Color.brandBackground.ignoresSafeArea(edges: .bottom))
        }
        .ignoresSafeArea(.keyboard)
    }
    
    @ViewBuilder
    private func tabContentView(for tab: AppTab) -> some View {
        switch tab {
        case .home:
            HomePage()
        case .favorites:
            favoritesPlaceholder
        case .me:
            mePlaceholder
        }
    }

    private var favoritesPlaceholder: some View {
        VStack {
            Text("Favorites")
        }
        .navigationTitle("Favorites")
    }

    private var mePlaceholder: some View {
        VStack {
            Text("Me")
        }
        .navigationTitle("Me")
    }
}

// Helper to provide a constant binding for safety, though paths should always exist for all keys
private func ??<T>(lhs: Binding<T?>, rhs: Binding<T>) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs.wrappedValue },
        set: { lhs.wrappedValue = $0 }
    )
}

#Preview {
    RootTabView()
        .environment(NavigationRouter())
}
