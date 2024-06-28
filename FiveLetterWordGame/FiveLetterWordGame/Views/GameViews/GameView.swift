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
} // make separate keyboard overview mode where user can see letter state, instead of making actual custom keyboard
//and only show letter state on letters that are inside a guess


struct GameView: View {
    @State var activeGuessIndex: Int = 0
    //@EnvironmentObject var charStateDict: DictionaryStore
    @State var guessList: [(String, Int)] = []
    @FocusState private var isWordViewFocused: Bool
    @State var isGameCompleted: Bool
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(0..<15, id: \.self) { index in
                    WordView(myIndex: index, guessList: $guessList, activeGuessIndex: $activeGuessIndex, isGameCompleted: $isGameCompleted)
                }
            }
        }
        //.padding()
    }
}

#Preview {
    GameView(isGameCompleted: false)
}
