//
//  GameView.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/12/24.
//

import SwiftUI
import Combine
import ConfettiSwiftUI
import SwiftData

typealias MyDictionary = [Character: LetterState]

public enum LetterState {
    case UntouchedState
    case UnsureState
    case EliminatedState
    case SelectedState
}

public enum GameState {
    case WonState
    case LossState
    case ActiveState
}

class DictionaryStore: ObservableObject {
    @Published var myDictionary: MyDictionary = ["A": .UntouchedState, "B": .UntouchedState, "C": .UntouchedState, "D": .UntouchedState, "E": .UntouchedState, "F": .UntouchedState, "G": .UntouchedState, "H": .UntouchedState, "I": .UntouchedState, "J": .UntouchedState, "K": .UntouchedState, "L": .UntouchedState, "M": .UntouchedState, "N": .UntouchedState, "O": .UntouchedState, "P": .UntouchedState, "Q": .UntouchedState, "R": .UntouchedState, "S": .UntouchedState, "T": .UntouchedState, "U": .UntouchedState, "V": .UntouchedState, "W": .UntouchedState, "X": .UntouchedState, "Y": .UntouchedState, "Z": .UntouchedState]
} // make separate keyboard overview mode where user can see letter state, instead of making actual custom keyboard
//and only show letter state on letters that are inside a guess

//also need validator for if new word is available, and whether game should be locked

struct GameView: View {
    @State var activeGuessIndex: Int = 0
    //@EnvironmentObject var charStateDict: DictionaryStore
    @State var guessList: [(String, Int)] = []
    @FocusState private var isWordViewFocused: Bool
    @State var isGameCompleted: GameState
    @Binding var confettiBinding: Int
    @State private var isStatsPresented = false
    @Query private var gameStats: [GameStats]

    var body: some View {
        ScrollView(showsIndicators: false) {
            if isGameCompleted == GameState.ActiveState {
                VStack {
                    ForEach(0..<15, id: \.self) { index in
                        WordView(myIndex: index, guessList: $guessList, activeGuessIndex: $activeGuessIndex, isGameCompleted: $isGameCompleted)
                    }
                }
            } 
            else {
                VStack {
                    ForEach(0..<15, id: \.self) { index in
                        WordView(myIndex: index, guessList: $guessList, activeGuessIndex: $activeGuessIndex, isGameCompleted: $isGameCompleted, preFilled: getGuessContentIfNeeded(index: index))
                    }
                }
            }
        }
        
        
        .onChange(of: isGameCompleted) { oldValue, newValue in
            if newValue == GameState.WonState {
                confettiBinding += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isStatsPresented = true
                }
            }
        }
        .sheet(isPresented: $isStatsPresented) {
            StatsView(isGameCompleted: isGameCompleted)
        }
    }
    
    func getGuessContentIfNeeded(index: Int) -> String {
        if isGameCompleted != GameState.ActiveState, let guesses = gameStats[0].mostRecentItem?.guesses {
            if guesses.count > index {
                return guesses[index]
            }
        }
        return ""
    }
}

