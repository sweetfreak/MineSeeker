//
//  FieldView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/21/25.
//

import SwiftUI
import SwiftData
//import Vortex

struct FieldView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var orientation: OrientationModel
    // @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    
    @State var explosion = false
    
    @State var vm: FieldViewModel
    
    
    //TEMP VARS?
    @State var name = ""
    
    
    var body: some View {
//        OrientationReader { isLandscape in
            ZStack {
                VStack {
                    if !orientation.isLandscape {
                        ScoreView(vm: vm)
                    }
                    //ScoreView(vm: vm)
                    
                    
                    //this was so the newGame buttons mostly stay in place
                    //                    Color.clear
                    //                        .frame(width: 350, height: 350)
                    ScrollView(.vertical, showsIndicators: false) {
                        StandardGridView(vm: vm)
                            .allowsHitTesting(vm.gameState == .playing ? true : false)
                            .transition(.asymmetric(
                                insertion: .offset(x: 1000),
                                removal: .offset(x: 1000))
                            )
                            .animation(nil, value: vm.gameState)
                    }
                    .padding(0)
                    .scrollDisabled(true)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: (UIDevice.isIPad || vm.gridSize == .big) ? .infinity : 350)
                    
                    
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
                            }
                        }
                    }
                }
                .animation(.smooth, value: vm.gameState)
                
                if vm.gameState == .lost {
                    ExplosionView(vm: vm)
                    
                }
                
                if vm.gameState == .won {
                    CelebrationView(vm: vm)
                }
            }
            .padding(0)
            
            //ALERTS
            .alert("New High Score!", isPresented: ($vm.newHighScore)) {
                TextField("New High Score!\nEnter your name", text: $name)
                Button("Enter") { saveHighScore(name: name)}
                Button("Cancel", role: .cancel) {}
            } message: {Text("You scored \(vm.gameScore) points!")}
            
            .alert(isPresented: $vm.showGameStatusAlert, content: {
                
                if vm.gameState == .won {
                    Alert(title: Text("You Won"), message: Text("You scored \(vm.gameScore) points!"), dismissButton: .default(Text("OK")))
                } else if vm.gameState == .lost {
                    Alert(title: Text("You Lost"), message: Text("Better luck next time!"), dismissButton: .default(Text("OK")))
                } else  {
                    Alert(title: Text("You haven't flagged every mine yet"), message: Text("Minus 500 points."), dismissButton: .default(Text("OK")))
                }
                    
                })
                .padding()
                .ignoresSafeArea(orientation.isLandscape ? .all : [])
            
//        }
    }
    
    @MainActor
    func saveHighScore(name: String) {
        let newestHighScore = HighScore(id: UUID(), name: name, score: vm.gameScore, date: .now, gridSize: vm.gridSize, hintsUsed: 0, duration: nil, mineCount: vm.mineCount)
        modelContext.insert(newestHighScore)
        if vm.hsvm.highScores.count > 10 {
            vm.hsvm.fetchHighScores(from: modelContext)
            let scoresToDelete = vm.hsvm.highScores.suffix(from: 10)
            for score in scoresToDelete {
                modelContext.delete(score)
            }
        }
        vm.newHighScore = false
        
    }

}

#Preview {
    FieldView(vm: FieldViewModel())
}
