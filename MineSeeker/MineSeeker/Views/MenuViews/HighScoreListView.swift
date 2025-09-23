//
//  HighScoreListView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/6/25.
//

import SwiftUI
import SwiftData

struct HighScoreListView: View {
    
    @EnvironmentObject var orientation: OrientationModel
    @Environment(\.modelContext) private var modelContext
    @State var vm: FieldViewModel
    
    
    
    var body: some View {
        
        Text("HIGH SCORES")
            .font(Font.largeTitle.bold())
            .padding()
        
        TabView {
            VStack {
                
                VStack(alignment: .center) {
                    if UIDevice.isIPhone {
                        List {
                            ScrollView(.horizontal) {
                                Grid(alignment: .center, horizontalSpacing: orientation.isLandscape ? 25 : 10) {
                                    GridRow(alignment: .center) {
                                        Text("Name")
                                        //.gridCellAnchor(UnitPoint(x: 1, y: 0.5))
                                        Spacer()
                                        Text("Score")
                                        Spacer()
                                        Text("Mines")
                                        Spacer()
                                        Text("Size")
                                        Spacer()
                                        Text("Difficulty")
                                        Spacer()
                                        Text("Hints")
                                        Spacer()
                                        Text("Date")
                                    }
                                    .font(Font.headline)
                                    Divider()
                                    if vm.hsvm.highScores.isEmpty {
                                        
                                        Text("There are no high scores yet.")
                                            .font(Font.caption)
                                        
                                    } else {
                                        ForEach(vm.hsvm.highScores.prefix(20)) { highScore in
                                            GridRow(alignment: .center) {
                                                Text(highScore.name)
                                                //.gridCellAnchor(UnitPoint(x: 1, y: 0.5))
                                                Spacer()
                                                Text(String(highScore.score))
                                                Spacer()
                                                Text(String(highScore.mineCount))
                                                Spacer()
                                                Text(String(vm.sizeLabel(for: highScore.gridSize)))
                                                Spacer()
                                                Text(String(vm.difficultyLabel(for: highScore.difficulty)))
                                                Spacer()
                                                Text(String(highScore.hintsUsed))
                                                Spacer()
                                                Text(highScore.date.shortFormat)
                                            }
                                            .font(Font.caption)
                                            if highScore != vm.hsvm.highScores.last {
                                                Divider()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else
                    {
                        Table(vm.hsvm.highScores){
                            TableColumn("Name", value: \.name)
                            TableColumn("Date") { highScore in
                                Text(highScore.date, format: .dateTime.day().month().year())
                            }
                            TableColumn("Mine Count") {highScore in
                                Text(String(highScore.mineCount))
                            }
                            TableColumn("Hints Used") {highScore in
                                Text(String(highScore.hintsUsed))
                            }
                            TableColumn("GridSize") {highScore in
                                Text(vm.sizeLabel(for: highScore.gridSize))
                            }
                            TableColumn("Score") { highScore in
                                Text(String(highScore.score))
                            }
                        }
                        
                        
                    }
                }
                
                HomeButtonView(vm: vm)
                    .padding(.bottom, 10)
            }
            .onAppear {
                vm.hsvm.fetchHighScores(from: modelContext)
            }
            .tabItem {
                Image(systemName: "person.circle.fill")
                Text("My Scores")
            }
            
            VStack {
                Text("Coming Soon")
                HomeButtonView(vm: vm)
                    .padding(.bottom, 10)
            }
            .tabItem {
                Image(systemName: "globe.fill")
                Text("Global Scores")
            }
            
            
            VStack {
                Text("Coming Soon")
                HomeButtonView(vm: vm)
                    .padding(.bottom, 10)
            }
            .tabItem {
                Image(systemName: "person.3.fill")
                Text("Friend Scores")
            }
            
        }
        .padding(0)
    }
}


#Preview {
    HighScoreListView(vm: FieldViewModel())
        .environmentObject({
            let mock = OrientationModel()
            mock.current = .landscapeLeft
            return mock
        }())
}


//    var highScoresExamples: [HighScore] = [
//        HighScore(id: UUID(), name: "Jesse S", score: 3000, date: Date(), gridSize: .big, hintsUsed: 0, duration: 1000, mineCount: 10),
//        HighScore(id: UUID(), name: "Florian R", score: 5000, date: Date(), gridSize: .big, hintsUsed: 0, duration: 1000, mineCount: 10),
//        HighScore(id: UUID(), name: "Jon K", score: 4000, date: Date(), gridSize: .big, hintsUsed: 0, duration: 1000, mineCount: 10),
//        HighScore(id: UUID(), name: "Victoria R", score: 2000, date: Date(), gridSize: .small, hintsUsed: 0, duration: 1000, mineCount: 10),
//        HighScore(id: UUID(), name: "Mel S", score: 8000, date: Date(), gridSize: .big, hintsUsed: 0, duration: 1000, mineCount: 10),
//        HighScore(id: UUID(), name: "Alex Y", score: 3500, date: Date(), gridSize: .small, hintsUsed: 0, duration: 1000, mineCount: 10),
//        HighScore(id: UUID(), name: "Maria E", score: 6000, date: Date(), gridSize: .big, hintsUsed: 0, duration: 1000, mineCount: 10),
//        ]
