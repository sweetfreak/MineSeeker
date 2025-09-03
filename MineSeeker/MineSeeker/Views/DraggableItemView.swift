//
//  FlagView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/26/25.
//

import SwiftUI

struct DraggableItemView: View {
    
    //@State var vm: FieldViewModel
    @State private var dragAmount = CGSize.zero
    var textToDrag: String
    
    var body: some View {
        ZStack {
            Text(textToDrag)
                .font(.custom("flag", fixedSize: 50))
                
                .draggable(textToDrag)
                
//                            .offset(dragAmount)
//                            .gesture(
//                                DragGesture()
//                                    .onChanged{dragAmount =
//                                    $0.translation }
//                                    .onEnded { _ in
//                                        withAnimation(.bouncy) {
//                                            dragAmount = .zero
//                                        }
//                                }
//                            )
        }
    }
}

#Preview {
    DraggableItemView(textToDrag: "🚩")
}


