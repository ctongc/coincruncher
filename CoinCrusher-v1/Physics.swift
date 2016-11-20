//
//  Physics.swift
//  CoinCrusher-v1
//
//  Created by Lingtong LU on 11/14/16.
//  Copyright © 2016 Lingtong. All rights reserved.
//

import SpriteKit
import Foundation

struct Collision {
    static let None : UInt32 = 0
    static let All : UInt32 = UInt32.max
    static let Hero: UInt32 = 0b1
    static let Wall: UInt32 = 0b10
    static let Gold: UInt32 = 0b100
//    static let Saw: UInt32 = 0b1000
    static let Lethal: UInt32 = 0b1000
}
