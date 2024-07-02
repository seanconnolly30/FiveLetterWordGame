//
//  GuessListModel.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/28/24.
//

import Foundation
import SwiftData

@Model
final class GuessListModel {
    var guesses: [String]
    var date: Date
    
    init(guesses: [String], date: Date) {
        self.guesses = guesses
        self.date = date
    }
}
