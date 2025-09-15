//
//  CheckButtonView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/1/25.
//

import SwiftUI

struct CheckButtonView: View {
    
    @State var vm: FieldViewModel
    @Environment(\.modelContext) private var modelContext

    //@State var showCheckAlert = false
    
    var body: some View {
        
        Button {
            if vm.gameState == .playing {
                vm.checkForMines()
                if vm.gameState == .won {
                    
                    vm.hsvm.fetchHighScores(from: modelContext)
                    
                    print("lowest Score: \(vm.hsvm.getLowestHighScore(using: modelContext))")
                    
                    if vm.hsvm.highScores.count <= 10 || vm.gameScore > vm.hsvm.getLowestHighScore(using: modelContext) {
                        vm.newHighScore = true
                    } else {
                        vm.showGameStatusAlert = true
                    }
                }
                
            }
        } label: {
            Label("Check", systemImage: "checkmark.circle.fill")
            //.symbolRenderingMode()
                .symbolEffect(.bounce)
        }
        //.buttonStyle(.glassProminent)
        .buttonStyle(.borderedProminent)
        //.disabled(vm.gameScore <= 0 ? true : false)
        .sensoryFeedback(.error, trigger: vm.showGameStatusAlert)

    }

}

#Preview {
    CheckButtonView(vm: FieldViewModel())
}
