//
//  FieldView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/21/25.
//

import SwiftUI
import SwiftData
import Combine
//import Vortex

struct FieldView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var orientation: OrientationModel
    // @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @AppStorage("playerName") private var playerName: String = ""
    
    @State var explosion = false
    
    @State var vm: FieldViewModel
    
    let textLimit = 20
    
    
    var body: some View {
        ZStack {
            VStack {
                Spacer().frame(height: spacerHeight(isLandscape: orientation.isLandscape, gridSize: vm.gridSize))
                
                if !orientation.isLandscape {
                    ScoreView(vm: vm)
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    StandardGridView(vm: vm)
                        .allowsHitTesting(vm.gameState == .playing ? true : false)
                        .transition(.asymmetric(
                            insertion: .offset(x: 1000),
                            removal: .offset(x: 1000))
                        )
                    
                    //this .anim makes bombs appear automatically instead of fade in
                        .animation(nil, value: vm.gameState)
                }
                .padding()
                .scrollDisabled(true)
                
                HStack {
                    VStack {
                        if vm.gameState == .playing {
                            StandardGameOptionsView(vm: vm)
                                .transition(.asymmetric(
                                    insertion: .opacity,
                                    //insertion: .offset(x: 1000),
                                    removal: .offset(x: 1000))
                                            
                                )
                            
                            
                        } else {
                            HStack{
                                if orientation.isLandscape {
                                    ScoreView(vm: vm)
                                    //.font(Font.title2)
                                }
                                NewGameButton(vm: vm)
                                HomeButtonView(vm: vm)
                            }
                            .transition(.asymmetric(
                                insertion: .opacity,
                                removal: .offset(x: 1000))
                            )
                            .padding()
                        }
                    }
                }
                if vm.gridSize != .big {
                    Spacer().frame(height: UIDevice.isIPhone && orientation.isLandscape ? 20 : 30)
                }
            }
            .animation(.smooth, value: vm.gameState)
            
            if vm.gameState == .lost {ExplosionView(vm: vm)}
            if vm.gameState == .won {
                CelebrationView(vm: vm)
                    .onAppear {
                        checkForHighScore()
                    }
            }
        }
        .padding(0)
        .ignoresSafeArea(UIDevice.isIPhone && vm.gridSize != .small && orientation.isLandscape ? [.all] : [])
        
        
        
        
        //ALERTS
        .alert("New High Score!", isPresented: ($vm.newHighScore)) {
            TextField("New High Score!\nEnter your name", text: $playerName)
                .onReceive(Just(playerName)) { _ in limitText(textLimit) }
            
            
            Button("Enter") { saveHighScore(name: playerName)}
            Button("Cancel", role: .cancel) {}
        } message: {Text("You scored \(vm.gameScore) points!")}
        
            .alert(isPresented: $vm.showGameStatusAlert, content: {
                
                if vm.gameState == .won {
                    Alert(title: Text("You Won"), message: Text("You scored \(vm.gameScore) points!"), dismissButton: .default(Text("OK")))
                } else if vm.gameState == .lost {
                    Alert(title: Text("You Lost"), message: Text("Better luck next time!"), dismissButton: .default(Text("OK")))
                } else  {
                    Alert(title: vm.checkedTooSoonText, message: Text(vm.minusPointsText), dismissButton: .default(Text("OK")))
                }
                
            })
    }


    func spacerHeight(isLandscape: Bool, gridSize: GridSize) -> CGFloat {
        let deviceType: String = UIDevice.isIPad ? "iPad" : "iPhone"
        
        switch (deviceType, gridSize, isLandscape) {
            
        // iPad cases
        case ("iPad", .small, true):
            return 200
        case ("iPad", .small, false):
            return 325
        case ("iPad", .med, true):
            return 100
        case ("iPad", .med, false):
            return 200
        case ("iPad", .big, _):
            return 100

        case ("iPad", .huge, _):
            return 20   // same regardless of orientation
        
        // iPhone cases
        case ("iPhone", .small, true):
            return 50
        case ("iPhone", .small, false):
            return 250
        case ("iPhone", .med, true):
            return 10
        case ("iPhone", .med, false):
            return 180
        case ("iPhone", .big, _):
            return 0
//        case ("iPhone", .big, false):
//            return 0
        
        // fallback
        default:
            return 30
        }
    }
    
    func checkForHighScore() {
        vm.hsvm.fetchHighScores(from: modelContext)
        
        print("lowest Score: \(vm.hsvm.getLowestHighScore(using: modelContext))")
        
        if vm.gameScore > vm.hsvm.getLowestHighScore(using: modelContext) || vm.hsvm.highScores.count < 20  {
            vm.newHighScore = true
        } else {
            vm.showGameStatusAlert = true
        }
    }
    
    @MainActor
    func saveHighScore(name: String) {
        let newestHighScore = HighScore(
            id: UUID(),
            name: name,
            score: vm.gameScore,
            date: .now,
            gridSize: vm.gridSize,
            hintsUsed: vm.hintsUsed,
            duration: nil,
            mineCount: vm.mineCount
        )
        modelContext.insert(newestHighScore)
        if vm.hsvm.highScores.count > 10 {
            vm.hsvm.fetchHighScores(from: modelContext)
            let scoresToDelete = vm.hsvm.highScores.suffix(from: 10)
            for score in scoresToDelete {
                modelContext.delete(score)
            }
        }
    }
    
    func limitText(_ upper: Int) {
            if playerName.count > upper {
                playerName = String(playerName.prefix(upper))
            }
        }
}

#Preview {
    FieldView(vm: FieldViewModel())
        .environmentObject({
            let mock = OrientationModel()
            mock.current = .portrait
            return mock
        }())
}
