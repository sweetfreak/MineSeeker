//
//  FieldView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/21/25.
//

import SwiftUI

struct FieldView: View {
   // @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State var difficultyPercentage = 15
    @State var gameOver: Bool = false
    @State var gameStarted = false
    @State var explosion = false
    
    @State var vm: FieldViewModel
        
    var body: some View {
        VStack {
            if vm.gameState != .reloadingGame {
                StandardGridView(vm: vm)
            }
            if vm.gameState == .playing {
                StandardGameOptionsView(vm: vm)
            } else {
                HStack{
                    NewGameButton(vm: vm)
                    HomeButtonView(vm: vm)
                }
            }
        }
    }
}
    
struct StandardGameOptionsView: View {
    //@Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var vm: FieldViewModel
    
    
    var body: some View {
            HStack {
                DraggableItemView(textToDrag: "🚩")
                DraggableItemView(textToDrag: "🪏")
                CheckButtonView(vm: vm)
            }
        
    }
}

struct StandardGridView: View {
    @State var vm: FieldViewModel
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.fixed(42)), count: vm.columnCount), spacing: 1) {
            ForEach(vm.gameTiles.indices, id: \.self) { i in
                TileView(tile: $vm.gameTiles[i], vm: vm)
                
            }
        }
    }
}


#Preview {
    FieldView(vm: FieldViewModel())
}
