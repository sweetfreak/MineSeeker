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

                    VStack(alignment: .center) {
                        Text("Objective")
                            .bold()
                        
                        HStack(alignment: .center) {
                            Text("Find all the mines and\nmark each one with a flag.")
                                .multilineTextAlignment(.center)
                        }
                    }
                    .font(.title2)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    Spacer()

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
                            Text("If you tap on a mine tile, it explodes.\n(Which means you lose)")
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
                                Text("Tap the hint button to find out where you might have an issue.")
                                Spacer()
                                Button {} label: {
                                    Label("Hint", systemImage: "lightbulb.fill")
                                        .symbolRenderingMode(.multicolor)
                                        .symbolEffect(.bounce)
                                }
                                .buttonStyle(.glassProminent)
                            }
                            Text("But be careful: tapping on it will cost you points!")
                                .font(.caption2)
                            
                        }
                        
                    }
                    .padding()
                    .border(Color(.secondarySystemBackground), width: 5)
                }
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Points")
                        .bold()
                    
                        Text("• Tapped tiles earn 50 points times the number of mines surrounding it")

                        Text("• Earn 25 points per additional tile revealed")
                    
                        Text("• At end of game, earn 500 points + 200/mine")
                        
                        Text("• Lose points when tapping the \"Hint\" Button")
                }
                .padding()
                .border(Color(.secondarySystemBackground), width: 5)
                
                
                
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
