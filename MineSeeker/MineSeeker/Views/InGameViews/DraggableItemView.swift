//
//  FlagView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/26/25.
//

import SwiftUI

enum DragState {
    case canPlaceOnTile
    case cannotPlaceOnTile
    case notOnTile
}

struct DraggableItemView: View {
    @EnvironmentObject var orientation: OrientationModel

    //@State var standardGridView: StandardGridView
    @State var vm: FieldViewModel
    @State private var dragAmount = CGSize.zero
    @State var dragState: DragState = .notOnTile
    var imageToDrag: String
    
    var onChanged: ((CGPoint, String) -> DragState)?
    var onEnded: ((CGPoint, String) -> Void)?
    
    private var shadowColor: Color {
        if dragAmount == .zero {
           return Color.clear
        }
        
        switch dragState {
        case .canPlaceOnTile:
            return Color.green
        case .cannotPlaceOnTile:
            return Color.red
        case .notOnTile:
            return Color.black
        }
    }
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.secondary)
                .frame(width: orientation.isLandscape ? 55 : 70, height: orientation.isLandscape ? 55 : 70)
                .cornerRadius(20)
                
                
            
            Image(imageToDrag)
                .resizable()
                .frame(width: orientation.isLandscape ? 75 : 90, height: orientation.isLandscape ? 75 : 90)
                .offset(dragAmount)
                .zIndex(dragAmount == .zero ? 0 : 1)
                .shadow(color: shadowColor,
                        radius: dragAmount == .zero ? 0 : 10)
                //.
                .gesture(
                    DragGesture(coordinateSpace: .global)
                        .onChanged {
                            //print("Changed draggable")
                            self.dragAmount = CGSize(width: $0.translation.width, height: $0.translation.height)
                            
                            self.dragState = self.onChanged?(
                                $0.location,
                                self.imageToDrag
                            ) ?? .notOnTile
                        }
                        .onEnded{value in
                            if self.dragState == .canPlaceOnTile {
                                self.onEnded?(value.location, self.imageToDrag)
                            }
                            
                            self.dragAmount = .zero
                            self.dragState = .notOnTile
                        }
                )
                .sensoryFeedback(.impact(weight: .medium, intensity: 0.7), trigger: dragState == .canPlaceOnTile)
                .sensoryFeedback(.impact(weight: .heavy, intensity: 1.0), trigger: dragAmount == .zero)
                
        }
        .padding(0)
    }
}


#Preview {
    DraggableItemView(vm: FieldViewModel(), imageToDrag: "Flag")
        .environmentObject({
            let mock = OrientationModel()
            mock.current = .landscapeLeft
            return mock
        }())
}


