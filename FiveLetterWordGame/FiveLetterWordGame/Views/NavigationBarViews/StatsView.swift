//
//  StatsView.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/28/24.
//

import SwiftUI
import SwiftData
import Charts

struct StatsView: View {
    @Query private var gameStats: [GameStats]
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    var isGameCompleted: GameState
    var body: some View {
        NavigationView {
            VStack (alignment: .center, content: {
                HStack(alignment: .top, content: {
                    Spacer()
                    VStack{
                        Text(String(gameStats[0].totalGameCount))
                            .font(.title)
                        Text(StringCentral.totaltries)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 60)
                    Spacer()
                    VStack{
                        Text(String(gameStats[0].currStreak))
                            .font(.title)
                        Text(StringCentral.currStreak)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 60)
                    Spacer()
                    VStack{
                        Text(String(gameStats[0].bestStreak))
                            .font(.title)
                        Text(StringCentral.bestStreak)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 60)
                    Spacer()
                    VStack{
                        Text(String(format: "%.2f", gameStats[0].successRate) + "%")
                            .font(.title)
                        Text(StringCentral.winRate)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                })
                
                Chart {
                    ForEach(0..<15, id: \.self) { index in
                        BarMark(x: .value("Type", String(index + 1)), y: .value(StringCentral.numResults, gameStats[0].winDistr[index]))
                    }
                }
                .padding([.top, .leading, .trailing])
                .frame(height: 375)
                
                HStack(alignment: .center, content: {
                    Text(StringCentral.resultDistr + StringCentral.avg + WordHelper().getGuessAverage(arr: gameStats[0].winDistr) + ")")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                })
                
                .navigationBarTitle(StringCentral.statsTitle, displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                })
                .padding()
                
                
                if let list = gameStats[0].mostRecentItem, isGameCompleted == GameState.WonState {
                    ShareLink(item: WordHelper().generateShareText(guessList: list)){
                        Label(StringCentral.shareText, systemImage:  "square.and.arrow.up")
                            .frame(width: 225, height: 50)
                            .background(Color(hex: 0x5ba4fc))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    }
                }
                
                Spacer()
                
                Text(StringCentral.contactUs)
                    .padding([.leading, .trailing])
                    .font(.caption)
                Text(try! AttributedString(markdown: StringCentral.email))

            })
        }
    }
}
