//
//  RootTabView.swift
//  Slipi
//

import SwiftUI
import SwiftData

struct RootTabView: View {
    @Environment(NavigationRouter.self) private var router
    private let mixer = MixerEngine.shared
    
    var body: some View {
        @Bindable var routerBindable = router
        
        ZStack(alignment: .bottom) {
            ForEach(AppTab.allCases) { tab in
                NavigationStack(path: $routerBindable.paths[tab] ?? .constant([])) {
                    tabContentView(for: tab)
                        .withAppRouter()
                }
                .opacity(router.selectedTab == tab ? 1 : 0)
                .allowsHitTesting(router.selectedTab == tab)
            }
            
            FloatingMiniPlayerView(mixer: mixer)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            VStack(spacing: 0) {
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
            FavoritesRemixView()
        case .me:
            SettingSleepey()
        }
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
        .modelContainer(for: [SavedMix.self, SavedMixTrack.self], inMemory: true)
}
