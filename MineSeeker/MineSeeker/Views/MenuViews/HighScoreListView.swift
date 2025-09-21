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

    var highScoresExamples: [HighScore] = [
        HighScore(id: UUID(), name: "Jesse S", score: 3000, date: Date(), gridSize: .big, hintsUsed: 0, duration: 1000, mineCount: 10),
        HighScore(id: UUID(), name: "Florian R", score: 5000, date: Date(), gridSize: .big, hintsUsed: 0, duration: 1000, mineCount: 10),
        HighScore(id: UUID(), name: "Jon K", score: 4000, date: Date(), gridSize: .big, hintsUsed: 0, duration: 1000, mineCount: 10),
        HighScore(id: UUID(), name: "Victoria R", score: 2000, date: Date(), gridSize: .small, hintsUsed: 0, duration: 1000, mineCount: 10),
        HighScore(id: UUID(), name: "Mel S", score: 8000, date: Date(), gridSize: .big, hintsUsed: 0, duration: 1000, mineCount: 10),
        HighScore(id: UUID(), name: "Alex Y", score: 3500, date: Date(), gridSize: .small, hintsUsed: 0, duration: 1000, mineCount: 10),
        HighScore(id: UUID(), name: "Maria E", score: 6000, date: Date(), gridSize: .big, hintsUsed: 0, duration: 1000, mineCount: 10),
        ]
    
    var body: some View {
        
        VStack {
            Text("HIGH SCORES")
                .font(Font.largeTitle.bold())
            
            Spacer()
            Spacer()
            Spacer()
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
                                    Text("Hints?")
                                    Spacer()
                                    Text("Date")
                                }
                                .font(Font.title3.bold())
                                Divider()
//                                if vm.hsvm.highScores.isEmpty {
                                                                if !vm.hsvm.highScores.isEmpty {
                                    Text("There are no high scores yet.")
                                        .font(Font.caption)
                                    
                                } else {
//                                    ForEach(vm.hsvm.highScores.prefix(10)) { highScore in
                                                                        ForEach(highScoresExamples.prefix(10)) { highScore in
                                        GridRow(alignment: .center) {
                                            Text(highScore.name)
                                            //.gridCellAnchor(UnitPoint(x: 1, y: 0.5))
                                            Spacer()
                                            Text(String(highScore.score))
                                            Spacer()
                                            Text(String(highScore.mineCount))
                                            Spacer()
                                            Text(String(label(for: highScore.gridSize)))
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
                        TableColumn("Date") { entry in
                            Text(entry.date, format: .dateTime.day().month().year())
                        }
                        TableColumn("Mine Count") {entry in
                            Text(String(entry.mineCount))
                        }
                        TableColumn("Hints Used") {entry in
                            Text(String(entry.hintsUsed))
                        }
                        TableColumn("GridSize") {entry in
                            Text(label(for: entry.gridSize))
                        }
                        TableColumn("Score") { entry in
                            Text(String(entry.score))
                        }
                    }
                

                }
            }
            HomeButtonView(vm: vm)
//            Button {
//                for highScore in highScoresExamples
//                        
//            } label: {
//                Text("Add Names to UI")
//            }
        }
        .onAppear {
            vm.hsvm.fetchHighScores(from: modelContext)
        }
    }
    
    private func label(for size: GridSize) -> String {
        switch size {
        case .small: return "Small"
        case .med: return "Medium"
        case .big: return "Big"
        case .huge: return "Huge"
        }
    }
}


#Preview {
    HighScoreListView(vm: FieldViewModel())
        .environmentObject({
            let mock = OrientationModel()
            mock.current = .portrait
            return mock
        }())
}

//example demo stuff
//#Preview {
//    let vm = FieldViewModel()
//    let  vm.hsvm.highScores = highScoreExamples //mockData
//    return HighScoresListView(vm: vm) // or whatever your view is
//}
