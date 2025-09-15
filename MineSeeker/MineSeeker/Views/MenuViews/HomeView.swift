//
//  HomeView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/1/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var vm: FieldViewModel
    private var gridSizeOptions: [GridSize] {
        if UIDevice.isIPhone {
            return [.small, .med, .big]
        } else {
            return [.small, .med, .big, .huge]
        }
    }
    
    var body: some View {
        Text("MineFind")
            .font(.largeTitle)
            .bold()
        
        Spacer()
        Text("Choose a minefield size:")
        Picker("Choose size of minefield", selection: $vm.gridSize) {
            ForEach(gridSizeOptions, id: \.self) { size in
                Text(label(for: size))
                    .tag(size)
            }
        }
        .pickerStyle(.segmented)
        .frame(maxWidth: 275)
        .padding(0)
        
        HStack {
            NewGameButton(vm: vm)
                .padding(5)
            InstructionsButtonView(vm: vm)
        }
        HStack {
            HighScoreListButtonView(vm: vm)
            OptionsButton(vm: vm)
        }
        Spacer()
        
        
    }
    
    private func label(for size: GridSize) -> String {
        switch size {
        case .small: return "Small"
        case .med: return "Medium"
        case .big: return "Big"
        case .huge: return "Huge"
        }
    }
   
}

#Preview {
    HomeView(vm: FieldViewModel())
}
