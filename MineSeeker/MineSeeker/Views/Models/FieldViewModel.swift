//
//  FieldViewModel.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/25/25.
//

import SwiftUI
//import Observation

final class FieldViewModel {
    
    
        
    var chanceOfMine: Int = 25
    
    func createTiles(/*put x and y in here to adjust minefield*/) -> [Tile] {
        
        var tiles: [Tile] = []
        // Create the 10x10 tile field
        for row in 0..<10 {
            for column in 0..<10 {
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
            let neighbors = neighborCoordinates(for: tile)
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
    func neighborCoordinates(for tile: Tile) -> [(Int, Int)] {
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
        return neighbors.filter { $0.0 >= 0 && $0.0 < 10 && $0.1 >= 0 && $0.1 < 10 }
    }
    
    func adjacentReveal(tile: Tile) {
        //if tile is revealed and has 0 bombs
        if (tile.isRevealed && tile.surroundingMineCount == 0) {
            //cycle through adjacent tiles and reveal them
            
        }
    }
    
    
    
}
