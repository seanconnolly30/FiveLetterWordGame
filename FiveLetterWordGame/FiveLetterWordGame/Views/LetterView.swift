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
    
    var body: some View {
        Text(letter)
            .font(.largeTitle)
            .frame(width: 50, height: 50)
            .background(backgroundColor)
            .cornerRadius(8) 
            .foregroundColor(.white) // Adjust the text color as needed
    }
}

#Preview {
    LetterView(letter: "H", backgroundColor: .gray)
}
