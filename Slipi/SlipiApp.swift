//
//  SlipiApp.swift
//  Slipi
//
//  Created by Meynabel Dimas Wisodewo on 17/05/26.
//

import SwiftUI

@main
struct SlipiApp: App {
    @State private var router = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(router)
        }
    }
}
