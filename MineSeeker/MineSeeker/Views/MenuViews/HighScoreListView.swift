//
//  HighScoreListView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/6/25.
//

import SwiftUI

struct HighScoreListView: View {
    
    @State var vm: FieldViewModel
    
    var highScoresExample: [HighScore] = [
        HighScore(name: "Jesse", score: 10000, date: Date()),
        HighScore(name: "Max", score: 8000, date: Date()),
        HighScore(name: "Sophia", score: 9000, date: Date()),
        HighScore(name: "Shiraz", score: 6000, date: Date()),
        HighScore(name: "Jamiesen", score: 5000, date: Date()),
        HighScore(name: "Zoe", score: 7000, date: Date())
    ]
    
    
    var body: some View {
        
        
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
                ForEach(highScoresExample) {highScore in
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
}

#Preview {
    HighScoreListView(vm: FieldViewModel())
}
