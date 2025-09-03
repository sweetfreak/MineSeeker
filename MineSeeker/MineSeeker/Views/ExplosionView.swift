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
    
    var body: some View {
        VortexViewReader { proxy in
            VortexView(createExplosion()) {
                Circle()
                    .fill(.red)
                    .frame(width: 20)
                    .blur(radius: 3)
                    //.blendMode(.plusLighter)
                    .tag("one")
                
                Circle()
                    .fill(.orange)
                    .frame(width: 30)
                    .blur(radius: 3)
                    //.blendMode(.plusLighter)
                    .tag("two")
                
                Circle()
                    .fill(.yellow)
                    .frame(width: 25)
                    .blur(radius: 3)
                    .blendMode(.plusLighter)
                    .tag("three")
                
                Circle()
                    .fill(.gray)
                    .frame(width: 20)
                    .blur(radius: 3)
                    .blendMode(.plusLighter)
                    .tag("four")
            }
            .onAppear { //location in
                proxy.burst()
            }
        }
        .allowsHitTesting(false)
        //.zIndex(100)
    }
    
    func createExplosion() -> VortexSystem {
        let system = VortexSystem(tags: ["one", "two", "three", "four"])
        system.position = [0.5, 0.5]//[xCoord, yCoord]
        system.speed = 1
        system.speedVariation = 1
        system.lifespan = 0.75
        system.angleRange = .degrees(360)
        system.size = 0.75
        system.dampingFactor = 7
        system.sizeVariation = 0.75
        system.emissionLimit = 10
        system.emissionDuration = 0.2
        system.burstCount = 100
        system.stretchFactor = 10.0
        

        return system
    }
    
}

//extension

#Preview {
    ExplosionView()//xCoord: 0.5, yCoord: 0.5)
}
