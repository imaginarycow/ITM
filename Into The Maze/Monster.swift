//
//  Monster.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/25/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

var MonsterSpeed : CGFloat = 0.1
let monsterSize:CGFloat = 40.0


enum MonsterDirection {
    case North, NorthEast, East, SouthEast, South, SouthWest, West, NorthWest
}

class Monster:SKSpriteNode {
    
    class func newMonster() -> SKSpriteNode {
        
        let newMonster = SKSpriteNode(imageNamed: "monster")
        newMonster.size = CGSize(width: monsterSize * scale, height: monsterSize * scale)
        newMonster.zPosition = 100
        
        newMonster.physicsBody = SKPhysicsBody(rectangleOfSize: newMonster.frame.size)
        newMonster.physicsBody?.categoryBitMask = monsterCategory
        newMonster.physicsBody?.collisionBitMask = bulletCategory | boundingBoxCategory | playerCategory
        newMonster.physicsBody?.contactTestBitMask = bulletCategory | boundingBoxCategory | playerCategory
        
        return newMonster
        
    }
    
}
