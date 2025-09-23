//
//  HighScoreListView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/6/25.
//

import SwiftUI
import SwiftData
import GameKit

struct GameCenterHighScoreListView: View {
//    
//    @EnvironmentObject var orientation: OrientationModel
//    @Environment(\.modelContext) private var modelContext
    @State var vm: FieldViewModel
//    
//    
//    
    var body: some View {
//        TabView {
//            VStack {
//                Text("HIGH SCORES")
//                    .font(Font.largeTitle.bold())
//                
//                Spacer()
//                Spacer()
//                Spacer()
//                
//                
//                VStack(alignment: .center) {
//                    if UIDevice.isIPhone {
//                        List {
//                            ScrollView(.horizontal) {
//                                Grid(alignment: .center, horizontalSpacing: orientation.isLandscape ? 25 : 10) {
//                                    GridRow(alignment: .center) {
//                                        Text("Name")
//                                        //.gridCellAnchor(UnitPoint(x: 1, y: 0.5))
//                                        Spacer()
//                                        Text("Score")
//                                        Spacer()
//                                        Text("Mines")
//                                        Spacer()
//                                        Text("Size")
//                                        Spacer()
//                                        Text("Hints?")
//                                        Spacer()
//                                        Text("Date")
//                                    }
//                                    .font(Font.title3.bold())
//                                    Divider()
//                                    if vm.hsvm.highScores.isEmpty {
//                                        
//                                        Text("There are no high scores yet.")
//                                            .font(Font.caption)
//                                        
//                                    } else {
//                                        ForEach(vm.hsvm.highScores.prefix(10)) { highScore in
//                                            GridRow(alignment: .center) {
//                                                Text(highScore.name)
//                                                //.gridCellAnchor(UnitPoint(x: 1, y: 0.5))
//                                                Spacer()
//                                                Text(String(highScore.score))
//                                                Spacer()
//                                                Text(String(highScore.mineCount))
//                                                Spacer()
//                                                Text(String(vm.sizeLabel(for: highScore.gridSize)))
//                                                Spacer()
//                                                Text(String(highScore.hintsUsed))
//                                                Spacer()
//                                                Text(highScore.date.shortFormat)
//                                            }
//                                            .font(Font.caption)
//                                            if highScore != vm.hsvm.highScores.last {
//                                                Divider()
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    } else
//                    {
//                        Table(vm.hsvm.highScores){
//                            TableColumn("Name", value: \.name)
//                            TableColumn("Date") { highScore in
//                                Text(highScore.date, format: .dateTime.day().month().year())
//                            }
//                            TableColumn("Mine Count") {highScore in
//                                Text(String(highScore.mineCount))
//                            }
//                            TableColumn("Hints Used") {highScore in
//                                Text(String(highScore.hintsUsed))
//                            }
//                            TableColumn("GridSize") {highScore in
//                                Text(vm.sizeLabel(for: highScore.gridSize))
//                            }
//                            TableColumn("Score") { highScore in
//                                Text(String(highScore.score))
//                            }
//                        }
//                        
//                        
//                    }
//                }
//                
//                HomeButtonView(vm: vm)
//                //            Button {
//                //                for highScore in highScoresExamples
//                //
//                //            } label: {
//                //                Text("Add Names to UI")
//                //            }
//            }
//            .onAppear {
//                vm.hsvm.fetchHighScores(from: modelContext)
//            }
//            .tabItem {
//                Image(systemName: "person.circle.fill")
//                Text("My Scores")
//            }
//            
//            VStack {
//                //vm.hsvm.globalClassicScores
//                    if UIDevice.isIPhone {
//                        List {
//                            ScrollView(.horizontal) {
//                                Grid(alignment: .center, horizontalSpacing: orientation.isLandscape ? 25 : 10) {
//                                    GridRow(alignment: .center) {
//                                        Text("Name")
//                                        //.gridCellAnchor(UnitPoint(x: 1, y: 0.5))
//                                        Spacer()
//                                        Text("Score")
//                                        Spacer()
//                                    }
//                                    .font(Font.title3.bold())
//                                    Divider()
//                                    if vm.hsvm.globalClassicScores.isEmpty {
//                                        
//                                        Text("There are no high scores yet.")
//                                            .font(Font.caption)
//                                        
//                                    } else {
//                                        ForEach(vm.hsvm.globalClassicScores.prefix(10)) { highScore in
//                                            GridRow(alignment: .center) {
//                                                Text(highScore.name)
//                                                //.gridCellAnchor(UnitPoint(x: 1, y: 0.5))
//                                                Spacer()
//                                                Text(String(highScore.score))
//                                                Spacer()
//                                            }
//                                            .font(Font.caption)
//                                            if highScore != vm.hsvm.globalClassicScores.last {
//                                                Divider()
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    } else
//                    {
////                        Table(vm.hsvm.globalClassicScores){
////                            TableColumn("Name", value: \.name)
////                            
////                            TableColumn("Score") { highScore in
////                                Text(String(highScore.score))
////                            }
////                        }
//                        
//                        let vc = GKGameCenterViewController(
//                                     leaderboardID: "me.jesse.sheehan.MineFind.classicboard",
//                                     playerScope: .global,
//                                     timeScope: .allTime)
//                        vc.gameCenterDelegate = self
//                        
//                        //Present(vc, animated: true, completion: nil)
//                        
//                    }
//                
//            }
//            .tabItem {
//                Image(systemName: "globe.fill")
//                Text("Global Scores")
//                
//            }
//            
//            
////            VStack {
////                
////            }
////            .tabItem {
////                Image(systemName: "person.3.fill")
////                Text("Friend Scores")
////            }
//            
//            
//            
//        }
//        .onAppear(){
//            if !GKLocalPlayer.local.isAuthenticated {
//                vm.authenticateUser()
//            } else if vm.hsvm.globalClassicScores.count == 0 {
//                Task{
//                    await vm.hsvm.loadLeaderboard(myLeaderboardID: "me.jesse.sheehan.MineFind.classicboard")
//                }
//            }
//        }
    }
}


#Preview {
    GameCenterHighScoreListView(vm: FieldViewModel())
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


//    var highScoresExamples: [HighScore] = [
//        HighScore(id: UUID(), name: "Jesse S", score: 3000, date: Date(), gridSize: .big, hintsUsed: 0, duration: 1000, mineCount: 10),
//        HighScore(id: UUID(), name: "Florian R", score: 5000, date: Date(), gridSize: .big, hintsUsed: 0, duration: 1000, mineCount: 10),
//        HighScore(id: UUID(), name: "Jon K", score: 4000, date: Date(), gridSize: .big, hintsUsed: 0, duration: 1000, mineCount: 10),
//        HighScore(id: UUID(), name: "Victoria R", score: 2000, date: Date(), gridSize: .small, hintsUsed: 0, duration: 1000, mineCount: 10),
//        HighScore(id: UUID(), name: "Mel S", score: 8000, date: Date(), gridSize: .big, hintsUsed: 0, duration: 1000, mineCount: 10),
//        HighScore(id: UUID(), name: "Alex Y", score: 3500, date: Date(), gridSize: .small, hintsUsed: 0, duration: 1000, mineCount: 10),
//        HighScore(id: UUID(), name: "Maria E", score: 6000, date: Date(), gridSize: .big, hintsUsed: 0, duration: 1000, mineCount: 10),
//        ]
