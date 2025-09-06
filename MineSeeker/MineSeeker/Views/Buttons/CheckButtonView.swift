//
//  CheckButtonView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/1/25.
//

import SwiftUI

struct CheckButtonView: View {
    
    @State var vm = FieldViewModel()
    
    var body: some View {
        
        Button {
            if vm.gameState == .playing {
                vm.checkForMines()
            }
        } label: {
            Text("Check ✅")
        }
        .buttonStyle(.borderedProminent)
        
    }
}

#Preview {
    CheckButtonView()
}
