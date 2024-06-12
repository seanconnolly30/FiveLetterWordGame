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
    @Binding var activeGuessIndex: Int
    var body: some View {
        TextField("Enter", text: $userInput)
            .frame(width: 100, height: 10)
            //.foregroundColor(.clear)
            .focusable(true)
            .onChange(of: userInput, { oldValue, newValue in
                if newValue.count > 5 {
                    userInput = oldValue
                }
            })
            .onSubmit {
                print("Enter button pressed")
            }
        HStack {
            ForEach(0..<5, id: \.self) { index in
                LetterView(letter: getCharacter(at: index), backgroundColor: .gray)
            }
            NumberView(active: true, number: 4)
        }
        .onAppear {
        if isTextFieldActive {
            // Activate the TextField when the view appears
            DispatchQueue.main.async {
                UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
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
