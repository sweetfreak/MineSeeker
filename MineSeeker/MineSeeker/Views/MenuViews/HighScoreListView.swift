//
//  HighScoreListView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/6/25.
//

import SwiftUI
import SwiftData

struct HighScoreListView: View {
    
    
    
    @Environment(\.modelContext) private var modelContext
    @State var vm: FieldViewModel
    
    var highScoresExample: [HighScore] = [
        HighScore(id: UUID(), name: "Jesse", score: 10000, date: Date()),
        HighScore(id: UUID(), name: "Max", score: 8000, date: Date()),
        HighScore(id: UUID(), name: "Sophia", score: 9000, date: Date()),
        HighScore(id: UUID(), name: "Shiraz", score: 6000, date: Date()),
        HighScore(id: UUID(), name: "Jamiesen", score: 5000, date: Date()),
        HighScore(id: UUID(), name: "Zoe", score: 7000, date: Date())
    ]
    
    
    var body: some View {
        
        VStack {
            Text("HIGH SCORES")
                .font(Font.largeTitle.bold())
            
            Spacer()
            
            VStack {
                HStack {
                    Text("Name")
                    Spacer()
                    Text("Score")
                    Spacer()
                    Text("Date")
                }
                .font(Font.title)
                
                .padding(0)
                
                
                List {
                    ForEach(vm.hsvm.highScores.prefix(10)) {highScore in
                        HStack {
                            //Text("\(highScore.rank).")
                            Text(highScore.name)
                            Spacer()
                            Text("\(highScore.score)")
                            Text(highScore.date, style: .date)
                                .padding(.leading, 20)
                        }
                    }
                }
                .padding(0)
            }
            HomeButtonView(vm: vm)
        }
        .onAppear {
            vm.hsvm.fetchHighScores(from: modelContext)
        }
    }
}

#Preview {
    HighScoreListView(vm: FieldViewModel())
}
