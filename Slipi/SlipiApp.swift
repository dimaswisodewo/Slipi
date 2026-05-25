//
//  SlipiApp.swift
//  Slipi
//
//  Created by Meynabel Dimas Wisodewo on 17/05/26.
//

import SwiftUI
import SwiftData

@main
struct SlipiApp: App {
    @State private var router = NavigationRouter()

    // Keep one explicit container so we can inspect the same SwiftData
    // configuration that the app injects into the view hierarchy.
    private let modelContainer: ModelContainer

    init() {
        // Register every @Model type that belongs to this SwiftData store.
        let schema = Schema([
            SavedMix.self,
            SavedMixTrack.self
        ])

        // This matches the previous default persistent setup, but exposes
        // configuration.url so we can print the database location in debug.
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            modelContainer = try ModelContainer(
                for: schema,
                configurations: [configuration]
            )
            Self.printSwiftDataStoreLocation(configuration)
        } catch {
            fatalError("Could not create SwiftData ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(router)
        }
        .modelContainer(modelContainer)
    }

    private static func printSwiftDataStoreLocation(_ configuration: ModelConfiguration) {
        #if DEBUG
        // SwiftData stores SQLite sidecar files next to the main database.
        // Open the main file in a SQLite browser, and keep the WAL/SHM files
        // beside it when copying the database for inspection.
        let url = configuration.url
        print("SwiftData store: \(url.path)")
        print("SwiftData WAL: \(url.path)-wal")
        print("SwiftData SHM: \(url.path)-shm")
        #endif
    }
}
