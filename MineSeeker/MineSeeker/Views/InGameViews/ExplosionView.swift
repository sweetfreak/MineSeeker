//
//  ExplosionView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/2/25.
//

import SwiftUI
import Vortex

struct ExplosionView: View {

    //@State var vm: FieldViewModel
//    var xCoord: CGFloat
//    var yCoord: CGFloat
    @State var tapThrough = false
    
    var body: some View {
        VortexViewReader { proxy in
            VortexView(createExplosion()) {
                Rectangle()
                   // .fill(.red)
                    .fill(.white)
                    .blur(radius: 3)
                    //.blendMode(.plusLighter)
                    .frame(width: 20, height: 20)
                    .tag("one")

            }
            .onAppear { //location in
                proxy.burst()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                    tapThrough = true
                }
            }
            
//            Button("burst", action: proxy.burst)
        }
        .allowsHitTesting(tapThrough ? false : true)
        //.zIndex(100)
    }
    
    func createExplosion() -> VortexSystem {
        let system = VortexSystem(tags: ["one"])
        //system.position = [0.5, 0.5]//[xCoord, yCoord]
        system.speed = 1
        system.speedVariation = 0.75
        system.lifespan = 2
        system.angleRange = .degrees(360)
        system.size = 0.75
        system.shape = .box(width: 0.5, height: 0.5)
        system.dampingFactor = 5
        system.sizeVariation = 0.75
        system.emissionLimit = 200
        system.emissionDuration = 1.5
        system.burstCount = 200
        system.stretchFactor = 2.0
        system.colors = .random(.red, .orange, .yellow, .gray)
        system.sizeMultiplierAtDeath = 0.001
        

        return system
    }
    
}

//extension

#Preview {
    ExplosionView()//xCoord: 0.5, yCoord: 0.5)
}
