//
//  GameStats.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/6/24.
//

import Foundation
import SwiftData

@Model
final class GameStats {
    var winDistr: [Int]
    var gamesFailed: Int
    var currStreak: Int
    var bestStreak: Int
    var totalGameCount: Int
    var successRate: Double
    var guessList: [GuessListModel]
    var lastIsUnfinished: Bool
    
    init(winDistr: [Int], gamesFailed: Int, currStreak: Int, bestStreak: Int, totalGameCount: Int, successRate: Double, guessList: [GuessListModel], lastIsUnfinished: Bool) {
        self.winDistr = winDistr
        self.gamesFailed = gamesFailed
        self.currStreak = currStreak
        self.bestStreak = bestStreak
        self.totalGameCount = totalGameCount
        self.successRate = successRate
        self.guessList = guessList
        self.lastIsUnfinished = lastIsUnfinished
    }
    func updateGameStats(didWin: Bool, gameGuessList: GuessListModel) {
        if let unfinished = getLastInstance(), lastIsUnfinished {
            if let index = guessList.firstIndex(where: { $0.date == unfinished.date }) {
                guessList[index] = gameGuessList
            }
        }
        else {
            guessList.append(gameGuessList)
        }
        updateStatsHelper(didWin: didWin, gameGuessList: gameGuessList)
    }

    func updateStatsHelper(didWin: Bool, gameGuessList: GuessListModel) {
        totalGameCount += 1
        if didWin {
            winDistr[gameGuessList.guesses.count - 1] += 1
            currStreak += 1
            if currStreak > bestStreak {
                bestStreak += 1
            }
        } else {
            currStreak = 0
            gamesFailed += 1
        }
        successRate = (Double(totalGameCount) - Double(gamesFailed)) / Double(totalGameCount) * 100.0
        lastIsUnfinished = false
        try? self.modelContext?.save()
    }

    func saveGameStatsOnClose(gameGuessList: GuessListModel) {
        if let unfinished = getLastInstance(), lastIsUnfinished {
            if let index = guessList.firstIndex(where: { $0.date == unfinished.date }) {
                guessList[index] = gameGuessList
            }
        }
        else {
            guessList.append(gameGuessList)
        }
        lastIsUnfinished = true
        try? self.modelContext?.save()
    }
    
    func getLastInstance() -> GuessListModel? {
        let date = mostRecentItem?.date ?? Calendar.current.date(byAdding: .hour, value: -25, to: Date())!
        let startOfToday = Calendar.current.startOfDay(for: Date())
        if date < startOfToday {
            return nil
        }
        else {
            return mostRecentItem
        }
    }
    
    var mostRecentItem: GuessListModel? {
        guessList.max(by: { $0.date < $1.date })
    }
}
