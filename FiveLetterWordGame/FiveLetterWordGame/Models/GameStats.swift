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
    var winDistr: [Double]
    var gamesFailed: Int
    var currStreak: Int
    var bestStreak: Int
    var totalGameCount: Int
    var successRate: Int
    
    init(winDistr: [Double], gamesFailed: Int, currStreak: Int, bestStreak: Int, totalGameCount: Int, successRate: Int) {
        self.winDistr = winDistr
        self.gamesFailed = gamesFailed
        self.currStreak = currStreak
        self.bestStreak = bestStreak
        self.totalGameCount = totalGameCount
        self.successRate = successRate
    }
}
