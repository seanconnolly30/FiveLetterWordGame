//
//  GameView.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/12/24.
//

import SwiftUI
import Combine

typealias MyDictionary = [Character: LetterState]

public enum LetterState {
    case UntouchedState
    case UnsureState
    case EliminatedState
    case SelectedState
}

class DictionaryStore: ObservableObject {
    @Published var myDictionary: MyDictionary = ["A": .UntouchedState, "B": .UntouchedState, "C": .UntouchedState, "D": .UntouchedState, "E": .UntouchedState, "F": .UntouchedState, "G": .UntouchedState, "H": .UntouchedState, "I": .UntouchedState, "J": .UntouchedState, "K": .UntouchedState, "L": .UntouchedState, "M": .UntouchedState, "N": .UntouchedState, "O": .UntouchedState, "P": .UntouchedState, "Q": .UntouchedState, "R": .UntouchedState, "S": .UntouchedState, "T": .UntouchedState, "U": .UntouchedState, "V": .UntouchedState, "W": .UntouchedState, "X": .UntouchedState, "Y": .UntouchedState, "Z": .UntouchedState]
}


struct GameView: View {
    @State var activeGuessIndex: Int = 0
    @EnvironmentObject var charStateDict: DictionaryStore
    var body: some View {

        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(0..<15, id: \.self) { index in
                    WordView(isTextFieldActive: index == activeGuessIndex, activeGuessIndex: $activeGuessIndex)
                }
            }
        }
        .padding()
    }
}

#Preview {
    GameView()
}
