//
//  StandardGridView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/6/25.
//
import SwiftUI

struct StandardGridView: View {
    @State var vm: FieldViewModel
        
    
    var body: some View {
        if vm.gameStarted {
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(42)), count: vm.columnCount), spacing: 1) {
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
