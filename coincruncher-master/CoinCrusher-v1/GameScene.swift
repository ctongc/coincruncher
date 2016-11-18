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
    var saw = SKSpriteNode(imageNamed: "saw")
    var coin1 = SKSpriteNode(imageNamed: "coin1")
    var coin2 = SKSpriteNode(imageNamed: "coin2")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        hero.position = CGPoint(x: size.width*0.3, y: size.height*0.8)
        wall.position = CGPoint(x: size.width*0.2, y: size.height*0.5)
        hero.setScale(0.3)
        
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
        
        addSaw()
        addCoin1()
        addCoin2()
        print("hello")
        
        
    }
    
    func addSaw(){
        
        saw.setScale(0.5)
        let radius = saw.size.height/2
        saw.zPosition = 1;
        saw.position = CGPoint(x: 0, y: radius)
        addChild(saw)
        
        saw.physicsBody? = SKPhysicsBody(rectangleOf: saw.size)
        saw.physicsBody?.isDynamic = true
        saw.physicsBody?.affectedByGravity = false
        saw.physicsBody?.collisionBitMask = Collision.Saw
        
        let height = frame.height;
        let actualDuration = random() * 5 + 5
        let moveUp = SKAction.move(to: CGPoint(x: 0, y: height - radius), duration: TimeInterval(actualDuration))
        let moveDown = SKAction.move(to: CGPoint(x: 0, y: radius), duration: TimeInterval(actualDuration))
        
        saw.run(SKAction.repeatForever(SKAction.sequence([moveUp, moveDown])))
    }
    
    /*calculates random position*/
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func addCoin1(){
        coin1.setScale(0.5)
        coin1.zPosition = 1;
        coin1.position = CGPoint(x: size.width*0.8, y: size.height*0.8)
        addChild(coin1)
        
        coin1.physicsBody = SKPhysicsBody(rectangleOf: coin1.size)
        coin1.physicsBody?.isDynamic = false
        coin1.physicsBody?.affectedByGravity = false
        coin1.physicsBody?.collisionBitMask = Collision.Coin
        
    }
    
    func addCoin2(){
        coin2.setScale(0.5)
        coin2.zPosition = 1;
        coin2.position = CGPoint(x: size.width*0.9, y: size.height*0.6)
        addChild(coin2)
        
        coin2.physicsBody = SKPhysicsBody(rectangleOf: coin2.size)
        coin2.physicsBody?.isDynamic = false
        coin2.physicsBody?.affectedByGravity = false
        coin2.physicsBody?.collisionBitMask = Collision.Coin
        
    }

    
    
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else {
//            return
//        }
//        
//        
//    }
}
