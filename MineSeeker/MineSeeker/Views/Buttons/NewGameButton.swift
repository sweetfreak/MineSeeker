//
//  NewGameButton.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/27/25.
//

import SwiftUI

struct NewGameButton: View {
    @EnvironmentObject var orientation: OrientationModel

    
    //@State var animationAmount = 1.0

    @State var vm: FieldViewModel
    
    var body: some View {
        Button {
            //vm.gameState = .reloadingGame
            //vm.gameScore = 0
            //vm.gameStarted = false
            //vm.gameTiles.removeAll()
            
            vm.setUpGame(isLandscape: orientation.isLandscape)
            
//            withAnimation(.spring(duration:0.3, bounce: 0.5)){
//             //   animationAmount += 720
//            } completion: {
//                vm.gameStarted = true
//                vm.gameState = .playing
//            }
            vm.playSFX("buttonUp1")
            
        } label: {
            Label("New Game", systemImage: "plus.circle.fill")
                .symbolRenderingMode(.multicolor)
                .symbolEffect(.bounce)
                .symbolEffect(.rotate)
        }
        //.buttonStyle(.glassProminent)
        .buttonStyle(.borderedProminent)
        .sensoryFeedback(.success, trigger: vm.gameState == .playing)

//        .rotation3DEffect(
//            .degrees(animationAmount),
//            axis: (x: 0, y: 1, z: 0)
//        )
    }
}

#Preview {
    NewGameButton(vm: FieldViewModel())
}
