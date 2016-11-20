//
//  WallNode.swift
//  CoinCrusher-v1
//
//  Created by Lingtong LU on 11/16/16.
//  Copyright © 2016 Lingtong. All rights reserved.
//

import SpriteKit
import UIKit

class Wall: SKSpriteNode {
    init(tex: String, scale: Float, yOffset: Float) {
        let tex = SKTexture(imageNamed: tex)
        let sca = CGFloat(scale)
        super.init(texture: tex, color: UIColor.clear, size: CGSize(width: tex.size().width*sca, height: tex.size().height*sca))
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: self.frame.origin, size: CGSize(width: self.size.width, height: self.size.height-CGFloat(yOffset))))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Collision.Wall
        self.physicsBody?.collisionBitMask = Collision.Hero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

