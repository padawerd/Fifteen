//
//  TileNode.swift
//  Fifteen
//
//  Created by david padawer on 2/28/18.
//  Copyright © 2018 DPad Studios. All rights reserved.
//


import Foundation
import SpriteKit

class TileNode : SKShapeNode {
    let number : Int
    
    init(number: Int) {
        self.number = number
        super.init()
        self.path = CGPath(rect: CGRect(x: 0, y: 0, width: 25, height: 25), transform: nil)
        self.fillColor = .yellow

        let label = SKLabelNode(text: String(number))
        label.fontName = "ArialRoundedMTBold"
        label.fontColor = .blue
        label.fontSize = 18
        label.verticalAlignmentMode = .center
        label.position = CGPoint(x: 12.5, y: 12.5)
        self.isUserInteractionEnabled = true
        self.addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            moveIfPossible()
        }
    }

    func moveIfPossible() {
        let parent = self.parent as! GameScene
        if self.position.x == parent.currentEmptyPosition.x {
            //move down
            if self.position.y == parent.currentEmptyPosition.y + 25 {
                let move = SKAction.move(to: parent.currentEmptyPosition, duration: 0.1)
                self.run(move, completion: {() in
                    self.position = parent.currentEmptyPosition
                    parent.currentEmptyPosition.y += 25
                    parent.moves += 1 })
            //move up
            } else if self.position.y == parent.currentEmptyPosition.y - 25 {
                let move = SKAction.move(to: parent.currentEmptyPosition, duration: 0.1)
                self.run(move, completion: {() in
                    self.position = parent.currentEmptyPosition
                    parent.currentEmptyPosition.y -= 25
                    parent.moves += 1 })
            }
        } else if self.position.y == parent.currentEmptyPosition.y {
            //move left
            if self.position.x == parent.currentEmptyPosition.x + 25 {
                let move = SKAction.move(to: parent.currentEmptyPosition, duration: 0.1)
                self.run(move, completion: {() in
                    self.position = parent.currentEmptyPosition
                    parent.currentEmptyPosition.x += 25
                    parent.moves += 1 })
            //move right
            } else if self.position.x == parent.currentEmptyPosition.x - 25 {
                let move = SKAction.move(to: parent.currentEmptyPosition, duration: 0.1)
                self.run(move, completion: {() in
                    self.position = parent.currentEmptyPosition
                    parent.currentEmptyPosition.x -= 25
                    parent.moves += 1 })
            }
        }

        
        

    }

}
