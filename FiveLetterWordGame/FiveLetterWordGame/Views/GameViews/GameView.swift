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

typealias MyDictionary = [String: LetterState]

public enum LetterState {
    case UntouchedState
    case UnsureState
    case EliminatedState
    case CorrectState
}

public enum GameState {
    case WonState
    case LossState
    case ActiveState
}

class DictionaryStore: ObservableObject {
    @Published var myDictionary: MyDictionary
    @Query private var gameStats: [GameStats]
    init() {
        self.myDictionary = ["A": .UntouchedState, "B": .UntouchedState, "C": .UntouchedState, "D": .UntouchedState, "E": .UntouchedState, "F": .UntouchedState, "G": .UntouchedState, "H": .UntouchedState, "I": .UntouchedState, "J": .UntouchedState, "K": .UntouchedState, "L": .UntouchedState, "M": .UntouchedState, "N": .UntouchedState, "O": .UntouchedState, "P": .UntouchedState, "Q": .UntouchedState, "R": .UntouchedState, "S": .UntouchedState, "T": .UntouchedState, "U": .UntouchedState, "V": .UntouchedState, "W": .UntouchedState, "X": .UntouchedState, "Y": .UntouchedState, "Z": .UntouchedState]
    }
    
    subscript(key: String) -> LetterState? {
        get {
            return myDictionary[key]
        }
        set(newValue) {
            myDictionary[key] = newValue
        }
    }
}

struct GameView: View {
    @State var activeGuessIndex: Int = 0
    @StateObject var charStateDict: DictionaryStore = DictionaryStore()
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
                    .environmentObject(charStateDict)
                }
            } 
            else {
                VStack {
                    ForEach(0..<15, id: \.self) { index in
                        WordView(myIndex: index, guessList: $guessList, activeGuessIndex: $activeGuessIndex, isGameCompleted: $isGameCompleted, preFilled: getGuessContentIfNeeded(index: index))
                    }
                    .environmentObject(charStateDict)
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

