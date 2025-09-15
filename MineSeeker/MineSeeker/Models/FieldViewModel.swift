//
//  FieldViewModel.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/25/25.
//

import SwiftUI
import AVFoundation

//the string/codable/caseIterable are so it cane be stored in the high score model w/ swiftdata
enum GridSize: String, Codable, CaseIterable {
    case small
    case med
    case big
    case huge
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
    case options
}

@Observable
final class FieldViewModel {
    
    //@Environment(\.verticalSizeClass) var verticalSizeClass
   
    var isLandscape = false
    
    //App Setup
    var gameState = GameState.home
    var hsvm = HighScoresViewModel()
    
    //MineField SetUp
    var gridSize = GridSize.med
    var rowCount: Int = 5
    var columnCount: Int = 5
    var gameTiles: [Tile] = []
    
    var lastWasMine: Bool = false
    var chanceOfMine: Int = 15
    
    //Tile Setup (Draggable)
    var tileFrames: [CGRect] = []
    var framesReady = false
    var shouldMeasureFrames = false

    //GameState Details
    var lostGame = false
    var gameStarted = false
    var gameIsOver = false
    var showGameStatusAlert = false
    var isFirstTile = true
    
    //SOUNDS
    var musicFile: AVAudioPlayer?
    var sfxPlayers: [String:AVAudioPlayer] = [:]
    var sfx: Bool
    var music: Bool {
        didSet {
            guard music != oldValue else { return }
            
            if music {
                startMusic()
            } else {
                stopMusic()
            }
            UserDefaults.standard.set(music, forKey:"music")
        }
    }
//    var bombSfx: AVAudioPlayer?
    
   
    //Scoring (and Saving)
    var newHighScore = false
    //
    var gameScore: Int = 0
    var mineCount: Int = 0
    
    //**added these
//    private var baselineTiles: [Tile] = []
//    private var baselineRowCount: Int = 0
//    private var baselineColumnCount: Int = 0
    
    
    init() {
        self.sfx = UserDefaults.standard.bool(forKey: "sfx")
        let savedMusic = UserDefaults.standard.bool(forKey: "music")
        self.music = UserDefaults.standard.bool(forKey: "music")
        
        if savedMusic && !AVAudioSession.sharedInstance().isOtherAudioPlaying {
            startMusic()
        } else {
            music = false
        }
    }
    
    func startMusic() {

        
        if musicFile == nil {
            if let url = Bundle.main.url(forResource: "mineFindSong", withExtension: "caf") {
                            do {
                                //try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
                                try AVAudioSession.sharedInstance().setActive(true, options: [])
                                musicFile = try AVAudioPlayer(contentsOf: url)
                                musicFile?.volume = 0.2
                                musicFile?.numberOfLoops = -1
                                musicFile?.prepareToPlay()
                            } catch {
                                print("[FieldViewModel] Failed to initialize music: \(error)")
                            }
                        } else {
                            print("[FieldViewModel] Missing resource mineFindSong.caf")
                        }
                    }
                    musicFile?.play()
        }
    
    private func stopMusic() {
        musicFile?.stop()
    }

    func playSFX(_ name: String, ext: String = "mp3") {
        guard sfx else {return}
        
        if let player = sfxPlayers[name] {
            player.currentTime = 0
            player.play()
        } else if let url = Bundle.main.url(forResource: name, withExtension: ext) {
            do {
                try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
                let newPlayer = try AVAudioPlayer(contentsOf: url)
                newPlayer.prepareToPlay()
                sfxPlayers[name] = newPlayer
                newPlayer.play()
            } catch {
                print("[FieldViewModel] failed to load sfx: \(error)")
            }
        } else {
            print("[FieldViewModel]  missing sfx resource: \(name).\(ext)")
        }
    }
    
    func setUpGame() {
        
        //**changed isLandscape to false
        rowCount = getRowCount(size: gridSize, isLandscape: false)
        columnCount = getColumnCount(size: gridSize, isLandscape: false)
        mineCount = 0
        
        isFirstTile = true
        gameIsOver = false
        tileFrames = Array(repeating: .zero, count: rowCount * columnCount)
        framesReady = false
        lostGame = false
        
        gameTiles = createTiles()
        
        //**added these
//        baselineTiles = createTiles()
//        baselineRowCount = rowCount
//        baselineColumnCount = columnCount
        
        //gameTiles = baselineTiles
    }
    
//    func applyOrientation(isLandscape: Bool) {
//        if isLandscape {
//            rotateBaselineToLandscape()
//        } else {
//            rowCount = baselineRowCount
//            columnCount = baselineColumnCount
//            gameTiles = baselineTiles
//            tileFrames = Array(repeating: .zero, count: rowCount * columnCount)
//        }
//    }
//    
//    func rotateBaselineToLandscape() {
//        let newRowCount = baselineColumnCount
//        let newColumnCount = baselineRowCount
//        
//        var newGameTiles: [Tile] = Array(
//            repeating: Tile(row: 0, column: 0, isMine: false),
//            count: baselineRowCount * baselineColumnCount
//        )
//        
//        for oldRow in 0..<baselineRowCount {
//            for oldCol in 0..<baselineColumnCount {
//                let oldIndex = oldRow * baselineColumnCount + oldCol
//                let newRow = oldCol
//                let newCol = newColumnCount - 1 - oldRow
//                let newIndex = newRow * newColumnCount + newCol
//                
//                var newTile = baselineTiles[oldIndex]
//                newTile.row = newRow
//                newTile.column = newCol
//                newGameTiles[newIndex] = newTile
//            }
//        }
//        
//        rowCount = newRowCount
//        columnCount = newColumnCount
//        gameTiles = newGameTiles
//        tileFrames = Array(repeating: .zero, count: rowCount * columnCount)
//        
//    }
    
    
    //CREAT TILES/set up
    func createTiles(/*rowCount: Int, columnCount: Int*/) -> [Tile] {
        
        //CREATE TILES FOR TILEVIEW
        var tiles: [Tile] = []
        for row in 0..<rowCount {
            for column in 0..<columnCount {
                tiles.append(Tile(row: row, column: column, isMine: MineRandomizer(percentChance: chanceOfMine)))
                
            }
        }
        
        //if no mines found, adds one
        if mineCount == 0, !tiles.isEmpty {
            if let randomIndex = tiles.indices.randomElement() {
                tiles[randomIndex].isMine = true
                print("added a mine to \(tiles[randomIndex].row), + \(tiles[randomIndex].column) ")
                mineCount += 1
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
            let thisMineCount = neighbors.reduce(0) { count, coord in
                //find a tile (if it exists) that has the same row/column properties as the neighborTile coordinates
                if let neighborTile = tiles.first(where: { $0.row == coord.0 && $0.column == coord.1 }) {
                
                    
                    //return the current count + 1 if the neighborTile was a mine
                    return count + (neighborTile.isMine ? 1 : 0)
                    
                }
                print(count)
                return count
            }
            tiles[i].surroundingMineCount = thisMineCount
        }
        
        return tiles
    }
    
    //THIS IS MOSTLY REPEATED CODE, BUT WHATEVER
    func recountSurroundingMines(gameTiles: [Tile]) {
        for i in gameTiles.indices {
            //for each tile...
            let neighbors = neighborCoordinates(tile: gameTiles[i])
            //take each neighbor...
            let thisMineCount = neighbors.reduce(0) { count, coord in
                //find a tile (if it exists) that has the same row/column properties as the neighborTile coordinates
                if let neighborTile = gameTiles.first(where: { $0.row == coord.0 && $0.column == coord.1 }) {
                    //return the current count + 1 if the neighborTile was a mine
                    return count + (neighborTile.isMine ? 1 : 0)
                }
                return count
            }
            self.gameTiles[i].surroundingMineCount = thisMineCount
        }
    }
    
//    func rotateGrid() {
//        let newRowCount = columnCount
//        let newColumnCount = rowCount
//        
//        var newGameTiles: [Tile] = Array(repeating: Tile(row:0,column:0,isMine:false), count: rowCount * columnCount)
//        
//        for oldRow in 0..<rowCount {
//            for oldCol in 0..<columnCount {
//                let oldIndex = oldRow * columnCount + oldCol
//                let newRow = oldCol
//                let newCol = newColumnCount - 1 - oldRow
//                let newIndex = newRow * newColumnCount + newCol
//                
//                var newTile = gameTiles[oldIndex]
//                newTile.row = newRow
//                newTile.column = newCol
//                newGameTiles[newIndex] = newTile
//            }
//        }
//        
//        // Update counts and replace tiles
//        rowCount = newRowCount
//        columnCount = newColumnCount
//        gameTiles = newGameTiles
//        tileFrames = Array(repeating: .zero, count: rowCount * columnCount)
//        
//        recountSurroundingMines(gameTiles: gameTiles)
//    }
    
    
    
    func MineRandomizer(percentChance: Int) -> Bool {
       // var minegoal = floor(Double((rowCount * columnCount)/4))
        //print("minegoal is \(minegoal)")

        
        if percentChance >= Int.random(in: 0..<100) {
            mineCount += 1
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
        gameIsOver = true
        //showGameStatusAlert = true

        lostGame = true
        for i in self.gameTiles.indices {
            
            gameTiles[i].isRevealed = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showGameStatusAlert = true
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
                        self.gameTiles[index].isFlagged = false
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
            mineCount = mineTiles.count
            gameState = .won
            gameIsOver = true

        } else {
            gameScore -= 500
            showGameStatusAlert = true
            playSFX("buttondown1")
        }
        
        
        
        
    }
    
    func getRowCount(size: GridSize, isLandscape: Bool) -> Int {
        switch size {
        case .small:
            return 4
        case .med:
            return 7
        case .big:
            return isLandscape ? 8 : 14
        case .huge:
            return isLandscape ? 10 : 15
        }
    }
    
    func getColumnCount(size: GridSize, isLandscape: Bool) -> Int {
        switch size {
        case .small:
            return 4
        case .med:
            return 7
        case .big:
            return isLandscape ? 14 : 8
        case .huge:
            return isLandscape ? 15 : 10
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

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    static var isVision: Bool {
        UIDevice.current.userInterfaceIdiom == .vision
    }
    
    
//    static var isOther: Bool {
//        UIDevice.current.userInterfaceIdiom ==
//    }
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

