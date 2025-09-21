//
//  HighScoresViewModel.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/8/25.
//

import SwiftUI
import SwiftData

@Observable
class HighScoresViewModel {
//    @Environment(\.modelContext) private var modelContext

    
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
    
    
    
//    func checkHighScores(name: String, gameScore: Int, gridSize: GridSize, hintsUsed: Int, duration: TimeInterval, mineCount: Int) {
//        let newestHighScore = HighScore(id: UUID(), name: name, score: gameScore, date: .now, gridSize: gridSize, hintsUsed: 0, duration: nil, mineCount: mineCount)
//        
//        fetchHighScores(from: modelContext)
//        print("lowest Score: \(getLowestHighScore(using: modelContext))")
//    }
//    
//    
//    @MainActor
//    func saveHighScore(name: String, modelContext: ModelContext, newestScore: HighScore) {
//        
//        modelContext.insert(newestScore)
//        if highScores.count > 10 {
//            fetchHighScores(from: modelContext)
//            let scoresToDelete = highScores.suffix(from: 10)
//            for score in scoresToDelete {
//                modelContext.delete(score)
//            }
//        }
//        
//        
//    }
}

extension Date {
    var shortFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        return formatter.string(from: self)
    }
}
