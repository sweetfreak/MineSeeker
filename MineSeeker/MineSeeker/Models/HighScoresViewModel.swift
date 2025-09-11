//
//  HighScoresViewModel.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/8/25.
//

import SwiftUI
import SwiftData

@MainActor
@Observable
class HighScoresViewModel {
    
    
     var highScores: [HighScore] = []
    
    var descriptor = FetchDescriptor<HighScore>(
        sortBy: [SortDescriptor(\.score, order: .reverse)]
    )
    
    func fetchHighScores(from context: ModelContext) {
        do {
            highScores = try context.fetch(descriptor)
        } catch {
            print("Failed to fetch high scores: \(error)")
        }
    }
    
    func getLowestHighScore(using context: ModelContext) -> Int {
            do {
                let scores = try context.fetch(descriptor)
                return scores.last?.score ?? 0
            } catch {
                print("Error fetching scores: \(error)")
                return 0
            }
        }
}

extension Date {
    var shortFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        return formatter.string(from: self)
    }
}
