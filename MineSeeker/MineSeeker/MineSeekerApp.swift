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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: HighScore.self)

    }
}
    