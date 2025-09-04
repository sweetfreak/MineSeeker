//
//  TileView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/22/25.
//

import SwiftUI
//import Vortex

struct TileView: View {
    
    @Binding var tile: Tile
    @State private var droppedText: String = ""
    @State private var isDropTargeted: Bool = false
    @State var vm: FieldViewModel
    @State var gameState: GameState = .playing
    // var animationAmount = 180.0
    
    
    
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .tileDimensions(fillColor: tile.isMine ? .red : Color(.tileBack))
            
            //Text(tile.isMine ? "💣" : "\(tile.surroundingMineCount)")
                
            Text(revealedText(tile:tile))
                .font(Font.title.bold())
            
            Rectangle()
                .tileDimensions(fillColor: tile.isRevealed ? Color.clear :Color(vm.gameState == .won && tile.isFlagged ? .green : .tileTop))
            
//                .rotation3DEffect(
//                    .degrees(animationAmount),
//                    axis: (x: 0, y: 1, z: 0)
//                )
            
            
                .onTapGesture { location in
                
                    if !tile.isRevealed {
                        tile.isRevealed = true
                        tile.isFlagged = false
                        
                        vm.adjacentReveal(tile: self.tile)
                        
                        if tile.isMine {
                          //  vm.tapLocation = location
                          //  vm.showExplosion = true
                            vm.gameOver()
                            //print(String(tile.gameOver))
                        }
                    }
                }
            if isDropTargeted {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 48, height: 40)
                    //.border(.blue, width: 10)
                    .cornerRadius(10)
                
            }
            
            
            Text(tile.isFlagged && vm.gameState != .lost ? "🚩" : "")
            
            

            
        }
        
        .dropDestination(for: String.self, ) { items, location in
            // Action to perform when items are dropped
            if let firstItem = items.first {
                // Update the text with the dropped item
                droppedText = firstItem
                
                if !tile.isRevealed && droppedText == "🚩" {
                    tile.isFlagged = true
                } else {
                    tile.isFlagged = false
                }
                
            }
            return true // Indicate successful drop
        } isTargeted: { targeted in
            isDropTargeted = targeted
        }
        .padding(0)
    }
    
    func revealedText(tile: Tile) -> String {
        
        
        if tile.isMine {
            return "💣"
        } else if tile.surroundingMineCount == 0 {
            return ""
        } else {
            return String(tile.surroundingMineCount)
        }
    }
    

}


extension Rectangle {
    func tileDimensions(fillColor: Color) -> some View {
        self
            .fill(fillColor)
            .aspectRatio(1, contentMode: .fit)
            .frame(width: 44, height: 40)
            .border(.secondary, width: 5)
            .cornerRadius(10)
    }
}

#Preview {
    @Previewable @State var myTile = Tile(row: 0, column: 0, isMine: false, surroundingMineCount: 1)
    @Previewable @State var mineTile = Tile(row: 1, column: 0, isMine: true)
    
    TileView(tile: $myTile, vm: FieldViewModel())
    TileView(tile: $mineTile, vm: FieldViewModel())

}

