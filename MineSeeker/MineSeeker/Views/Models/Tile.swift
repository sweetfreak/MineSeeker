//
//  Tile.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/21/25.
//
import SwiftUI
//import Observation

struct Tile: Identifiable {
    var id = UUID()
    var row: Int
    var column: Int
    var isMine: Bool
    var isRevealed = false
    var surroundingMineCount: Int = 0
    var isFlagged = false
    var gameOver = false
    
    var coordinates: (Int, Int) {
        return (self.row, self.column)
    }
    
//    mutating func assignMine(chance: Int) {
//        if chance <= Int.random(in: 1...100) {
//            isMine = true
//        } else {
//            isMine = false
//        }
//    }
    
    mutating func GameOver() {
        if gameOver {
            isRevealed = true
        }
    }
}


//CLASS version -
//holding onto because if I want this to sync across devices, I'll need SwiftData, which would require classes, not structs

//final class Tile: ObservableObject, Identifiable {
//    var id = UUID()
//    @Published var row: Int
//    @Published var column: Int
//    @Published var isMine: Bool
//    @Published var isRevealed = false
//    @Published var numberOfMinesAdjacent: Int = 0
//    @Published var isFlagged = false
//    @Published var gameOver = false
//    //var chanceOfBecomingMine: Int
//    
//    init(row: Int, column: Int, isMine: Bool, isRevealed: Bool = false, numberOfMinesAdjacent: Int = 0, isFlagged: Bool = false, gameOver: Bool = false) {
//        self.row = row
//        self.column = column
//        self.isMine = isMine
//        self.isRevealed = isRevealed
//        self.numberOfMinesAdjacent = numberOfMinesAdjacent
//        self.isFlagged = isFlagged
//        self.gameOver = gameOver
//    }
//    
//    func assignMine(chance: Int) {
//        if chance <= Int.random(in: 1...100) {
//            isMine = true
//        } else {
//            isMine = false
//        }
//    }
//    
//    func GameOver() {
//        if gameOver {
//            isRevealed = true
//        }
//    }
//}

