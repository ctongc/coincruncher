//
//  GameViewController.swift
//  CoinCrusher-v1
//
//  Created by Lingtong LU on 11/14/16.
//  Copyright © 2016 Lingtong. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let scene = GameScene(size: view.bounds.size)
        let scene = GameStartScene(size: view.bounds.size)
        let skView = view as! SKView
        
        skView.showsFPS = true
        skView.showsNodeCount = true
//        skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
