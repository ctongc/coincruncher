//
//  ShotNode.swift
//  CoinCrusher-v1
//
//  Created by Lingtong LU on 11/19/16.
//  Copyright © 2016 Lingtong. All rights reserved.
//

import SpriteKit
import UIKit

class Shot: SKSpriteNode {
    
    init(direction: String) {
        let tex = SKTexture(imageNamed: "ShotNode-"+direction+"-1")
        super.init(texture: tex, color: UIColor.clear, size: CGSize(width: tex.size().width/1.6, height: tex.size().height/1.6))
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = Collision.Hero
        self.physicsBody?.affectedByGravity = false
//        self.physicsBody?.collisionBitMask = Collision.Wall
//        self.physicsBody?.contactTestBitMask = Collision.Gold | Collision.Lethal
        
        animate(direction: direction)
    }
    
    func animate(direction: String) {
        let f0 = SKTexture.init(imageNamed: "ShotNode-"+direction+"-1")
        let f1 = SKTexture.init(imageNamed: "ShotNode-"+direction+"-2")
        let f2 = SKTexture.init(imageNamed: "ShotNode-"+direction+"-3")
        let frames: [SKTexture] = [f0, f1, f2]
        
        let animation = SKAction.animate(with: frames, timePerFrame: 0.2)
        self.run(SKAction.repeatForever(animation))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
