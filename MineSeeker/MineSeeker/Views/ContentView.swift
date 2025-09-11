//
//  ContentView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/21/25.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @State private var musicFile: AVAudioPlayer?
    
    
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
        .animation(.smooth, value: vm.gameState)
        .onAppear {
            if vm.music {
                if let url = Bundle.main.url(forResource: "InbetweenLoop", withExtension: "mp3") {
                    do {
                        try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
                        try AVAudioSession.sharedInstance().setActive(true, options: [])
                        musicFile = try AVAudioPlayer(contentsOf: url)
                        musicFile?.numberOfLoops = -1
                        musicFile?.prepareToPlay()
                        musicFile?.play()
                    } catch {
                        print("[ContentView] Failed to play sound: \(error)")
                    }
                } else {
                    print("[Content] Missing resource InbetweenLoop.mp3")
                }
            }
        }
        .onChange(of: vm.music) {
            if vm.music {
                musicFile?.play()
            } else {
                musicFile?.stop()
            }
        }
    }
}

#Preview {
    ContentView()
}
