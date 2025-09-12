//
//  InstructionsView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/2/25.
//

import SwiftUI

struct InstructionsView: View {
    @State private var demoTileBomb = Tile(row: 1, column: 1, isMine: true, isRevealed: true)
    @State private var demoTileFlag = Tile(row: 1, column: 1, isMine: true, isRevealed: false, isFlagged: true)
    @State private var demoTileReveal = Tile(row: 1, column: 1, isMine: false, )
    
    @State var vm: FieldViewModel
    
    var body: some View {
        LazyVStack{
            Text("How to play MineFinder")
                .font(.largeTitle)
                .padding(10)
            
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Objective:")
                        .bold()
                    HStack{
                        Text("Use flags to mark each tile that contains a mine.")
                        //                        Spacer()
                        //                        TileView(tile: $demoTileBomb, vm: vm)
                    }
                }
                
            }
            .padding(5)
            
            
            
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Directions:")
                        .bold()
                    HStack {
                        Text("If you tap on a tile that has a mine, you lose.")
                        Spacer()
                        TileView(tile: $demoTileBomb, vm: vm)
                            .font(.title)
                    }
                    
                    HStack {
                        Text("Tap to reveal a tile.")
                        Spacer()
                        TileView(tile: $demoTileReveal, vm: vm)
                            .font(.title)
                    }
                    
                    HStack {
                        
                        Text("To flag a mine, hold and drag the flag over to the tile.")
                        Spacer()
                        ZStack {
                            Circle()
                                .fill(Color("tileBack"))
                                .frame(width: 40, height: 40)
                            
                            Image("Flag")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        //TileView(tile: $demoTileFlag, vm: vm)
                        
                    }
                    
                    HStack {
                        Text("To remove move a flag from a tile, hold the shovel and drag it to the flag.")
                        Spacer()
                        ZStack {
                            Circle()
                                .fill(Color("tileBack"))
                                .frame(width: 40, height: 40)
                            Image("Shovel")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
                }
            }
            .padding()
            
            if vm.gameStarted {
                Button{
                vm.gameState = .playing
            } label: {
                Label("Back", systemImage: "arrow.left")
            }
                
            } else {
                HomeButtonView(vm: vm)
            }
        }
        
    }
}

#Preview {
    InstructionsView(vm: FieldViewModel())
}
