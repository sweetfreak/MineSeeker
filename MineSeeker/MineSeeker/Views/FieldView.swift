//
//  FieldView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/21/25.
//

import SwiftUI
//import Vortex

struct FieldView: View {
   // @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @Namespace private var gameSpace
    
    @State var difficultyPercentage = 15
    
    @State var explosion = false
    
    @State var vm: FieldViewModel
    
        
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Color.clear
                        .frame(width: 350, height: 350)
                    ScrollView(.vertical, showsIndicators: false) {
                        StandardGridView(vm: vm)
                            .allowsHitTesting(vm.gameState == .playing ? true : false)
                            .transition(.asymmetric(
                                insertion: .offset(x: 1000),
                                removal: .offset(x: 1000))
                            )
                            .animation(nil, value: vm.gameState)
                    }
                    .scrollDisabled(true)
                    .frame(width: .infinity, height: vm.gridSize == .big ? .infinity : 350)
                    
                }
                
                if vm.gameState == .playing {
                    StandardGameOptionsView(vm: vm)
                        .transition(.asymmetric(
                            insertion: .opacity,
                            //insertion: .offset(x: 1000),
                            removal: .offset(x: 1000))
                        )
                } else {
                    HStack{
                        NewGameButton(vm: vm)
                        HomeButtonView(vm: vm)
                    }
                    .transition(.asymmetric(
                        insertion: .opacity,
                        //insertion: .offset(x: 1000),

                        removal: .offset(x: 1000))
                    )
                }
                
            }
            .animation(.smooth, value: vm.gameState)
            
            if vm.lostGame {
                ExplosionView()
            }
        }
        .padding()
        
    }
    

}
    
struct StandardGameOptionsView: View {
    //@Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var vm: FieldViewModel
    
    
    var body: some View {
            HStack {
                DraggableItemView(vm: vm, textToDrag: "Flag", onChanged: vm.itemMoved, onEnded: vm.itemDropped)
                DraggableItemView(vm: vm, textToDrag: "Shovel", onChanged: vm.itemMoved, onEnded: vm.itemDropped)
                CheckButtonView(vm: vm)
            }
        
    }
}

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
            .padding()
        }
    }
}

#Preview {
    FieldView(vm: FieldViewModel())
}



//if vm.showExplosion {
//    
//    VortexViewReader { proxy in
//        VortexView(createExplosion()) {
//            Circle()
//                .fill(.red)
//                .frame(width: 20)
//                .blur(radius: 3)
//            //.blendMode(.plusLighter)
//                .tag("one")
//            
//            Circle()
//                .fill(.orange)
//                .frame(width: 30)
//                .blur(radius: 3)
//            //.blendMode(.plusLighter)
//                .tag("two")
//            
//            Circle()
//                .fill(.yellow)
//                .frame(width: 25)
//                .blur(radius: 3)
//                .blendMode(.plusLighter)
//                .tag("three")
//            
//            Circle()
//                .fill(.gray)
//                .frame(width: 20)
//                .blur(radius: 3)
//                .blendMode(.plusLighter)
//                .tag("four")
//        }
//        .onTapGesture { location in
//            //                                print(vm.tapLocation)
//            if vm.showExplosion {
//                proxy.move(to: location)
//                proxy.burst()
//            }
//        }
//    }
//}


//func createExplosion() -> VortexSystem {
//    let system = VortexSystem(tags: ["one", "two", "three", "four"])
//    system.position = [vm.tapLocation.x, vm.tapLocation.y]
//    system.speed = 1
//    system.speedVariation = 0.5
//    system.lifespan = 1
//    system.angleRange = .degrees(360)
//    system.size = 1
//    //system.shape = .box(width: 1, height: 0.05)
//    system.dampingFactor = 8
//    //system.
//    system.sizeVariation = 0.75
//    system.emissionLimit = 100
//    system.burstCount = 100
//
//    return system
//}
