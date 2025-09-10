//
//  StandardGridView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/6/25.
//
import SwiftUI

//struct StandardGridView: View {
//    @State var vm: FieldViewModel
//    
//    var body: some View {
//        if vm.gameStarted {
//            GeometryReader { geo in
//                let availableWidth = geo.size.width
//                let tileWidth = availableWidth / CGFloat(vm.columnCount) - 1 // minus spacing
//                let columns = Array(repeating: GridItem(.fixed(tileWidth), spacing: 1), count: vm.columnCount)
//                
//                LazyVGrid(columns: columns, alignment: .center, spacing: 1) {
//                    ForEach(vm.gameTiles.indices, id: \.self) { i in
//                        TileView(tile: $vm.gameTiles[i], vm: vm)
//                            .frame(width: tileWidth, height: tileWidth)
//                            .overlay(GeometryReader { geo in
//                                Color.clear
//                                    .onAppear {
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
//                                            let frame = geo.frame(in: .global)
//                                            vm.tileFrames[i] = frame
//                                        }
//                                    }
//                            })
//                            .overlay(
//                                GeometryReader { geo in
//                                    Color.clear
//                                        .onAppear {
//                                            vm.setTileFrame(index: i, frame: geo.frame(in: .global))
//                                        }
//                                        .onChange(of: geo.size) { _ in
//                                            vm.setTileFrame(index: i, frame: geo.frame(in: .global))
//                                        }
//                                }
//                            )
//                    }
//                }
//                .padding(0)
//            }
//        }
//    }
//}



struct StandardGridView: View {
    @State var vm: FieldViewModel
    var width: Double { UIDevice.isIPhone ? 42.0 : 62.0 }
    
    var body: some View {
        if vm.gameStarted {
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(width)), count: vm.columnCount), alignment: .center, spacing: 1) {
                ForEach(vm.gameTiles.indices, id: \.self) { i in
                    TileView(tile: $vm.gameTiles[i], vm: vm)
                        .overlay(GeometryReader {geo in
                            Color.clear
                                .onAppear {
                                    //REFACTOR EVENTUALLY SO THIS ISN'T HARDCODED TIME BASED
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                                        let frame = geo.frame(in: .global)
                                        //print("Setting frame for tile \(i): \(frame)")
                                        vm.tileFrames[i] = frame
                                    }
                            }
                        })
                }
            }
            .padding(0)
        }
    }
}

#Preview {
    StandardGridView(vm: FieldViewModel())
}
