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
        NavigationStack(path: $routerBindable.path) {
            content()
                .withAppRouter()
        }
        .environment(router)
    }
}
