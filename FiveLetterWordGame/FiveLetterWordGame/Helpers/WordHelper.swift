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
        let startDay = Calendar.current.date(from: DateComponents(year: 2022, month: 4, day: 1))!
        var start = Calendar.current.startOfDay(for: startDay)
        let today = Calendar.current.startOfDay(for: Date())
        var gameNumber = 0
        while start < today {
            gameNumber += 1
            start = Calendar.current.date(byAdding: .day, value: 1, to: start)!
        }
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
    
    func getWordColorFromState(dict: DictionaryStore, letter: String) -> Color {
        if dict[letter] == LetterState.UntouchedState || letter == "" {
            return .gray
        }
        else if dict[letter] == LetterState.EliminatedState {
            return Color("eliminatedColor")
        }
        else if dict[letter] == LetterState.UnsureState {
            return .yellow
        }
        else {
            return .green
        }
    }
    
    private func loadWord() -> String{
            if let url = Bundle.main.url(forResource: "WordList", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decodedWords = try JSONDecoder().decode([String].self, from: data)
                    let index = getMysteryIndex()
                    if index != -1 {
                        return decodedWords[index % decodedWords.count]
                    }
                    return "fails"
                } catch {
                    print("Error loading JSON: \(error)")
                }
            } else {
                return "empty"
            }
        return "wrong"
    }
    
    private func getMysteryIndex() -> Int {
        if let url = Bundle.main.url(forResource: "MysteryOrder", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedInts = try JSONDecoder().decode([Int].self, from: data)
                
                let startDay = Calendar.current.date(from: DateComponents(year: 2022, month: 4, day: 1))!
                var start = Calendar.current.startOfDay(for: startDay)
                let today = Calendar.current.startOfDay(for: Date())
                var index = 0
                while start < today {
                    index += 1
                    start = Calendar.current.date(byAdding: .day, value: 1, to: start)!
                }
                return Int(decodedInts[index])
            } catch {
                print("Error loading JSON: \(error)")
            }
        }
        
        return -1
    
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
