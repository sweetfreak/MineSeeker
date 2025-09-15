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
                
                OrientationReaderView { newOrientation in
                    orientation.previous = orientation.current
                    orientation.current = newOrientation
                }
                
                ContentView()
                    .environmentObject(orientation)
            }
        }
        .modelContainer(for: HighScore.self)
    }
}

    
