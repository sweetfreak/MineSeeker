//
//  TileView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/22/25.
//

import SwiftUI
//import Vortex

struct TileView: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    //var isLandscape: Bool { verticalSizeClass == .compact }
    
    @Binding var tile: Tile
    //@State private var droppedText: String = ""
    //@State private var isDropTargeted: Bool = false
    @State var vm: FieldViewModel
    @State var gameState: GameState = .playing
    var imageCache: ImageCache = ImageCache()

    var onPhoneW: Double {vm.iPhoneWidth}
    var onPhoneH: Double {vm.iPhoneWidth * 0.8}
    var onPadW: Double {vm.iPadWidth}
    var onPadH: Double {vm.iPadWidth * 0.8}
    var width: Double { UIDevice.isIPhone ? onPhoneW : onPadW }
    var height: Double { UIDevice.isIPhone ? onPhoneH : onPadH }
    
    var animationAmount = 0.0
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .tileDimensions(fillColor: tile.isMine && tile.isRevealed ? .red : Color(.tileBack), width: width, height: height)
                .cornerRadius(10)
            

            Rectangle()
                .tileDimensions(fillColor: tile.isRevealed ? Color.clear :Color(vm.gameState == .won && tile.isFlagged ? .green : .tileTop), width: width, height: height)
            
                    
            
                .onTapGesture {
                    if vm.isFirstTile {
                        vm.isFirstTile = false
                        if tile.isMine {
                            tile.isMine.toggle()
                            print("this was a mine!")
                            vm.recountSurroundingMines(gameTiles: vm.gameTiles)
                        }
                    }
                    
                    
                    if !tile.isRevealed {
                        tile.isRevealed = true
                        tile.isFlagged = false
                        vm.adjacentReveal(tile: self.tile)
                        vm.gameScore += tile.surroundingMineCount * 50
                        
                        if tile.isMine {
                            vm.gameOver()
                        }
                    }
                }
            
            
            
            tileContent(tile:tile)
                
                .allowsHitTesting(false)
        }
        .frame(width: width, height: height)

        
    }
    
    func tileContent(tile: Tile) -> some View {
            if !tile.isRevealed && tile.isFlagged {
                return AnyView(
                    imageCache.image(named: "Flag")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width, height: height)
                        .padding(0)
                    

                )
            } else if tile.isMine && tile.isRevealed {
                return AnyView(
                    imageCache.image(named: "BombOutline")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width, height: height)
                        .padding(0)
                    
                    
                )
            } else if tile.isRevealed && tile.surroundingMineCount > 0 {
                return AnyView(
                    Text("\(tile.surroundingMineCount)")
                        .font(Font.title2.bold())
                        .frame(width: width, height: height)
                    
                )
            } else {
                return AnyView(EmptyView()
                )
            }
        
    }
}


extension Rectangle {
    func tileDimensions(fillColor: Color, width: Double, height: Double) -> some View {
        let radius: CGFloat = 10
            return self
            .fill(fillColor)
            .frame(width: width, height: height)
            .cornerRadius(radius)
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .strokeBorder(.secondary, lineWidth: 3)
                    //.strokeBorder(.black, lineWidth: )
            )
            .aspectRatio(1, contentMode: .fit)

    }
}

#Preview {
    
//    @Previewable @State var myTile = Tile(row: 1, column: 1, isMine: false, surroundingMineCount: 1)
//    @Previewable @State var mineTile = Tile(row: 2, column: 1, isMine: true)
//    
//    TileView(tile: $myTile, vm: FieldViewModel())
//    TileView(tile: $mineTile, vm: FieldViewModel())
    
    FieldView(vm:FieldViewModel())
        .environmentObject({
            let mock = OrientationModel()
            mock.current = .landscapeLeft
            return mock
        }())
}

//        } else if tile.surroundingMineCount == 0 {
//            return AnyView(Text(""))
//        } else {
//            return AnyView(
//                Text(String(tile.surroundingMineCount))
//                    .font(Font.title.bold())
//            )
//        }

