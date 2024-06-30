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
    var body: some View {
        NavigationView {
            VStack (alignment: .center, content: {
                HStack(alignment: .center, content: {
                    Spacer()
                    VStack{
                        Text(String(gameStats[0].totalGameCount))
                            .font(.title)
                        Text("Total Tries")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 60)
                    Spacer()
                    VStack{
                        Text(String(gameStats[0].currStreak))
                            .font(.title)
                        Text("Current Streak")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 60)
                    Spacer()
                    VStack{
                        Text(String(gameStats[0].bestStreak))
                            .font(.title)
                        Text("Best Streak")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 60)
                    Spacer()
                    VStack{
                        Text(String(gameStats[0].successRate) + "%")
                            .font(.title)
                        Text("Win Rate")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                })
                
                Chart {
                    ForEach(0..<15, id: \.self) { index in
                        BarMark(x: .value("Type", String(index + 1)), y: .value("# of Results", gameStats[0].winDistr[index]))
                    }
                }
                .padding()
                .frame(height: 375)
                
                HStack(alignment: .center, content: {
                    Text("Result Distribution " + "(Average: " + NavBarHelper().getGuessAverage(arr: gameStats[0].winDistr) + ")")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                })
               
                
                
                
                
                .navigationBarTitle("Stats", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                })
                .padding()
                Spacer()
            })
        }
    }
}

//#Preview {
//    MainActor.assumeIsolated {
//        StatsView()
//            .modelContainer(previewContainer)
//    }
//}
//
//@MainActor
//var previewContainer: ModelContainer = {
//    let schema = Schema([
//        GameStats.self,
//    ])
//    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//    do {
//        return try ModelContainer(for: schema, configurations: [modelConfiguration])
//    } catch {
//        fatalError("Could not create ModelContainer: \(error)")
//    }
//}()
