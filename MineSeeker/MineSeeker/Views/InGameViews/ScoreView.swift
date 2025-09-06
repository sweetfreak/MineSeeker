//
//  HighScoreView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/6/25.
//

import SwiftUI

struct ScoreView: View {
    
    @State var vm: FieldViewModel
    
    var body: some View {
        
        HStack {
            Text("SCORE:")
                .font(Font.largeTitle.bold())
            
            
            //Text("100000")
            Text("\(vm.gameScore)")
                .font(Font.largeTitle)
                .foregroundStyle(vm.newHighScore ? .green : .primary)
            
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 15)
        .background(.blue)
        .cornerRadius(20)
    }
}

#Preview {
    
    @Previewable @State var myVm = FieldViewModel()
    //@Previewable @State myVm.gameScore = 100
    
    ScoreView(vm: myVm)
}
