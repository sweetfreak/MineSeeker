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
    
    
    var body: some View {
        VortexViewReader { proxy in
            VortexView(createExplosion()) {
                Circle()
                    .fill(.red)
                    .frame(width: 20)
                    .tag("one")
                
                Circle()
                    .fill(.orange)
                    .frame(width: 30)
                    .tag("two")
                
                Circle()
                    .fill(.yellow)
                    .frame(width: 25)
                    .tag("three")
                
                Circle()
                    .fill(.gray)
                    .frame(width: 20)
                    .tag("four")
            }
            .onAppear {
                proxy.burst()
            }
        }
    }
    
    func createExplosion() -> VortexSystem {
        let system = VortexSystem(tags: ["one", "two", "three", "four"])
        system.position = [0.5, 0.5]
        system.speed = 1
        system.speedVariation = 0.25
        system.lifespan = 0.2
        system.angleRange = .degrees(360)
        system.size = 1
        system.sizeVariation = 0.75
        system.emissionLimit = 100
        system.burstCount = 50
        //system.
        
        
        return system
    }
    
}

#Preview {
    ExplosionView()
}
