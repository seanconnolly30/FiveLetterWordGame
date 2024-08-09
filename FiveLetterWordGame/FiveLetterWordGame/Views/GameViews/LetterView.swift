//
//  LetterView.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/12/24.
//

import SwiftUI

struct LetterView: View {
    var letter: String
    var backgroundColor: Color
    @EnvironmentObject var charStateDict: DictionaryStore
    var body: some View {
        Text(letter.uppercased())
            .font(.largeTitle)
            .frame(width: 45, height: 45)
            .background(backgroundColor)
            .cornerRadius(8) 
            .foregroundColor(.white) 
            .onTapGesture {
                changeLetterState()
            }
    }
    
    func changeLetterState(){
        let currState = charStateDict[letter]
        if currState == LetterState.UntouchedState {
            charStateDict[letter] = LetterState.EliminatedState
        }
        if currState == LetterState.EliminatedState {
            charStateDict[letter] = LetterState.UnsureState
        }
        if currState == LetterState.UnsureState {
            charStateDict[letter] = LetterState.CorrectState
        }
        if currState == LetterState.CorrectState {
            charStateDict[letter] = LetterState.UntouchedState
        }
    }
}

#Preview {
    LetterView(letter: "H", backgroundColor: .gray)
}
