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
    //@State private var droppedText: String = ""
    @State private var isDropTargeted: Bool = false
    @State var vm: FieldViewModel
    @State var gameState: GameState = .playing
    var imageCache: ImageCache = ImageCache()
    // var animationAmount = 180.0
    
    //@State private var cachedBombImg: Image? = nil
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .tileDimensions(fillColor: tile.isMine ? .red : Color(.tileBack))
                .padding(0)

            Rectangle()
                .tileDimensions(fillColor: tile.isRevealed ? Color.clear :Color(vm.gameState == .won && tile.isFlagged ? .green : .tileTop))
                .padding(0)
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
                            vm.gameOver()
                        }
                    }
                }
            
            
            tileContent(tile:tile)
                .padding(0)
                .allowsHitTesting(false)
            

//            if isDropTargeted {
//                Rectangle()
//                    .fill(.blue)
//                    .frame(width: 48, height: 40)
//                //.border(.blue, width: 10)
//                    .cornerRadius(10)
//                
//            }
            
            
//            Image(tile.droppedText)
//                .onLongPressGesture {
//                    if !tile.isRevealed {
//                        tile.droppedText = "Flag"
//                        tile.isFlagged.toggle()
//                    }
//          }
        
        }
        .padding(0)
//        .dropDestination(for: String.self, ) { items, location in
//            // Action to perform when items are dropped
//            if let firstItem = items.first {
//                // Update the text with the dropped item
//                tile.droppedText = firstItem
//                
//                if !tile.isRevealed {
//                    if tile.droppedText == "Flag" {
//                    tile.isFlagged = true
//                    } else if tile.droppedText == "" {
//                        tile.isFlagged = false
//                    }
//                }
//                
//            }
//            return true // Indicate successful drop
//        } isTargeted: { targeted in
//            isDropTargeted = targeted
//        }

    }
    
    func tileContent(tile: Tile) -> some View {
      
            if !tile.isRevealed && tile.isFlagged {
                return AnyView(
                    imageCache.image(named: "Flag")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 40)
                )
            } else if tile.isMine && tile.isRevealed {
                return AnyView(
                    imageCache.image(named: "BombOutline")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 40)
                )
            } else if tile.isRevealed && tile.surroundingMineCount > 0 {
                return AnyView(
                    Text("\(tile.surroundingMineCount)")
                        .font(Font.title.bold())
                    
                )
            } else {
                return AnyView(EmptyView())
                
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

//        } else if tile.surroundingMineCount == 0 {
//            return AnyView(Text(""))
//        } else {
//            return AnyView(
//                Text(String(tile.surroundingMineCount))
//                    .font(Font.title.bold())
//            )
//        }
