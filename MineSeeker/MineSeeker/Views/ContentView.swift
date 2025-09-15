//
//  ContentView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/21/25.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var orientation: OrientationModel
    
    @State var vm = FieldViewModel()
    
    var body: some View {
            VStack {
                
                if vm.gameState == .home || vm.gameState == .reloadingGame {
                    HomeView(vm: vm)
                        .padding(.top, 20)
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
                    
                } else if vm.gameState == .options {
                    OptionsView(vm: vm)
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
            .onChange(of: orientation.current) {_, newOrientation in
                vm.handleOrientationChange(from: orientation.previous, to: newOrientation)
                orientation.previous = newOrientation

            }
            .animation(.smooth, value: vm.gameState)
        
    }
}

#Preview {
    ContentView()
}
