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
        print(misspelledRange)
        print(misspelledRange.location == NSNotFound)
        return misspelledRange.location == NSNotFound
    }
    
    func getNumberOfCorrectLetters(guess: String) -> Int {
        if correctWord.isEmpty {
            correctWord = loadWord()
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
