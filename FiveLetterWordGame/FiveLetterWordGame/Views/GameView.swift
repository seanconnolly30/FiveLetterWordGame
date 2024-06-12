//
//  GameView.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/12/24.
//

import SwiftUI
import Combine

struct GameView: View {
    @State var activeGuessIndex: Int = 0
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
