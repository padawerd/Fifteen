//
//  GameScene.swift
//  Fifteen
//
//  Created by david padawer on 2/28/18.
//  Copyright © 2018 DPad Studios. All rights reserved.
//

import Foundation
import SpriteKit
import Skillz


class GameScene : SKScene {

    let placeHolderTile = TileNode(number: -1)
    var tiles : [TileNode] = [TileNode(number: 1), TileNode(number: 2), TileNode(number: 3), TileNode(number: 4),
                 TileNode(number: 5), TileNode(number: 6), TileNode(number: 7), TileNode(number: 8),
                 TileNode(number: 9), TileNode(number: 10), TileNode(number: 11), TileNode(number: 12),
                 TileNode(number: 13), TileNode(number: 14), TileNode(number: 15)]
    var currentEmptyPosition : CGPoint!
    var moves = 0 {
        didSet {
            self.updateScoreLabel()
            let currentScore = (moves * 100) + self.roundedDownTime
            Skillz.skillzInstance().updatePlayersCurrentScore(NSNumber(integerLiteral: currentScore))
            self.finishGameIfDone()
        }
    }
    var roundedDownTime = 0 {
        didSet {
            self.updateTimeLabel()
        }
    }
    var startTime : Date!
    var timer : Timer!
    var score = SKLabelNode(fontNamed: "ArialRoundedMTBold")
    let time = SKLabelNode(fontNamed: "ArialRoundedMTBold")
    var endGame : ((Int) -> Void)!

    override func didMove(to view: SKView) {
        tiles.append(placeHolderTile)
        backgroundColor = SKColor.blue
        self.isUserInteractionEnabled = false

        self.shuffleTilesAndAddToScene()

        self.updateScoreLabel()
        score.position = CGPoint(x: 50, y: 130)
        score.fontSize = 12
        self.addChild(score)

        self.startTime = Date()
        self.updateTimeLabel()

        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateRoundedDownTime), userInfo: nil, repeats: true)
        time.position = CGPoint(x: 50, y: 110)
        time.fontSize = 12
        self.addChild(time)
    }

    func updateScoreLabel() {
        self.score.text = "Moves: " + String(moves)
    }

    func updateTimeLabel() {
        self.time.text = "Time: " + String(Int(NSDate().timeIntervalSince(self.startTime).rounded(.down)))
    }

    func updateRoundedDownTime() {
        self.roundedDownTime = Int(NSDate().timeIntervalSince(self.startTime).rounded(.down))
    }

    func finishGameIfDone() {
        if (self.tiles[0].position.x == 0 && self.tiles[0].position.y == 75 &&
            self.tiles[1].position.x == 25 && self.tiles[1].position.y == 75 &&
            self.tiles[2].position.x == 50 && self.tiles[2].position.y == 75 &&
            self.tiles[3].position.x == 75 && self.tiles[3].position.y == 75 &&
            self.tiles[4].position.x == 0 && self.tiles[4].position.y == 50 &&
            self.tiles[5].position.x == 25 && self.tiles[5].position.y == 50 &&
            self.tiles[6].position.x == 50 && self.tiles[6].position.y == 50 &&
            self.tiles[7].position.x == 75 && self.tiles[7].position.y == 50 &&
            self.tiles[8].position.x == 0 && self.tiles[8].position.y == 25 &&
            self.tiles[9].position.x == 25 && self.tiles[9].position.y == 25 &&
            self.tiles[10].position.x == 50 && self.tiles[10].position.y == 25 &&
            self.tiles[11].position.x == 75 && self.tiles[11].position.y == 25 &&
            self.tiles[12].position.x == 0 && self.tiles[12].position.y == 0 &&
            self.tiles[13].position.x == 25 && self.tiles[13].position.y == 0 &&
            self.tiles[14].position.x == 50 && self.tiles[14].position.y == 0) {

            self.timer.invalidate()
            self.timer = nil
            let finalScore = (self.moves * 100) + self.roundedDownTime
            self.endGame(finalScore)

        }
    }

    func shuffleTilesAndAddToScene() {
        //compiler is too stupid to do this in one go
        var positions = [CGPoint(x: 0, y: 75), CGPoint(x: 25, y: 75), CGPoint(x: 50, y: 75), CGPoint(x: 75, y: 75)]
        positions.append(contentsOf: [CGPoint(x: 0, y: 50), CGPoint(x: 25, y: 50), CGPoint(x: 50, y: 50), CGPoint(x: 75, y: 50)])
        positions.append(contentsOf: [CGPoint(x: 0, y: 25), CGPoint(x: 25, y: 25), CGPoint(x: 50, y: 25), CGPoint(x: 75, y: 25)])
        positions.append(contentsOf: [CGPoint(x: 0, y: 0), CGPoint(x: 25, y: 0), CGPoint(x: 50, y: 0), CGPoint(x: 75, y: 0)])

        //shuffling this way ensures the puzzle is solvable
        for _ in 0...1000 {
            let randomNum =  Int(Skillz.getRandomNumber(withMin: 0, andMax: 4))
            let placeHolderIndex = tiles.index(of: placeHolderTile)!
            let canMoveUp = placeHolderIndex > 3
            let canMoveDown = placeHolderIndex < 12
            let canMoveLeft = placeHolderIndex % 4 != 0
            let canMoveRight = placeHolderIndex % 4 != 3

            if (randomNum == 0) {
                if (canMoveUp) {
                    tiles[placeHolderIndex] = tiles[placeHolderIndex - 4]
                    tiles[placeHolderIndex - 4] = placeHolderTile
                } else {
                    //move down instead
                    tiles[placeHolderIndex] = tiles[placeHolderIndex + 4]
                    tiles[placeHolderIndex + 4] = placeHolderTile
                }
            } else if (randomNum == 1) {
                if (canMoveDown) {
                    tiles[placeHolderIndex] = tiles[placeHolderIndex + 4]
                    tiles[placeHolderIndex + 4] = placeHolderTile
                } else {
                    //move up instead
                    tiles[placeHolderIndex] = tiles[placeHolderIndex - 4]
                    tiles[placeHolderIndex - 4] = placeHolderTile
                }
            } else if (randomNum == 2) {
                if (canMoveLeft) {
                    tiles[placeHolderIndex] = tiles[placeHolderIndex - 1]
                    tiles[placeHolderIndex - 1] = placeHolderTile
                } else {
                    //move right instead
                    tiles[placeHolderIndex] = tiles[placeHolderIndex + 1]
                    tiles[placeHolderIndex + 1] = placeHolderTile
                }
            } else if (randomNum == 3) {
                if (canMoveRight) {
                    tiles[placeHolderIndex] = tiles[placeHolderIndex + 1]
                    tiles[placeHolderIndex + 1] = placeHolderTile

                } else {
                    //move left instead
                    tiles[placeHolderIndex] = tiles[placeHolderIndex - 1]
                    tiles[placeHolderIndex - 1] = placeHolderTile
                }
            }
        }

        for i in (0...tiles.count - 1) {
            tiles[i].position = positions[i]
            if (tiles[i] != placeHolderTile) {
                self.addChild(tiles[i])
            }
        }
        currentEmptyPosition = placeHolderTile.position
        tiles = tiles.filter({$0 != placeHolderTile})
        //now sort them back by number so that the win condition check works
        self.tiles.sort(by: {$0.number < $1.number})

    }
}
