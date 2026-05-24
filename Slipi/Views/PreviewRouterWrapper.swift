//
//  PreviewRouterWrapper.swift
//  Slipi
//

import SwiftUI

/// A wrapper view for SwiftUI Previews that provides a functional NavigationRouter.
struct PreviewRouterWrapper<Content: View>: View {
    @State private var router = NavigationRouter()
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        @Bindable var routerBindable = router
        NavigationStack(path: $routerBindable.paths[.home] ?? .constant([])) {
            content()
                .withAppRouter()
        }
        .environment(router)
    }
}

// Helper to provide a constant binding for safety
private func ??<T>(lhs: Binding<T?>, rhs: Binding<T>) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs.wrappedValue },
        set: { lhs.wrappedValue = $0 }
    )
}
