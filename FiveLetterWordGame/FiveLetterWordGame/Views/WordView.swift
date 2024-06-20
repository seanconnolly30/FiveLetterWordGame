//
//  WordView.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/12/24.
//

import SwiftUI

struct WordView: View {
    @State var userInput: String = ""
    @State var isTextFieldActive: Bool
    @State var isCompletedState: Bool = false
    @State var numberCorrect: Int = 0
    @Binding var activeGuessIndex: Int
    var validator = WordValidators()
    var body: some View {
        TextField("", text: $userInput)
            .frame(width: 300, height: 10)
            .foregroundColor(.clear)
            .focusable(true)
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
                if userInput.count == 5 && validator.checkGuessValidity(userInput){ //and word validator
                    numberCorrect = validator.getNumberOfCorrectLetters(guess: userInput)
                    isCompletedState = true
                    print("entered " + userInput)
                } else {
                    //need error state, maybe short red flash if not 5 letters
                    //and separate larger error if word is not valid
                }
            }
        HStack {
            ForEach(0..<5, id: \.self) { index in
                LetterView(letter: getCharacter(at: index), backgroundColor: .gray)
            }
            NumberView(active: isCompletedState, number: numberCorrect)
        }
            .padding(.horizontal)
        .onAppear {
        if isTextFieldActive {
            sleep(2)
            DispatchQueue.main.async {
                UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                print("tried to focus")
            }
        }
    }
    }
    private func getCharacter(at index: Int) -> String {
        if index < userInput.count {
            let charIndex = userInput.index(userInput.startIndex, offsetBy: index)
            return String(userInput[charIndex])
        } else {
            return ""
        }
    }
}

#Preview {
    //@State var activeGuessIndex: Int = 2
    WordView(isTextFieldActive: true, activeGuessIndex: .constant(2))
}
