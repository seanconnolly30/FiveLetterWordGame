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
            .foregroundColor(.white) // Adjust the text color as needed
    }
}

#Preview {
    LetterView(letter: "H", backgroundColor: .gray)
}
