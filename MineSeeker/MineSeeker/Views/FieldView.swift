//
//  FieldView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/21/25.
//

import SwiftUI

struct FieldView: View {
    
    @State var difficultyPercentage = 20
    @State var gameOver: Bool = false
    @State var gameStarted = false
    @State var explosion = false

    var viewModel = FieldViewModel( )
    
    @State var gameTiles: [Tile] = []
        
    var body: some View {
        VStack {
            if gameStarted == false {
                Button {
                    gameStarted.toggle()
                    gameTiles = viewModel.createTiles()
                    
                } label: {
                    Label("New Game", systemImage: "gauge")
                }
                .padding(30)
            }
            else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 10)), count: 10), spacing: 5) {
                    ForEach(gameTiles) { tile in
                        TileView(tile: tile)
                            
                    }
                }
                
                
            }
        }
        
    }
    
}

#Preview {
    FieldView()
}

