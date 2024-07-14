//
//  Strings.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 7/2/24.
//

import Foundation

struct StringCentral {
    static let totaltries = "Total Tries"
    static let currStreak = "Current Streak"
    static let bestStreak = "Best Streak"
    static let winRate = "Win Rate"
    static let numResults = "# of Results"
    static let resultDistr = "Result Distribution "
    static let avg = "(Average: "
    static let statsTitle = "Stats"
    static let backBtnTxt = "Back"
    static let contentNavTitle = "Five Letter"
    
    static let infoViewTitle = "How to play"
    static let infoParagraph1 = "Guess the word in 15 tries. After each guess, you will be told only the number of letters in common with the mystery word. Try clicking on letters to change their color and take notes!"
    static let infoParagraph2 = "Click once to turn a letter grey if you know it's not in the word. Click again for a letter you're uncertain about to become yellow. And click a third time to make letters you're sure about green!"
    static let infoLine3 = "For example, if the word is \"VEGAN\""
    static let infoParagraph4 = "Only the 'N' is in the mystery word. It only counts as one letter towards the score, regardless of how many 'N's are in your guess."
    static let infoLine5 = "There are 4 letters in common with the word - every letter except 'U'."
    static let tipsTitle = "Some tips:"
    static let tipsList = """
• The mystery word will contain five unique letters
• But feel free to use any five letter words to guess!
• Sometimes zero letters in common is good! This allows you to narrow down the list of possible letters.
• Try guessing words with repeated letters - it gives the same benefit as using letters you know aren't in the word.
"""
    static let shareText = "Share with your friends!"
    
    
}
