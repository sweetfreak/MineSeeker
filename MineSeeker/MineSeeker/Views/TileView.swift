//
//  TileView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/22/25.
//

import SwiftUI

struct TileView: View {
    
    @State var tile: Tile
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .tileDimensions(fillColor: Color(.tileBack))
            
            Text(tile.isMine ? "💣" : "\(tile.surroundingMineCount)")
                .font(Font.title.bold())
            
            Rectangle()
                .tileDimensions(fillColor: tile.isRevealed ? Color.clear :Color(.tileTop))
                .onTapGesture {
                    tile.isRevealed = true
                    if tile.isMine {
                        tile.gameOver = true
                    }
                }
        }
    }
    
}

extension Rectangle {
    func tileDimensions(fillColor: Color) -> some View {
        self
            .fill(fillColor)
            .aspectRatio(1.0, contentMode: .fit)
            .frame(width: 35, height: 35)
            .cornerRadius(10)
    }
}

#Preview {
    TileView(tile: (Tile(row: 2, column: 2, isMine: false)))
}
