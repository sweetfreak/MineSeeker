//
//  HighScoresViewModel.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/8/25.
//

import SwiftUI
import SwiftData
import GameKit

@Observable
class HighScoresViewModel {
//    @Environment(\.modelContext) private var modelContext

    //local
     var highScores: [HighScore] = []
    
    //global classic
    var globalClassicScores: [HighScore] = []
    
    //friendsclass
    var friendClassicScores: [HighScore] = []
    
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
        
    
//        @MainActor
//    func loadLeaderboard(myLeaderboardID: String) async {
//        globalClassicScores.removeAll()
//        
//        Task {
//            var scoresListTemp: [HighScore] = []
//            
//            // Load leaderboard by ID
//            let leaderboards = try await GKLeaderboard.loadLeaderboards(IDs: [myLeaderboardID])
//            
//            guard let leaderboard = leaderboards.first(where: { $0.baseLeaderboardID == myLeaderboardID }) else {
//                print("No leaderboard found with ID \(myLeaderboardID)")
//                return
//            }
//            
//            // Load top 50 global scores
//               //(localEntry, entries, totalCount)
//            let (_, entries, _) = try await leaderboard.loadEntries(
//                for: .global,
//                timeScope: .allTime,
//                range: NSRange(1...50)
//            )
//            
//            if !entries.isEmpty {
//            for entry in entries {
//                // GKLeaderboard.Entry has player + score (Int)
//                let image = try await entry.player.loadPhoto(for: .small)
//                
//                scoresListTemp.append(
//                    HighScore(
//                        id: UUID(),
//                        name: entry.player.displayName,
//                        score: Int(entry.score),
//                        date: Date(),
//                        gridSize: .med,
//                        hintsUsed: 0,
//                        duration: nil,
//                        mineCount: 0,
//                        difficulty: 15,
//                        wonGame: true
//                    )
//                )
//            }
//            scoresListTemp.sort()
//        }
//            globalClassicScores = scoresListTemp
//        }
//    }
    
}

extension Date {
    var shortFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        return formatter.string(from: self)
    }
}
