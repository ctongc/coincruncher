//
//  LavaNode.swift
//  CoinCrusher-v1
//
//  Created by Lingtong LU on 11/19/16.
//  Copyright © 2016 Lingtong. All rights reserved.
//

import SpriteKit
import UIKit

class Lava: SKSpriteNode {
    init(tex: String, scale: Float) {
        let tex = SKTexture(imageNamed: tex)
        let sca = CGFloat(scale)
        super.init(texture: tex, color: UIColor.clear, size: CGSize(width: tex.size().width*sca, height: tex.size().height*sca))
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Collision.Lethal
        self.physicsBody?.contactTestBitMask = Collision.Hero
        animation()
    }
    
    func animation() {
        let f0 = SKTexture.init(imageNamed: "Lava-1")
        let f1 = SKTexture.init(imageNamed: "Lava-2")
        let f2 = SKTexture.init(imageNamed: "Lava-3")
        
        let frames: [SKTexture] = [f0, f1, f2]
        
        let animation = SKAction.animate(with: frames, timePerFrame: 0.5)
        self.run(SKAction.repeatForever(animation))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
