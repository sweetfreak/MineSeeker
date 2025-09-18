//
//  StandardGameOptionsView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/6/25.
//

import SwiftUI

struct StandardGameOptionsView: View {
    @EnvironmentObject var orientation: OrientationModel

    //@Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var vm: FieldViewModel
    //var isLandscape: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 1) {
            HStack {
                if orientation.isLandscape {
                    ScoreView(vm: vm)
                        .font(Font.caption2)
                }
                DraggableItemView(vm: vm, imageToDrag: "Flag", onChanged: vm.itemMoved, onEnded: vm.itemDropped)
                DraggableItemView(vm: vm, imageToDrag: "Shovel", onChanged: vm.itemMoved, onEnded: vm.itemDropped)
                CheckButtonView(vm: vm)
                if orientation.isLandscape {
                    InstructionsButtonView(vm: vm)
                        .font(.caption.bold())
                }
            }
            if !orientation.isLandscape {
                VStack {
                    InstructionsButtonView(vm: vm)
                }
                .font(.caption.bold())
            }
            
                
        }

            
        
    }
}
#Preview {
    StandardGameOptionsView(vm: FieldViewModel())
}
