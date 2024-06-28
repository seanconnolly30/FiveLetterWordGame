//
//  ContentView.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/6/24.
//

import SwiftUI
import SwiftData
import UIKit

struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query private var gameStats: [GameStats]
    
    var body: some View {
        NavigationView {
            GameView(isGameCompleted: false)
                .navigationTitle("Five Letter")
                .frame(alignment: .center)
                .navigationBarItems(leading:
                    Button(action: {
                    // Action for the leading button
                }) {
                    Image(systemName: "gear")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                }, trailing:
                    HStack {
                        Button(action: {
                            // Action for stats button
                        }) {
                            Image(systemName: "chart.bar.fill")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                        Button(action: {
                            // Action for profile button? maybe just combine it with stats button
                        }) {
                            Image(systemName: "info.circle")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                    })
            }
        .padding()
        .onAppear(perform: {
            if gameStats.isEmpty {
                let emptyStats = GameStats(winDistr: Array(repeating: 0, count: 15), gamesFailed: 0, currStreak: 0, bestStreak: 0, totalGameCount: 0, successRate: 0, guessList: [])
                context.insert(emptyStats)
            }
        })
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GameStats.self, inMemory: true)
}
