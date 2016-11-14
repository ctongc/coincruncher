//
//  GameScene.swift
//  CoinCrusher-v1
//
//  Created by Lingtong LU on 11/14/16.
//  Copyright © 2016 Lingtong. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    let hero = SKSpriteNode(imageNamed: "hero")
    let wall = SKSpriteNode(imageNamed: "wall")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        hero.position = CGPoint(x: size.width*0.1, y: size.height*0.8)
        wall.position = CGPoint(x: size.width*0.2, y: size.height*0.5)
        addChild(hero)
        addChild(wall)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.6)
        physicsWorld.contactDelegate = self
        
        hero.physicsBody = SKPhysicsBody(rectangleOf: hero.size)
        hero.physicsBody?.isDynamic = true
        hero.physicsBody?.collisionBitMask = Collision.Hero
        
        wall.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
        wall.physicsBody?.isDynamic = false
        wall.physicsBody?.affectedByGravity = false
        wall.physicsBody?.collisionBitMask = Collision.Wall
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else {
//            return
//        }
//        
//        
//    }
}
