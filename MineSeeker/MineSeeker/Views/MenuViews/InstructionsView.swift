//
//  InstructionsView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/2/25.
//

import SwiftUI

struct InstructionsView: View {
    @EnvironmentObject var orientation: OrientationModel
    @State var vm: FieldViewModel
    
    @State private var demoTileBomb = Tile(row: 1, column: 1, isMine: true, isRevealed: true)
    @State private var demoTileReveal = Tile(row: 1, column: 1, isMine: false, surroundingMineCount: 1)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack{
                Text("How to play MineFinder")
                    .font(.largeTitle)
                    .padding(10)
                
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Objective")
                            .bold()
                        HStack{
                            Text("Find all the mines and mark each one with a flag.")
                        }
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                .scrollDisabled(orientation.isLandscape ? false : true)

                
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Directions")
                            .bold()
                        
                        HStack {
                            Text("Tap on a tile to reveal what's underneath. The revealed number indicates how many surrounding tiles are mines.")
                            Spacer()
                            TileView(tile: $demoTileReveal, vm: vm)
                                .font(.title)
                        }
                        Divider()
                        
                        HStack {
                            Text("If you tap on a mine tile, it explodes.\n(Which is bad)")
                            Spacer()
                            TileView(tile: $demoTileBomb, vm: vm)
                                .font(.title)
                        }
                        Divider()
                        
                        HStack {
                            Text("Mark each mine by dragging a flag over to the tile.")
                            Spacer()
                            ZStack {
                                Circle()
                                    .fill(Color("tileBack"))
                                    .frame(width: 40, height: 40)
                                
                                Image("Flag")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        Divider()
                        
                        HStack {
                            Text("To remove a flag from a tile, drag and drop the shovel over the flag.")
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
                        
                        Divider()
                        VStack(alignment: .leading){
                            HStack {
                                Text("Tap the check button if you think you've flagged all the mines. ")
                                Spacer()
                                Button {} label: {
                                    Label("Check", systemImage: "checkmark.circle.fill")
                                    
                                        .symbolEffect(.bounce)
                                }
                                //.buttonStyle(.glassProminent)
                                .buttonStyle(.borderedProminent)
                            }
                            Text("Incorrect flag placement will deduct 500 points")
                                .font(.caption2)
                            
                        }
                        
                    }
                }
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Points")
                        .bold()
                    
                        Text("• 50+ points times number on the tapped tile")

                        Text("• 25+ points per additional tile revealed")
                    
                        Text("• 500+ points + 200 per mine at end of game.")
                        
                        Text("• Lose points when checking for mines too early")
                }
                .padding()
                .border(Color(.secondarySystemBackground), width: 5)
                
                Divider()
                
                
                if vm.gameStarted {
                    Button{
                        vm.gameState = .playing
                        vm.playSFX("buttondown1")
                    } label: {
                        Label("Back", systemImage: "arrow.left")
                    }
                    .padding()
                    
                } else {
                    HomeButtonView(vm: vm)
                        .padding()
                }
            }
            .padding(10)
        }
    }
}

#Preview {
    InstructionsView(vm: FieldViewModel())
        .environmentObject({
            let mock = OrientationModel()
            mock.current = .landscapeLeft
            return mock
        }())
}
