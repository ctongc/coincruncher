//
//  SawNode.swift
//  CoinCrusher-v1
//
//  Created by Lingtong LU on 11/16/16.
//  Copyright © 2016 Lingtong. All rights reserved.
//

import SpriteKit
import UIKit

class Saw: SKSpriteNode {
    init(scale: Float) {
        let tex = SKTexture(imageNamed: "saw")
        let sca = CGFloat(scale)
        super.init(texture: tex, color: UIColor.clear, size: CGSize(width: tex.size().width*sca, height: tex.size().height*sca))
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(self.size.height/2))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Collision.Lethal
        self.physicsBody?.contactTestBitMask = Collision.Hero
        self.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(360), duration: 12)))
        self.zPosition = CGFloat(1)
    }
    
    func moveUpDown(up: CGFloat, down: CGFloat, duration: Double, upFirst: Bool) {
        let up = SKAction.moveTo(y: up, duration: duration)
        let down = SKAction.moveTo(y: down, duration: duration)
        if (upFirst) {
            self.run(SKAction.repeatForever(SKAction.sequence([up, down])))
        } else {
            self.run(SKAction.repeatForever(SKAction.sequence([down, up])))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
