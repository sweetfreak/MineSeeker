//
//  ContentView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/21/25.
//

import SwiftUI

struct ContentView: View {
    
    
    
    @State var vm = FieldViewModel()
    
    var body: some View {
        
        VStack {
            
            if vm.gameState == .home || vm.gameState == .reloadingGame {
                HomeView(vm: vm)
                    .padding()
                
                
            } else if vm.gameState == .instructions {
                InstructionsView(vm: vm)
                
            } else {
                FieldView(vm: vm)
                
            }
        }
        
    }
}

#Preview {
    ContentView()
}
