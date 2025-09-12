//
//  HomeButtonView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/2/25.
//

import SwiftUI

struct HomeButtonView: View {
    
    @State var vm: FieldViewModel
    
    var body: some View {
        
        Button("Home", systemImage: "house.circle.fill") {
            vm.gameState = .home
        }
        //.buttonStyle(.glassProminent)
        .buttonStyle(.borderedProminent)
        .symbolRenderingMode(.multicolor)
        .symbolEffect(.bounce)
        
        
    }
}

#Preview {
    HomeButtonView(vm: FieldViewModel())
}
