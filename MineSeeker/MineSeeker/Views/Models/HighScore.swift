//
//  HighScore.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/6/25.
//

import Foundation


struct HighScore: Identifiable, Codable, Comparable {
    var id = UUID()
    var name: String
    var score: Int
    var date: Date
    //var rank: 

    
    
    static func < (lhs: HighScore, rhs: HighScore) -> Bool {
            lhs.score > rhs.score
        }
    
}
