//
//  NumberView.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/12/24.
//

import SwiftUI
import ConfettiSwiftUI

struct NumberView: View {
    var active: Bool
    var number: Int
    @State var confettiBinding: Int = 0
    
    var body: some View {
        if active {
            Text(number > 5 ? "🎉" : String(number))
                .font(.largeTitle)
                .frame(width: 45, height: 45)
                .background(getColor())
                .cornerRadius(22.5)
                .foregroundColor(.white)
                .confettiCannon(counter: $confettiBinding, radius: 100)
                .onTapGesture{
                    if number > 5 {
                        confettiBinding += 1
                    }
                }
        } else {
            Text("")
                .font(.largeTitle)
                .frame(width: 45, height: 45)
                .background(.gray)
                .cornerRadius(22.5)
                .foregroundColor(.white)
        }
    }
    
    private func getColor() -> Color{
        if number < 1 {
            return .red
        }
        else if number < 4 {
            return .yellow
        }
        else {
            return .green
        }
    }
}

#Preview {
    NumberView(active: true, number: 5)
}
