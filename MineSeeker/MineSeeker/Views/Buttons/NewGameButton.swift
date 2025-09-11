//
//  NewGameButton.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/27/25.
//

import SwiftUI

struct NewGameButton: View {
    
    @State var animationAmount = 1.0

    @State var vm: FieldViewModel
    
    var body: some View {
        Button {
            vm.gameScore = 0
            vm.gameStarted = false
            vm.gameTiles.removeAll()
            //vm.gameState = .reloadingGame
            vm.setUpGame()
            
            withAnimation(.spring(duration:0.3, bounce: 0.5)){
                animationAmount += 720
            } completion: {
                vm.gameStarted = true
                vm.gameState = .playing
            }
            
            
        } label: {
            Label("New Game", systemImage: "plus.circle.fill")
                .symbolRenderingMode(.multicolor)
                .symbolEffect(.bounce)
                .symbolEffect(.rotate)
        }
        .buttonStyle(.glassProminent)
        
//        .rotation3DEffect(
//            .degrees(animationAmount),
//            axis: (x: 0, y: 1, z: 0)
//        )
    }
}

#Preview {
    NewGameButton(vm: FieldViewModel())
}
