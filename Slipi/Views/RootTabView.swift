//
//  RootTabView.swift
//  Slipi
//

import SwiftUI

struct RootTabView: View {
    @Environment(NavigationRouter.self) private var router
    
    var body: some View {
        @Bindable var routerBindable = router
        
        VStack(spacing: 0) {
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
            
            CustomTabBarView()
        }
        .ignoresSafeArea(.keyboard)
    }
    
    @ViewBuilder
    private func tabContentView(for tab: AppTab) -> some View {
        switch tab {
        case .mixer:
            MixerContainerView()
        case .settings:
            settingsPlaceholder
        }
    }
    
    private var settingsPlaceholder: some View {
        VStack {
            Text("Settings")
        }
        .navigationTitle("Settings")
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
