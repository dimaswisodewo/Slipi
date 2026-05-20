//
//  ContentView.swift
//  Slipi
//
//  Created by Meynabel Dimas Wisodewo on 17/05/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(NavigationRouter.self) private var router
    
    var body: some View {
        @Bindable var routerBindable = router
        NavigationStack(path: $routerBindable.path) {
            content
                .withAppRouter()
        }
    }
    
    private var content: some View {
        VStack {
            Text("Tes Halo")
            Text("Sleepey")
            Text("Jakarta Barat")
	        Text("swiftui preview")
        }
    }
}

#Preview {
    ContentView()
        .environment(NavigationRouter())
}
