//
//  CelebrationView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/8/25.
//

import SwiftUI
import Vortex

struct CelebrationView: View {
    var body: some View {
        //VortexViewReader { proxy in
            VortexView(createFallingConfetti()) {
                Rectangle()
                    .fill(.white)
                    .frame(width: 20)
                    .tag("circle")
                    .frame(width: 10, height: 10)
            }
//            .onAppear { //location in
//                proxy.burst()
//            }
            
            //Button("Burst", action: proxy.burst)
      //  }
        .allowsHitTesting(false)
        
    }
    
    func createFallingConfetti() -> VortexSystem {
        let system = VortexSystem(tags: ["circle"])
        system.position = [0.5, 0]
        system.speed = 0.5
        system.speedVariation = 0.5
        system.lifespan = 3
        system.birthRate = 200
        system.shape = .box(width: 1, height: 1)
        system.burstCount = 100
        system.acceleration = [0, 1]
        system.angle = .degrees(180)
        system.angleRange = .degrees(20)
        system.angularSpeedVariation = [4, 4, 4]
        system.colors = .random(.white, .red, .green, .blue, .pink, .orange, .cyan)
        system.size = 0.5
        system.sizeVariation = 0.5

        return system
    }
}

#Preview {
    CelebrationView()
}
