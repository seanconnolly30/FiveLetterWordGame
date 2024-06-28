//
//  WordView.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/12/24.
//

import SwiftUI

struct WordView: View {
    @State var userInput: String = ""
    var myIndex: Int
    @State var isCompletedState: Bool = false
    @State var numberCorrect: Int = 0
    @State private var showError: Bool = false
    @State private var shakes: CGFloat = 0
    @FocusState var isFocused: Bool
    @Binding var guessList: [(String, Int)]
    @Binding var activeGuessIndex: Int
    var validator = WordValidators()
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
                if userInput.count == 5 && validator.checkGuessValidity(userInput){
                    numberCorrect = validator.getNumberOfCorrectLetters(guess: userInput)
                    isCompletedState = true
                    activeGuessIndex += 1
                    guessList.append((userInput, numberCorrect))
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
                LetterView(letter: getCharacter(at: index), backgroundColor: showError ? .red : .gray)
            }
            NumberView(active: isCompletedState, number: numberCorrect)
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
        if index < userInput.count {
            let charIndex = userInput.index(userInput.startIndex, offsetBy: index)
            return String(userInput[charIndex])
        } else {
            return ""
        }
    }
    func focusTextField() {
        if myIndex == activeGuessIndex {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                print("tried to focus")
                isFocused = true
            }
        }
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

//#Preview {
//    //@State var activeGuessIndex: Int = 2
//    //@State var exmpl = [("string", 2)]
//    WordView(isTextFieldActive: true, guessList: $exmpl, activeGuessIndex: .constant(2))
//}
