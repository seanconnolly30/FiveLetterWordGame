//
//  FiveLetterWordGameApp.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/6/24.
//

import SwiftUI
import SwiftData

@main
struct FiveLetterWordGameApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            GameStats.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(firstLaunch: isFirstLaunch())
        }
        .modelContainer(sharedModelContainer)
    }
    func isFirstLaunch() -> Bool {
        let hasLaunchedPrev = UserDefaults.standard.bool(forKey: "hasLaunchedPrev")
        if hasLaunchedPrev {
            return false
        }
        else {
            UserDefaults.standard.set(true, forKey: "hasLaunchedPrev")
            return true
        }
    }
}
