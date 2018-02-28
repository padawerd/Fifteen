//
//  ViewController.swift
//  Fifteen
//
//  Created by david padawer on 2/28/18.
//  Copyright © 2018 DPad Studios. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func loadView() {
        self.view = SKView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene(size: CGSize(width: 100, height: 150))
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFit
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

