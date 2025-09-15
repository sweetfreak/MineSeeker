//
//  HighScoreView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/6/25.
//

import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var orientation: OrientationModel
    
    @State var vm: FieldViewModel
    
    var body: some View {
        
        HStack {
            Text("SCORE:")
                .bold()
            
            
            //Text("100000")
            Text("\(vm.gameScore)")
                
                .foregroundStyle(vm.newHighScore ? .green : .primary)
            
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 15)
        .background(.blue)
        .cornerRadius(20)
        .font(orientation.isLandscape ? Font.title : Font.largeTitle)
    }
}

#Preview {
    
    @Previewable @State var myVm = FieldViewModel()
    //@Previewable @State myVm.gameScore = 100
    
    ScoreView(vm: myVm)
}
