//
//  WordView.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/12/24.
//

import SwiftUI
import SwiftData

struct WordView: View {
    @Environment(\.modelContext) var context
    
    @State var userInput: String = ""
    var myIndex: Int
    @State var isWinner: Bool = false
    @State var isCompletedState: Bool = false
    @State var numberCorrect: Int = 0
    @State private var showError: Bool = false
    @State private var shakes: CGFloat = 0
    @FocusState var isFocused: Bool
    @Binding var guessList: [(String, Int)]
    @Binding var activeGuessIndex: Int
    @Binding var isGameCompleted: GameState
    @EnvironmentObject var charStateDict: DictionaryStore
    @Query private var gameStats: [GameStats]
    var preFilled: String = ""
    
    var helper = WordHelper()
    var body: some View {
        TextField("", text: $userInput)
            .frame(width: 0, height: 0)
            .foregroundColor(.clear)
            .focused($isFocused)
            .tint(.clear)
            .disableAutocorrection(true)
            .autocapitalization(.allCharacters)
            .onChange(of: userInput, { oldValue, newValue in
                let filtered = newValue.filter { $0.isLetter }
                if filtered != newValue {
                    userInput = filtered
                }
                if newValue.count > 5 {
                    userInput = oldValue
                }
            })
            .onSubmit {
                if userInput.count == 5 && helper.checkGuessValidity(userInput){
                    numberCorrect = helper.getNumberOfCorrectLetters(guess: userInput)
                    isCompletedState = true
                    guessList.append((userInput, numberCorrect))
                    if helper.isCorrectWord(userInput){
                        let guessModel = GuessListModel(guesses: guessList.map { $0.0 }, date: .now)
                        gameStats[0].updateGameStats(didWin: true, gameGuessList: guessModel)
                        isGameCompleted = GameState.WonState
                        isWinner = true
                        activeGuessIndex += 1
                        for item in Set(userInput) {
                            charStateDict[String(item)] = LetterState.CorrectState
                        }
                        return
                    }
                    else if activeGuessIndex >= 14 {
                        let guessModel = GuessListModel(guesses: guessList.map { $0.0 }, date: .now)
                        gameStats[0].updateGameStats(didWin: false, gameGuessList: guessModel)
                        isGameCompleted = GameState.LossState
                        return
                    } 
                    else if WordHelper().getNumberOfCorrectLetters(guess: userInput) == 0 {
                        for item in Set(userInput) {
                            charStateDict[String(item)] = LetterState.SystemEliminatedState
                        }
                    }
                    activeGuessIndex += 1
                } else {
                    withAnimation(Animation.linear(duration: 0.5).repeatCount(1, autoreverses: false)) {
                        shakes += 1
                    }
                    showError.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showError.toggle()
                        isFocused = true
                    }
                }
            }
        HStack {
                ForEach(0..<5, id: \.self) { index in
                    LetterView(letter: getCharacter(at: index), backgroundColor: activeGuessIndex == myIndex ? (showError ? .red : .gray) : (WordHelper().getWordColorFromState(dict: charStateDict, letter: getCharacter(at: index))))
                        .disabled(!(isGameCompleted == GameState.ActiveState))
                }
            
                Divider()
                    .frame(height: 40)
            
                NumberView(active: preFilled.isEmpty ? isCompletedState : true, number: preFilled.isEmpty ? numberCorrect : WordHelper().getNumberOfCorrectLetters(guess: preFilled))
                    .disabled(true)
        }
            .modifier(ShakeEffect(shakes: shakes))
            .padding(.horizontal)
        
        .onAppear {
            focusTextField()
        }
        .onChange(of: activeGuessIndex, {
            focusTextField()
        })
        .onTapGesture {
            focusTextField()
        }
    }
    private func getCharacter(at index: Int) -> String {
        if preFilled.isEmpty {
            if index < userInput.count {
                let charIndex = userInput.index(userInput.startIndex, offsetBy: index)
                return String(userInput[charIndex])
            } else {
                return ""
            }
        } else {
            return String(preFilled[preFilled.index(preFilled.startIndex, offsetBy: index)])
        }
    }
    func focusTextField() {
        if (myIndex == activeGuessIndex) &&  !isCompletedState && isGameCompleted == GameState.ActiveState {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                isFocused = true
            }
        }
    }
}
