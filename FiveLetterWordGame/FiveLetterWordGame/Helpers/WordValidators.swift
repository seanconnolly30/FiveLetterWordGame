//
//  WordValidators.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/13/24.
//

import Foundation
import UIKit

class WordValidators {
    
    private lazy var correctWord = {
        loadWord()
    }()
    
    func checkGuessValidity(_ guess: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: guess.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: guess.lowercased(), range: range, startingAt: 0, wrap: true, language: "en")
        print(misspelledRange)
        print(misspelledRange.location == NSNotFound)
        return misspelledRange.location == NSNotFound
    }
    
    func getNumberOfCorrectLetters(guess: String) -> Int {
        var count = 0
        for char in Set(guess.lowercased()) {
            if correctWord.contains(char) {
                count += 1
            }
        }
        return count
    }
    
    func isCorrectWord(_ guess: String) -> Bool {
        if guess == correctWord {
            return true
        }
        return false
    }
    
    private func loadWord() -> String{
            if let url = Bundle.main.url(forResource: "words", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decodedWords = try JSONDecoder().decode([String].self, from: data)
                    return decodedWords[4]
                } catch {
                    print("Error loading JSON: \(error)")
                }
            } else {
                return "empty"
            }
        return "wrong"
    }
    
}
