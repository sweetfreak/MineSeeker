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
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.smooth),
                        removal: .offset(x: 1000))
                    )
                
                
            } else if vm.gameState == .instructions {
                InstructionsView(vm: vm)
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.smooth),
                        removal: .offset(x: 1000))
                    )
                
            } else if vm.gameState == .highScoreList {
                HighScoreListView(vm: vm)
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.smooth),
                        removal: .offset(x: 1000))
                    )
                 
            } else {
                FieldView(vm: vm)
                    .transition(.asymmetric(
                        insertion: .offset(x: -1000),
                        removal: .offset(x: 1000))
                    )
                    .ignoresSafeArea(.all, edges: .bottom)
                
            }
            
        }
        .animation(.smooth, value: vm.gameState)

        
    }
}

#Preview {
    ContentView()
}
