//
//  GameScene.swift
//  CoinCrusher-v1
//
//  Created by Lingtong LU on 11/14/16.
//  Copyright © 2016 Lingtong. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    let hero = Hero()
    let lava = Lava(tex: "Lava-1", scale: 0.4)
    let wall1 = Wall(tex: "Wall-1", scale: 0.4, yOffset: 0)
    let wall2 = Wall(tex: "Wall-2", scale: 0.4, yOffset: 0)
    let wall3 = Wall(tex: "Wall-3", scale: 0.4, yOffset: 0)
    let gold1 = Gold()
    let gold2 = Gold()
    let gold3 = Gold()
    let saw1 = Saw(scale: 0.6)
    let saw2 = Saw(scale: 0.6)
    let motionManager = CMMotionManager()
    var coinCount = 3
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red:0.016, green:0.093, blue:0.129, alpha:1)
        hero.position = CGPoint(x: size.width/2, y: size.height*0.95)
        lava.position = CGPoint(x: self.size.width/2, y: lava.size.height/1.9)
        wall1.position = CGPoint(x: wall1.size.width/2, y: size.height*0.5)
        wall2.position = CGPoint(x: self.size.width-wall2.size.width/2, y: self.size.height*0.8)
        wall3.position = CGPoint(x: self.size.width-wall3.size.width/2, y: self.size.height*0.3)
        gold1.position = CGPoint(x: size.width*0.7, y: size.height*0.9)
        gold2.position = CGPoint(x: size.width*0.2, y: size.height*0.2)
        gold3.position = CGPoint(x: size.width*0.9, y: size.height*0.5)
        saw1.position = CGPoint(x: 0, y: size.height*0.2)
        saw2.position = CGPoint(x: self.size.width, y: size.height*0.9)
        self.addChild(hero)
        self.addChild(wall1)
        self.addChild(wall2)
        self.addChild(wall3)
        self.addChild(lava)
        self.addChild(gold1)
        self.addChild(gold2)
        self.addChild(gold3)
        self.addChild(saw1)
        self.addChild(saw2)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = Collision.Wall
        
        // add action to saw
        saw1.moveUpDown(up: self.size.height*0.8, down: self.size.height*0.2, duration: 3.5, upFirst: true)
        saw2.moveUpDown(up: self.size.height*0.9, down: self.size.height*0.4, duration: 3.5, upFirst: false)
        
        // set up accelerometer
        if motionManager.isAccelerometerAvailable {
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: {
                (data, error) in
                guard let dx = data?.acceleration.x else {return}
                print(dx)
                self.hero.physicsBody?.applyImpulse(CGVector(dx: dx>0 ? 10 : -10, dy: 0))
//                print(self.hero.physicsBody?.velocity.dx)
                if (self.hero.physicsBody?.velocity.dx)! > CGFloat(80) {
                    self.hero.physicsBody?.velocity.dx = 80
                } else if (self.hero.physicsBody?.velocity.dx)! < CGFloat(-80) {
                    self.hero.physicsBody?.velocity.dx = -80
                }
                if ((self.hero.physicsBody?.velocity.dx)! > CGFloat(0) &&
                    self.hero.direction == "left") {
                    self.hero.direction = "right"
                    self.hero.flying(direction: "right")
                } else if ((self.hero.physicsBody?.velocity.dx)! < CGFloat(0) &&
                    self.hero.direction == "right") {
                    self.hero.direction = "left"
                    self.hero.flying(direction: "left")
                }
            })
        }
        
        // add background music 
        let backgroundMusic = SKAudioNode(fileNamed: "bgm2.wav")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & Collision.Hero != 0) &&
            (secondBody.categoryBitMask & Collision.Gold != 0)) {
            eatGold(hero: firstBody.node as! SKSpriteNode, gold: secondBody.node as! SKSpriteNode)
        } else if((firstBody.categoryBitMask & Collision.Hero != 0) &&
            (secondBody.categoryBitMask & Collision.Lethal != 0)) {
            gameEndWith(won: false)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10))
        if (hero.physicsBody?.velocity.dy)! > CGFloat(100) {
            self.hero.physicsBody?.velocity.dy = 100
        }
    }
    
    func eatGold(hero: SKSpriteNode, gold: SKSpriteNode) {
        gold.removeFromParent()
        run(SKAction.playSoundFileNamed("pickup.wav", waitForCompletion: true))
        self.coinCount -= 1
        
        if (self.coinCount == 0) {
            gameEndWith(won: true)
        }
    }
    func gameEndWith(won: Bool) {
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let gameOverScene = GameOverScene(size: self.size, won: won)
        self.view?.presentScene(gameOverScene, transition: reveal)
    }
}
