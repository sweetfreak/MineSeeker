////
////  DraggableTextTest.swift
////  MineSeeker
////
////  Created by Jesse Sheehan on 8/26/25.
////
//
//import SwiftUI
//
//struct DraggableTextView: View {
//    let textToDrag: String
//
//    var body: some View {
//        Text(textToDrag)
//            .padding()
//            .background(Color.blue)
//            .cornerRadius(8)
//            .draggable(textToDrag) // Makes this text draggable
//    }
//}
//
//struct DropTargetView: View {
//    @State private var droppedText: String = ""
//
//    var body: some View {
//        Text(droppedText)
//            .padding()
//            .frame(width: 200, height: 100)
//            .background(Color.gray.opacity(0.3))
//            .cornerRadius(10)
//            .dropDestination(for: String.self) { items, location in
//                // Action to perform when items are dropped
//                if let firstItem = items.first {
//                    droppedText = firstItem // Update the text with the dropped item
//                }
//                return true // Indicate successful drop
//            } isTargeted: { isTargeted in
//                // Optional: Update UI when target is hovered over
//                // e.g., change background color if isTargeted is true
//                
//            }
//    }
//}
//
//
//
//
//#Preview {
//  //  DraggableTextTest()
//}
