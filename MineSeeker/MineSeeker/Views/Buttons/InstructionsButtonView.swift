//
//  InstructionsButtonView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/2/25.
//
import SwiftUI

struct InstructionsButtonView: View {
    @State var vm: FieldViewModel
    
    var body: some View {
        Button {
            vm.gameState = .instructions
        } label: {
            Label("How to Play ", systemImage: "questionmark.text.page.fill")
                .symbolRenderingMode(.multicolor)
                .symbolEffect(.bounce)
        }
        //.buttonStyle(.glassProminent)
        .buttonStyle(.borderedProminent)
    }
}
    
#Preview {
    InstructionsButtonView(vm: FieldViewModel())
}

