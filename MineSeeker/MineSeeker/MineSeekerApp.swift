//
//  MineSeekerApp.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/21/25.
//

import SwiftUI
import SwiftData

@main
struct MineSeekerApp: App {
    
    @StateObject var orientation = OrientationModel()
    
    var body: some Scene {
            WindowGroup {
                ZStack {
                    // Orientation Reader updates the model
                    OrientationReaderView { isLandscape in
                        orientation.isLandscape = isLandscape
                    }
                    
                    ContentView()
                        .environmentObject(orientation)
                }
            }
            .modelContainer(for: HighScore.self)
        }
    
//    var body: some Scene {
//        WindowGroup {
//            OrientationReader { isLandscape in
//                ContentView()
//                    .environmentObject(orientation)
//                    .onChange(of:isLandscape) {_, newValue in
//                        orientation.isLandscape = newValue
//                    }
//            }
//        }
//        .modelContainer(for: HighScore.self)
//
//    }
}
    
