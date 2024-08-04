//
//  ContentView.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/6/24.
//

import SwiftUI
import SwiftData
import UIKit
import ConfettiSwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query private var gameStats: [GameStats]
    
    @State private var isStatsPresented = false
    @State private var isSettingsPresented = false
    @State private var isInfoPresented = false
    @State var confettiBinding: Int = 0
    
    @State var count: Int = 0
    var body: some View {
        NavigationView {
            GameView(isGameCompleted: getGameCompleted(), confettiBinding: $confettiBinding)
                .navigationTitle(StringCentral.contentNavTitle)
                .frame(alignment: .center)
                .confettiCannon(counter: $confettiBinding, num: 60, confettiSize: 13, rainHeight: CGFloat(1000), fadesOut: false, openingAngle: Angle(degrees: 50), closingAngle: Angle(degrees: 130), radius: 500.0, repetitions: 2, repetitionInterval: 0.3)
                .navigationBarItems(leading:
                    Button(action: {
                    isInfoPresented = true
                }) {
                    Image(systemName: "info.circle")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                }, trailing:
                    Button(action: {
                        isStatsPresented = true
                    }) {
                        Image(systemName: "chart.bar")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                    )
            }
        .padding()
        .sheet(isPresented: $isStatsPresented) {
            StatsView(isGameCompleted: getGameCompleted())
        }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView()
        }
        .sheet(isPresented: $isInfoPresented) {
            InfoView()
        }
    }
    func getGameCompleted() -> GameState {
        context.autosaveEnabled = true
        if gameStats.isEmpty {
            let emptyStats = GameStats(winDistr: Array(repeating: 0, count: 15), gamesFailed: 0, currStreak: 0, bestStreak: 0, totalGameCount: 0, successRate: 0, guessList: [], canPlay: true)
            context.insert(emptyStats)
            try! context.save()
        }
        let date = gameStats[0].mostRecentItem?.date ?? Calendar.current.date(byAdding: .hour, value: -25, to: Date())!
        let startOfToday = Calendar.current.startOfDay(for: Date())
        
        if date < startOfToday {
            return GameState.ActiveState
        }
        else if gameStats[0].currStreak == 0  && gameStats[0].totalGameCount > 0 {
            return GameState.LossState
        }
        else {
            return GameState.WonState
        }
    }
}
