//
//  InactiveWordView.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/26/24.
//

import SwiftUI

struct InactiveWordView: View {
    var guess: String
    var numberCorrect: Int
    
    var body: some View {
        HStack {
            ForEach(0..<5, id: \.self) { index in
                LetterView(letter: String(Array(guess)[index]), backgroundColor: .gray)
            }
            NumberView(active: true, number: numberCorrect)
        }
    }
}

#Preview {
    //@State var activeGuessIndex: Int = 2
    InactiveWordView(guess: "guess", numberCorrect: 2)
}
