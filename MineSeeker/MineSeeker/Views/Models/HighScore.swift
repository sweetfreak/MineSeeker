//
//  HighScore.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/6/25.
//

import Foundation
import SwiftData

@Model
class HighScore {
    var id: UUID
    var name: String
    var score: Int
    var date: Date
    //var rank:
    
    
    static func < (lhs: HighScore, rhs: HighScore) -> Bool {
            lhs.score > rhs.score
        }
    
    
    init(id: UUID, name: String, score: Int, date: Date) {
        self.id = id
        self.name = name
        self.score = score
        self.date = date
    }
}
