//
//  WordValidators.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/13/24.
//

import Foundation
import UIKit
import SwiftUI

class WordHelper {
    
    private var correctWord : String = ""
    
    func checkGuessValidity(_ guess: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: guess.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: guess.lowercased(), range: range, startingAt: 0, wrap: true, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func getNumberOfCorrectLetters(guess: String) -> Int {
        if correctWord.isEmpty {
            correctWord = loadWord().lowercased()
        }
        if correctWord == guess.lowercased() {
            return 6
        }
        var count = 0
        for char in Set(guess.lowercased()) {
            if correctWord.contains(char) {
                count += 1
            }
        }
        return count
    }
    
    func isCorrectWord(_ guess: String) -> Bool {
        if correctWord.isEmpty {
            correctWord = loadWord()
        }
        if guess.lowercased() == correctWord {
            return true
            //save Game State into model container
        }
        return false
    }
    
    func getGuessAverage(arr: [Int]) -> String {
        var games = 0.0
        var total = 0.0
        for (index, value) in arr.enumerated() {
            total += (Double(index) + 1.0) * Double(value)
            games += Double(value)
        }
        
        return String(format: "%.2f", total/games)
    }
    
    func generateShareText(guessList: GuessListModel) -> String {
        let gameNumber = 820
        var emojiStr = String(guessList.guesses.count) + "/15 "
        for guess in guessList.guesses {
            let numCorrect = getNumberOfCorrectLetters(guess: guess)
            if numCorrect == 0 {
                emojiStr += "🟥"
            }
            else if numCorrect <= 3 {
                emojiStr += "🟨"
            }
            else if numCorrect >= 4 && !isCorrectWord(guess) {
                emojiStr += "🟩"
            }
            else if isCorrectWord(guess) {
                emojiStr += "🎉"
            }
        }
        
        return "High Five #" + String(gameNumber) + " " + emojiStr
    }
    
    private func loadWord() -> String{
            if let url = Bundle.main.url(forResource: "WordList", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decodedWords = try JSONDecoder().decode([String].self, from: data)
                    return decodedWords[4]
                    //return decodedWords[Int.random(in: 0...19)]
                } catch {
                    print("Error loading JSON: \(error)")
                }
            } else {
                return "empty"
            }
        return "wrong"
    }
    
}

struct ShakeEffect: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit: CGFloat = 3
    var animatableData: CGFloat
    
    init(shakes: CGFloat) {
        self.animatableData = shakes
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let translation = amount * sin(animatableData * .pi * shakesPerUnit)
        return ProjectionTransform(CGAffineTransform(translationX: translation, y: 0))
    }
}
