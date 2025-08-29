//
//  FieldViewModel.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/25/25.
//

import SwiftUI


enum GameState {
    case home
    case animating
    case playing
    case won
    case lost
    case reloadGame
}

@Observable
final class FieldViewModel {
    
    var chanceOfMine: Int = 15
    
    var rowCount = 15
    var columnCount = 8
    
   var gameState = GameState.home
    var gameTiles: [Tile] = []
    
    
    init() {
        //just for previews!
        gameTiles = createTiles()
    }
    
    func createTiles(/*put x and y in here to adjust minefield*/) -> [Tile] {
        
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
    
    //
    
    
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
        
        for i in self.gameTiles.indices {
            gameTiles[i].isRevealed = true
        }
        
        
    }
    
//    func revealTile(tile: Tile, gameTiles: [Tile]) {
//      //  tile.isRevealed = true
//        adjacentReveal(gameTiles: gameTiles, tile: tile)
//    }
    
    func adjacentReveal(tile: Tile) {
        //if tile is revealed and has 0 bombs
        if (tile.surroundingMineCount == 0 && !tile.isMine) {
            print("LonelyTile's coords: \(tile.coordinates)")
            
            //gather neighboring tiles's coordinates
            let neighbors = neighborCoordinates(tile: tile)
            print (" Hello neighbors: \(neighbors)")
            
            //for each coordinate
            for neighbor in neighbors {
                //find the gameTile with matching coords
                if let index = self.gameTiles.firstIndex(where: { $0.row == neighbor.0 && $0.column == neighbor.1 }) {
                    //print index and howmany mines they're touching
                    print("mine count of neighbor \(index): \(gameTiles[index].surroundingMineCount)")
                    
                    //HOW DO I MAKE WORK!?
                    if !self.gameTiles[index].isRevealed {
                        self.gameTiles[index].isRevealed = true
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
}

//NOTE FROM ETHAN
//Consider an array of tiles that have been revealed
//Consider creating a "get neighbors" function that can get the coordinates AND/OR the tiles
//there's an algorithm he mentioned that would cycle through each coordinate/tile up to a point but if it had a bomb, it would stop.

//            if let neighborTile = tiles.first(where: { $0.row == coord.0 && $0.column == coord.1 }) {
//                //return the current count + 1 if the neighborTile was a mine
//                return count + (neighborTile.isMine ? 1 : 0)
//            }
            //search across all the tiles, up to a mine
            //track all visited cells
            //
            //if tile == 0, call again - Recursive code?


//    func getNeighbors(tile: Tile) -> [Tile] {
//
//
//        return [tile]
//
//    }
