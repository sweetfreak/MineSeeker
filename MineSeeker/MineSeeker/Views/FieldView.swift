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
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: vm.columnCount), spacing: 0) {
                ForEach(vm.gameTiles.indices) { i in
                    TileView(tile: $vm.gameTiles[i], vm: vm)
                }
            }
            FlagView()
            if vm.gameState == .lost {
                NewGameButton(vm: vm)
            }
            
        }
    }
    
}

#Preview {
    FieldView(vm: FieldViewModel())
}

