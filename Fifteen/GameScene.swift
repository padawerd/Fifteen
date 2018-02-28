//
//  GameScene.swift
//  Fifteen
//
//  Created by david padawer on 2/28/18.
//  Copyright © 2018 DPad Studios. All rights reserved.
//

import Foundation
import SpriteKit


class GameScene : SKScene {

    let tiles = [TileNode(number: 1), TileNode(number: 2), TileNode(number: 3), TileNode(number: 4),
                 TileNode(number: 5), TileNode(number: 6), TileNode(number: 7), TileNode(number: 8),
                 TileNode(number: 9), TileNode(number: 10), TileNode(number: 11), TileNode(number: 12),
                 TileNode(number: 13), TileNode(number: 14), TileNode(number: 15)]
    var currentEmptyPosition : CGPoint!
    var moves = 0 {
        didSet {
            self.updateScoreLabel()
        }
    }
    var startTime : Date!
    var timer : Timer!
    var score = SKLabelNode(fontNamed: "ArialRoundedMTBold")
    let time = SKLabelNode(fontNamed: "ArialRoundedMTBold")

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.blue
        self.isUserInteractionEnabled = false

        //compiler is too stupid to do this in one go
        var positions = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 25), CGPoint(x: 0, y: 50), CGPoint(x: 0, y: 75)]
        positions.append(contentsOf: [CGPoint(x: 25, y: 0), CGPoint(x: 25, y: 25), CGPoint(x: 25, y: 50), CGPoint(x: 25, y: 75)])
        positions.append(contentsOf: [CGPoint(x: 50, y: 0), CGPoint(x: 50, y: 25), CGPoint(x: 50, y: 50), CGPoint(x: 50, y: 75)])
        positions.append(contentsOf: [CGPoint(x: 75, y: 0), CGPoint(x: 75, y: 25), CGPoint(x: 75, y: 50), CGPoint(x: 75, y: 75)])

        //fisher yates shuffle
        var m = positions.count
        while (m > 0) {
            let i = Int(arc4random_uniform(UInt32(m)))
            m -= 1
            let t = positions[m]
            positions[m] = positions[i]
            positions[i] = t
        }

        for i in 0...(tiles.count - 1) {
            tiles[i].position = positions[i]
            self.addChild(tiles[i])
        }
        currentEmptyPosition = positions[15]

        self.updateScoreLabel()
        score.position = CGPoint(x: 50, y: 130)
        score.fontSize = 12
        self.addChild(score)

        self.startTime = Date()
        self.updateTimeLabel()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] (_) in self?.updateTimeLabel()})
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

}
