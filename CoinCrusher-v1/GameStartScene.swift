//
//  GameStartScene.swift
//  CoinCrusher-v1
//
//  Created by Lingtong LU on 11/19/16.
//  Copyright © 2016 Lingtong. All rights reserved.
//

import Foundation
import SpriteKit

class GameStartScene: SKScene{
    let hero = Hero()
    let runner = Runner()
    let clicker = Clicker(direction: "left")
    let lava = Lava(tex: "Lava-1", scale: 0.4)
    let wall1 = Wall(tex: "Wall-2", scale: 0.4, yOffset: 14)
    let wall2 = Wall(tex: "Wall-3", scale: 0.4, yOffset: 0)
//    let gold1 = Gold()
    let gold2 = Gold()
    let gold3 = Gold()
    let saw1 = Saw(scale: 0.6)
    let saw2 = Saw(scale: 0.6)
    
    let title = SKLabelNode(fontNamed: "ARCADE")
    let info = SKLabelNode(fontNamed: "ARCADE")
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red:0.016, green:0.093, blue:0.129, alpha:1)
        hero.position = CGPoint(x: size.width/2, y: size.height*0.7)
        hero.physicsBody?.affectedByGravity = false
        runner.position = CGPoint(x: 50, y: size.height*0.7)
        clicker.position = CGPoint(x: self.size.width-clicker.size.width, y: size.height*0.4)
        lava.position = CGPoint(x: self.size.width/2, y: lava.size.height/1.9)
        wall1.position = CGPoint(x: wall1.size.width/2, y: size.height*0.5)
        wall2.position = CGPoint(x: self.size.width-wall2.size.width/2, y: self.size.height*0.3)
//        gold1.position = CGPoint(x: size.width*0.7, y: size.height*0.9)
        gold2.position = CGPoint(x: size.width*0.2, y: size.height*0.2)
        gold3.position = CGPoint(x: size.width*0.9, y: size.height*0.5)
        saw1.position = CGPoint(x: 0, y: size.height*0.2)
        saw2.position = CGPoint(x: self.size.width, y: size.height*0.9)
        
        self.addChild(hero)
        self.addChild(wall1)
        self.addChild(wall2)
        self.addChild(lava)
//        self.addChild(gold1)
        self.addChild(gold2)
        self.addChild(gold3)
        self.addChild(saw1)
        self.addChild(saw2)
        self.addChild(runner)
        self.addChild(clicker)
        
        saw1.moveUpDown(up: self.size.height*0.8, down: self.size.height*0.2, duration: 3.5, upFirst: true)
        saw2.moveUpDown(up: self.size.height*0.9, down: self.size.height*0.4, duration: 3.5, upFirst: false)
        runner.walking(left: 50, right: 200, duration: 3, rightFirst: true)
        
        let wait = SKAction.wait(forDuration: 2.5)
        let run = SKAction.run {
            let shot = Shot(direction: "left")
            shot.position = self.clicker.position
            self.addChild(shot)
            let action = SKAction.moveTo(x: -10, duration: 2)
            let actionDone = SKAction.removeFromParent()
            shot.run(SKAction.sequence([action, actionDone]))
        }
        self.run(SKAction.repeatForever(SKAction.sequence([run, wait])))
        
        
        // Add title
        title.text = "COINCRUSHER"
        title.fontSize = 40
        title.fontColor = SKColor.white
        title.position = CGPoint(x: size.width/2, y: size.height*0.8)
        
        
        let bigNormal = SKAction.scale(by: 1/1.3, duration: 0.8)
        let big = SKAction.scale(by: 1.3, duration: 0.8)
        let small = SKAction.scale(by: 0.8, duration: 0.8)
        let smallNormal = SKAction.scale(by: 1/0.8, duration: 0.8)
        addChild(title)
        title.run(SKAction.repeatForever(SKAction.sequence([big, bigNormal, small, smallNormal])))
        
        // Add info
        info.text = "Tap to Start"
        info.fontSize = 30
        info.fontColor = UIColor(red:0.999, green:0.555, blue:0.027, alpha:1)
        info.position = CGPoint(x: size.width/2, y: size.height*0.2)
        
        let color1 = SKAction.colorize(with: UIColor.white, colorBlendFactor: 1, duration: 0.2)
        let color2 = SKAction.colorize(with: UIColor(red:0.171, green:0.973, blue:0.753, alpha:1), colorBlendFactor: 1, duration: 0.2)
        let color3 = SKAction.colorize(with: UIColor(red:0.999, green:0.210, blue:0.031, alpha:1), colorBlendFactor: 1, duration: 0.2)
        addChild(info)
        info.run(SKAction.repeatForever(SKAction.sequence([color1, color2, color3])))
        
        // Add background music
        let backgroundMusic = SKAudioNode(fileNamed: "bgm1.wav")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)

    }
    
    override func update(_ currentTime: TimeInterval) {
        if (self.runner.position.x > 199 && self.runner.direction == "right") {
            self.runner.direction = "left"
            self.runner.walkingAnimate(direction: "left")
        } else if (self.runner.position.x < 51 && self.runner.direction == "left") {
            self.runner.direction = "right"
            self.runner.walkingAnimate(direction: "right")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let scene = GameScene(size: size)
        self.view?.presentScene(scene, transition: reveal)
    }
}
