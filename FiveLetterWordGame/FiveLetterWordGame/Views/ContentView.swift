//
//  ContentView.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/6/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var gameStats: [GameStats]

    var body: some View {
        NavigationView {
            GameView()
        }
    }

    private func saveGame() {
        withAnimation {
            let newItem = GameStats(winDistr: [4,5,8,9,12,5,4], gamesFailed: 0, currStreak: 7, bestStreak: 7, totalGameCount: 7, successRate: 100)
            modelContext.insert(newItem)
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: GameStats.self, inMemory: true)
}
