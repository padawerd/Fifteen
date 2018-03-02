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

    var fadeOut : UIView?
    override func loadView() {
        self.view = SKView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        Skillz.skillzInstance().launch();
    }

    func startGame() {
        let scene = GameScene(size: CGSize(width: 100, height: 150))
        scene.endGame = {[weak self] (finalScore: Int) in self?.endGame(finalScore: finalScore)}
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

    func endGame(finalScore: Int) {
        self.fadeOut = UIView(frame: self.view.frame)
        self.fadeOut!.backgroundColor = .blue
        self.fadeOut!.alpha = 0
        self.view.addSubview(fadeOut!)
        UIView.animate(withDuration: 1, animations: {[unowned self] () in self.fadeOut!.alpha = 1}, completion: {[unowned self] (_) in
            Skillz.skillzInstance().displayTournamentResults(withScore: NSNumber(integerLiteral:finalScore), withCompletion: { () in })
            let skView = self.view as! SKView
            skView.presentScene(nil)
            self.fadeOut!.removeFromSuperview()
            self.fadeOut = nil
        })
    }
}

