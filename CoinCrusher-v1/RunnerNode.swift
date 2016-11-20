//
//  RunnerNode.swift
//  CoinCrusher-v1
//
//  Created by Lingtong LU on 11/19/16.
//  Copyright © 2016 Lingtong. All rights reserved.
//

import Foundation
import SpriteKit

class Runner: SKSpriteNode {
    var direction: String?
    
    init() {
        let tex = SKTexture(imageNamed: "RunnerNode-right-1.tiff")
        super.init(texture: tex, color: UIColor.clear, size: CGSize(width: tex.size().width/1.8, height: tex.size().height/1.8))
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = Collision.Hero
        self.physicsBody?.collisionBitMask = Collision.Wall
        self.physicsBody?.contactTestBitMask = Collision.Gold | Collision.Lethal
        
        self.direction = "right"
//        walkingAnimate(direction: "right")
        
    }
    
    func walking(left: CGFloat, right: CGFloat, duration: Double, rightFirst: Bool) {
        walkingAnimate(direction: self.direction!)
        let left = SKAction.moveTo(x: left, duration: duration)
        let right = SKAction.moveTo(x: right, duration: duration)
        if (rightFirst) {
            self.run(SKAction.repeatForever(SKAction.sequence([right, left])))
        } else {
            self.run(SKAction.repeatForever(SKAction.sequence([left, right])))
        }
    }
    
    func walkingAnimate(direction: String) {
        let f0 = SKTexture.init(imageNamed: "RunnerNode-"+direction+"-1")
        let f1 = SKTexture.init(imageNamed: "RunnerNode-"+direction+"-2")
        let f2 = SKTexture.init(imageNamed: "RunnerNode-"+direction+"-3")
        let f3 = SKTexture.init(imageNamed: "RunnerNode-"+direction+"-4")
        let frames: [SKTexture] = [f0, f1, f2, f3]
        
        let animation = SKAction.animate(with: frames, timePerFrame: 0.2)
        self.run(SKAction.repeatForever(animation))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
