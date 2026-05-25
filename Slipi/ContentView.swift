//
//  ContentView.swift
//  Slipi
//
//  Created by Meynabel Dimas Wisodewo on 17/05/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(NavigationRouter.self) private var router
    
    var body: some View {
        RootTabView()
    }
}

#Preview {
    ContentView()
        .environment(NavigationRouter())
        .modelContainer(for: [SavedMix.self, SavedMixTrack.self], inMemory: true)
}
