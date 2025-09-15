//
//  HighScoreListButtonView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/6/25.
//

import SwiftUI

struct HighScoreListButtonView: View {
    
    
    @State var vm: FieldViewModel
    
    var body: some View {
        Button {
            vm.gameState = .highScoreList
            vm.playSFX("buttonUp1")
        } label: {
            Label("High Scores", systemImage: "list.number")
                .symbolRenderingMode(.multicolor)
                .symbolEffect(.bounce)
        }
        //.buttonStyle(.glassProminent)
        .buttonStyle(.borderedProminent)
        .sensoryFeedback(.success, trigger: vm.gameState == .highScoreList)

    }
}



#Preview {
    HighScoreListButtonView(vm: FieldViewModel())
}
