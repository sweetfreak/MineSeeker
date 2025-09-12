//
//  StandardGameOptionsView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/6/25.
//

import SwiftUI

struct StandardGameOptionsView: View {
    //@Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var vm: FieldViewModel
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 1) {
            HStack {
                
                DraggableItemView(vm: vm, textToDrag: "Flag", onChanged: vm.itemMoved, onEnded: vm.itemDropped)
                DraggableItemView(vm: vm, textToDrag: "Shovel", onChanged: vm.itemMoved, onEnded: vm.itemDropped)
                CheckButtonView(vm: vm)
            }
            VStack {
                InstructionsButtonView(vm: vm)
            }
            .font(.caption.bold())
                
            
                
        }
            .ignoresSafeArea()

            
        
    }
}
#Preview {
    StandardGameOptionsView(vm: FieldViewModel())
}
