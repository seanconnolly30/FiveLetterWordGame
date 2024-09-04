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
    @Environment(\.scenePhase) private var scenePhase
    @Query private var gameStats: [GameStats]
    
    @State private var isStatsPresented = false
    @State private var isSettingsPresented = false
    @State var isInfoPresented = false
    @State private var confettiBinding: Int = 0
    @StateObject var charStateDict: DictionaryStore = DictionaryStore()
    @State private var isGameCompleted : GameState = GameState.ActiveState
    @State var firstLaunch: Bool = false
    @State var count: Int = 0
    var body: some View {
        NavigationView {
            GameView(isGameCompleted: $isGameCompleted, confettiBinding: $confettiBinding)
                .navigationTitle(StringCentral.contentNavTitle)
                .environmentObject(charStateDict)
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
                    HStack {
                        Button(action: {
                            isStatsPresented = true
                        }) {
                            Image(systemName: "chart.bar")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                        Button(action: {
                            resetCharStatusDict()
                        }) {
                            Image(systemName: "gobackward")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                    }
                )
            }

        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $isStatsPresented) {
            StatsView(isGameCompleted: getGameCompleted())
        }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView()
        }
        .sheet(isPresented: $isInfoPresented) {
            InfoView()
        }

        .onChange(of: scenePhase, { oldValue, newValue in
            if newValue == .active {
                isGameCompleted = getGameCompleted()
                resetCharStatusDict()
            }
        })
        .onAppear {
            if firstLaunch {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    isInfoPresented = true
                }
            }
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
        return GameState.ActiveState
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

    func resetCharStatusDict() {
        if getGameCompleted() == GameState.ActiveState {
            for key in charStateDict.myDictionary.keys {
                if charStateDict[key] != LetterState.SystemEliminatedState {
                    charStateDict[key] = LetterState.UntouchedState
                }
            }
        }
    }
}
