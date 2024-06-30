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
    
    @State private var isStatsPresented = false
    @State private var isSettingsPresented = false
    @State private var isInfoPresented = false
    
    //need handling for if game has been played today or not, should flow through here into GameView. Add var to GamesStats for last game played?
    //and then base
    
    var body: some View {
        NavigationView {
            GameView(isGameCompleted: GameState.ActiveState)
                .navigationTitle("Five Letter")
                .frame(alignment: .center)
                .navigationBarItems(leading:
                    Button(action: {
                    isSettingsPresented = true
                }) {
                    Image(systemName: "gear")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                }, trailing:
                    HStack {
                        Button(action: {
                            isStatsPresented = true
                        }) {
                            Image(systemName: "chart.bar")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                        Button(action: {
                            isInfoPresented = true
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
                let emptyStats = GameStats(winDistr: Array(repeating: 0, count: 15), gamesFailed: 0, currStreak: 0, bestStreak: 0, totalGameCount: 0, successRate: 0, guessList: [], canPlay: true)
                context.insert(emptyStats)
            }
        })
        .sheet(isPresented: $isStatsPresented) {
            StatsView()
        }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView()
        }
        .sheet(isPresented: $isInfoPresented) {
            InfoView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GameStats.self, inMemory: true)
}
