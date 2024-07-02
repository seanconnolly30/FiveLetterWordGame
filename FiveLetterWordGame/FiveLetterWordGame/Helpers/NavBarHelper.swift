//
//  NavBarHelper.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/30/24.
//

import Foundation
import Charts

class NavBarHelper {
    
    func getGuessAverage(arr: [Int]) -> String{
        var games = 0
        var total = 0
        for (index, value) in arr.enumerated() {
            total += (index + 1) * value
            games += value
        }
        return String(total/games)
    }
}
