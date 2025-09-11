//
//  HighScore.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/6/25.
//

import SwiftUI
import SwiftData

@Model
class HighScore {
    var id: UUID
    var name: String
    var score: Int
    var date: Date
    var gridSize: GridSize = GridSize.small
    var hintsUsed: Int = 0
    var duration: TimeInterval? = nil
    var mineCount: Int = 0
    

    
    
    static func < (lhs: HighScore, rhs: HighScore) -> Bool {
            lhs.score > rhs.score
        }
    
    
    init(id: UUID, name: String, score: Int, date: Date, gridSize: GridSize, hintsUsed: Int, duration: TimeInterval?, mineCount: Int) {
        self.id = id
        self.name = name
        self.score = score
        self.date = date
        self.gridSize = gridSize
        self.hintsUsed = hintsUsed
        self.duration = duration
        self.mineCount = mineCount
    }
}
