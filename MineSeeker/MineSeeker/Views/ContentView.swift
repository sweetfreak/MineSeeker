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
        NavigationStack {
            VStack {
                if vm.gameState == .home {
                    NewGameButton(vm: vm)
                } else {
                    FieldView(vm: vm)
                }
            }
            .navigationTitle("MineSeeker")
        }
    }
}

#Preview {
    ContentView()
}
