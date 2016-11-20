//
//  GoldNode.swift
//  CoinCrusher-v1
//
//  Created by Lingtong LU on 11/16/16.
//  Copyright © 2016 Lingtong. All rights reserved.
//

import SpriteKit
import UIKit

class Gold: SKSpriteNode {
    init() {
        let tex = SKTexture(imageNamed: "GoldNode-4")
        super.init(texture: tex, color: UIColor.clear, size: tex.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Collision.Gold
        self.physicsBody?.contactTestBitMask = Collision.Hero
        spinning()
    }
    
    func spinning() {
        var frames: [SKTexture] = []
        for i in 1...18{
            frames.append(SKTexture(imageNamed: "GoldNode-"+String(i)))
        }
        self.run(SKAction.repeatForever(SKAction.animate(with: frames, timePerFrame: 0.3, resize: true, restore: false)))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
