//
//  FieldViewModel.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/25/25.
//

import SwiftUI

enum GridSize {
    case small
    case med
    case big
}

enum GameState {
    case home
    case animating
    case playing
    case won
    case lost
    case reloadingGame
    case instructions
    case highScoreList
}

@Observable
final class FieldViewModel {
    
    var chanceOfMine: Int = 15
    
    var gridSize = GridSize.big
    var rowCount = 5
    var columnCount = 5
    
    var gameState = GameState.home
    var gameTiles: [Tile] = []
    var lostGame = false
    var gameStarted = false
    
    var tileFrames: [CGRect] = [] //(repeating: .zero, count: vm.gameTiles.count)
    var framesReady = false
    var shouldMeasureFrames = false
    
    var gameScore = 0
    var newHighScore = false
    
    
    
    //var tapLocation: CGPoint = .zero
    //var showExplosion = false
    
    func createTiles(/*rowCount: Int, columnCount: Int*/) -> [Tile] {
        rowCount = getRowCount(size: gridSize)
        columnCount = getColumnCount(size: gridSize)
        
        tileFrames = Array(repeating: .zero, count: rowCount * columnCount)
        framesReady = false
        
        lostGame = false
        var tiles: [Tile] = []
        // Create the 10x10 tile field
        for row in 0..<rowCount {
            for column in 0..<columnCount {
                tiles.append(Tile(row: row, column: column, isMine: MineRandomizer(percentChance: chanceOfMine)))
            }
        }
        
        // Calculate surrounding mines for each tile
        //tiles.indices is basically like tiles.count, but it's not type specific
        //indices is commonly used when you need to mutate items
        for i in tiles.indices {
            //for each tile...
            let tile = tiles[i]
            //collect it's neighbors...
            let neighbors = neighborCoordinates(tile: tile)
            //take each neighbor...
            let mineCount = neighbors.reduce(0) { count, coord in
                //find a tile (if it exists) that has the same row/column properties as the neighborTile coordinates
                if let neighborTile = tiles.first(where: { $0.row == coord.0 && $0.column == coord.1 }) {
                    //return the current count + 1 if the neighborTile was a mine
                    return count + (neighborTile.isMine ? 1 : 0)
                }
                return count
            }
            
            tiles[i].surroundingMineCount = mineCount
            
        }
        return tiles
    }
    
    func MineRandomizer(percentChance: Int) -> Bool {
        
        if percentChance >= Int.random(in: 0..<100) {
            return true
        } else {
            return false
        }
    }
    
    // Helper to get neighbors' coordinates
    //maybe fold this into get neighbors??
    func neighborCoordinates(tile: Tile) -> [(Int, Int)] {
        let neighbors = [
            (tile.row - 1, tile.column - 1),
            (tile.row - 1, tile.column),
            (tile.row - 1, tile.column + 1),
            (tile.row, tile.column - 1),
            (tile.row, tile.column + 1),
            (tile.row + 1, tile.column - 1),
            (tile.row + 1, tile.column),
            (tile.row + 1, tile.column + 1)
        ]
        
        // Stay in bounds
        //NOTE: apple AI did this, i should learn why/how it works
        //$0.0 is the key and $0.1 is the value. so in other words:
        // filter out: row ($0.0) is more/equal to 0 and less than 10
        //         and column ($0.1) is more/equal to 0 and less than 10
        return neighbors.filter { $0.0 >= 0 && $0.0 < rowCount && $0.1 >= 0 && $0.1 < columnCount }
    }
    
    func gameOver() {
        gameState = .lost
        
        lostGame = true
        for i in self.gameTiles.indices {
            
            gameTiles[i].isRevealed = true
        }
        
    }
    
    func adjacentReveal(tile: Tile) {
        //if tile is revealed and has 0 bombs
        if (tile.surroundingMineCount == 0 && !tile.isMine) {
            //print("LonelyTile's coords: \(tile.coordinates)")
            
            //gather neighboring tiles's coordinates
            let neighbors = neighborCoordinates(tile: tile)
            //print (" Hello neighbors: \(neighbors)")
            
            //for each coordinate
            for neighbor in neighbors {
                //find the gameTile with matching coords
                if let index = self.gameTiles.firstIndex(where: { $0.row == neighbor.0 && $0.column == neighbor.1 }) {
                    //print index and howmany mines they're touching
                    //print("mine count of neighbor \(index): \(gameTiles[index].surroundingMineCount)")
                    
                    //HOW DO I MAKE WORK!?
                    if !self.gameTiles[index].isRevealed {
                        self.gameTiles[index].isRevealed = true
                        gameScore += gameTiles[index].surroundingMineCount * 10
                    } else {
                        continue
                    }
                    
                    //if the tile's mineCount is also 0
                    if self.gameTiles[index].surroundingMineCount == 0 {
                        //do it all again with this tile!
                        adjacentReveal(tile: self.gameTiles[index])
                    }
                }
            }
        }
    }
    
    func checkForMines() {
        var mineTiles: [Tile] = []
        var flaggedTiles: [Tile] = []
        //get tiles
        for myTile in gameTiles {
            if myTile.isMine {
                mineTiles.append(myTile)
            }
            if myTile.isFlagged {
                flaggedTiles.append(myTile)
            }
        }
        
        if mineTiles == flaggedTiles {
            gameScore += 200 * mineTiles.count
            gameState = .won
        } else {
            gameScore -= 500
        }
    }
    
    func getRowCount(size: GridSize) -> Int {
        switch size {
        case .small:
            return 4
        case .med:
            return 7
        case .big:
            return 15
        }
    }
    
    func getColumnCount(size: GridSize) -> Int {
        switch size {
        case .small:
            return 4
        case .med:
            return 7
        case .big:
            return 8
        }
    }
    
    
    func itemMoved(location: CGPoint, textToDrag: String) -> DragState {
        guard let index = tileFrames.firstIndex(where: {
            $0.contains(location) }) else  { return .notOnTile}
        
        let thisTile = gameTiles[index]
        let canPlace: Bool
        
        switch textToDrag {
        case "Flag":
            canPlace = !thisTile.isRevealed
        case "Shovel":
            canPlace = !thisTile.isRevealed && thisTile.isFlagged
        default:
            canPlace = false
        }
        return canPlace ? .canPlaceOnTile : .cannotPlaceOnTile
    }
    
    
    
    func itemDropped(location: CGPoint, textToDrop: String) {
        guard let index = tileFrames.firstIndex(where: { $0.contains(location)}) else {return }
        guard !gameTiles[index].isRevealed else {return }
        
        
        switch textToDrop {
        case "Flag":
            gameTiles[index].isFlagged = true
        case "Shovel":
            gameTiles[index].isFlagged = false
        default:
            break
        }
        
        
        
    }

    
    func setTileFrame(index: Int, frame: CGRect) {
        tileFrames[index] = frame
        if !tileFrames.contains(.zero) {
            framesReady = true
        }
    }
}

//    func refreshTileFrames() {
//        // This will trigger a refresh of all tile frames
//        // You might need to add a @Published property that triggers frame remeasurement
//        frameRefreshTrigger.toggle()
//    }

//print("Drag location: \(location)")
//print("TileFrames count: \(tileFrames.count)")


//        for i in 0..<min(5, tileFrames.count) {
//            print("Frame \(i): \(tileFrames[i])")
//        }
//        let matchingFrames = tileFrames.enumerated().filter { $0.element.contains(location) }
//            print("Frames containing location: \(matchingFrames.map { $0.offset })")

//print("Found match at index: \(match), frame: \(tileFrames[match])")
//print($0)
//print(location)
