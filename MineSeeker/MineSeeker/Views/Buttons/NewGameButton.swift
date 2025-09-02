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
            vm.gameTiles.removeAll()
            //vm.gameState = .reloadingGame
            vm.gameTiles = vm.createTiles()
            
            withAnimation(.spring(duration:1, bounce: 0.5)){
                animationAmount += 720
            } completion: {
                vm.gameState = .playing
                print("animation completed")
            }
            
            
        } label: {
            Label("New Game", systemImage: "plus.diamond.fill")
        }
        .buttonStyle(.borderedProminent)
        .padding()
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0, y: 1, z: 0)
        )
    }
}

#Preview {
    NewGameButton(vm: FieldViewModel())
}
