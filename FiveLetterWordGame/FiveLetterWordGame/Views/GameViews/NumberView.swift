//
//  NumberView.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/12/24.
//

import SwiftUI

struct NumberView: View {
    var active: Bool
    var number: Int
    //var won: Bool = false
    
    var body: some View {
        if active {
            Text(String(number))
                .font(.largeTitle)
                .frame(width: 45, height: 45)
                .background(getColor())
                .cornerRadius(8)
                .foregroundColor(.white)
                .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 2))
        } else {
            Text("")
                .font(.largeTitle)
                .frame(width: 45, height: 45)
                .background(.gray)
                .cornerRadius(8)
                .foregroundColor(.white)
        }
        }
    
    private func getColor() -> Color{
        if number < 2 {
            return .red
        }
        else if number < 4{
            return .yellow
        }
        else {return .green}
    }
}

#Preview {
    NumberView(active: true, number: 5)
}
