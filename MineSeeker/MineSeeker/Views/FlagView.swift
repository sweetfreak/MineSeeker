//
//  FlagView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/26/25.
//

import SwiftUI

struct FlagView: View {
    
    @State private var dragAmount = CGSize.zero
    let textToDrag: String = "🚩"
    
    var body: some View {
        ZStack {
//            Rectangle()
//                .fill()
//                .aspectRatio(1.0, contentMode: .fit)
//                .frame(width: 35, height: 35)
//                .cornerRadius(10)
            
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
    FlagView()
}


