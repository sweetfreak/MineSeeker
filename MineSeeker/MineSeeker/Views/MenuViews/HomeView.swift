//
//  HomeView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/1/25.
//

import SwiftUI

struct HomeView: View {
    
    
    //REORIENT FOR iPHONE LANDSCAPE
    
    @EnvironmentObject var orientation: OrientationModel
    
    
    @State var vm: FieldViewModel
    private var gridSizeOptions: [GridSize] {
        if UIDevice.isIPhone {
            return [.small, .med, .big]
        } else {
            return [.small, .med, .big, .huge]
        }
    }
    
     let chanceOptions = [5, 14, 25]
    
    
    var body: some View {
        Spacer()
        
        HStack {
            Text("MineFind")
                .font(.largeTitle)
                .bold()
            
            
            if orientation.isLandscape {
                DraggableItemView(vm: vm, imageToDrag: "Flag")
            }
            
        }
        .padding(0)
        
        if !orientation.isLandscape {
            DraggableItemView(vm: vm, imageToDrag: "Flag")
                .padding(0)
        }
        
        
        Spacer()

        
        Text("Choose a minefield size:")
        Picker("Choose size of minefield", selection: $vm.gridSize) {
            ForEach(gridSizeOptions, id: \.self) { size in
                Text(vm.sizeLabel(for: size))
                    .tag(size)
            }
        }
        .pickerStyle(.segmented)
        .frame(maxWidth: 275)
        .padding(.bottom, 10)
        
        Text("Choose a difficulty:")
        Picker("Choose a percentage of Mines", selection: $vm.chanceOfMine) {
            ForEach(chanceOptions, id: \.self) { chance in
                Text(vm.difficultyLabel(for: chance))
            }
        }
        .pickerStyle(.segmented)
        .frame(maxWidth: 350)
        VStack{
            HStack {
                NewGameButton(vm: vm)
                InstructionsButtonView(vm: vm)
            }
            HStack {
                HighScoreListButtonView(vm: vm)
                OptionsButton(vm: vm)
            }
            if !vm.gameTiles.isEmpty && !vm.gameIsOver {
                Button("Resume Game") {
                    //vm.returnToGame(isLandscape: orientation.isLandscape)
                    vm.gameStarted = true
                    vm.gameState = .playing

                }
            }
        }
        .padding(10)
        
        Spacer()
        
        
    }
}

#Preview {
    HomeView(vm: FieldViewModel())
        .environmentObject({
            let mock = OrientationModel()
            mock.current = .landscapeLeft
            return mock
        }())
}
