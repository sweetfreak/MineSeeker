//
//  OptionsButton.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/11/25.
//

import SwiftUI

struct OptionsButton: View {
    
    var vm: FieldViewModel
    
    
    var body: some View {
        Button {
            vm.gameState = .options
            vm.playSFX("buttonUp1")
        } label: {
            Label("Options", systemImage: "gearshape")
                .symbolRenderingMode(.multicolor)
                .symbolEffect(.rotate)
        }
        //.buttonStyle(.glassProminent)
        .buttonStyle(.borderedProminent)
        .sensoryFeedback(.start, trigger: vm.gameState == .options)

    }
}

#Preview {
    OptionsButton(vm: FieldViewModel())
}
