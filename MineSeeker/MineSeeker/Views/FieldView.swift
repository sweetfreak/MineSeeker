//
//  FieldView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/21/25.
//

import SwiftUI

struct FieldView: View {
    
    @State var difficultyPercentage = 15
    @State var gameOver: Bool = false
    @State var gameStarted = false
    @State var explosion = false
    
    
    @State var vm: FieldViewModel
    
    
        
    var body: some View {
        
        VStack {
            if vm.gameState != .reloadingGame {
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: vm.columnCount), spacing: 0) {
                    
                    ForEach(vm.gameTiles.indices, id: \.self) { i in
                        TileView(tile: $vm.gameTiles[i], vm: vm)
                        
                    }
                }
            }
            
            if vm.gameState == .playing {
                HStack {
                    FlagView()
                    CheckButtonView(vm: vm)
                }
            } else {
                NewGameButton(vm: vm)
                Button("Home", systemImage: "house.circle.fill") {
                    vm.gameState = .home
                }
            }
            
        }
    }
    
}

#Preview {
    FieldView(vm: FieldViewModel())
}
