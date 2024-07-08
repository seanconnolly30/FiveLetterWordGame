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
    var canPlay: Bool
    
    init(winDistr: [Int], gamesFailed: Int, currStreak: Int, bestStreak: Int, totalGameCount: Int, successRate: Double, guessList: [GuessListModel], canPlay: Bool) {
        self.winDistr = winDistr
        self.gamesFailed = gamesFailed
        self.currStreak = currStreak
        self.bestStreak = bestStreak
        self.totalGameCount = totalGameCount
        self.successRate = successRate
        self.guessList = guessList
        self.canPlay = canPlay
    }
    func updateGameStats(didWin: Bool, gameGuessList: GuessListModel) {
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
        
    }
}
