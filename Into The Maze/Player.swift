//
//  Player.swift
//  Into The Maze
//
//  Created by ramiro beltran on 2/2/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

var playerName:String = ""
var playerSpeed : CGFloat = 0.1
var abilitySelected:ability = .wallBuster

enum ability {
    case wallBuster, speedDemon, timeFreeze
}

enum PlayerDirection {
    case North, NorthEast, East, SouthEast, South, SouthWest, West, NorthWest
}

class NewPlayer:SKSpriteNode {
    
    class func createNewPlayer() -> SKSpriteNode {
        
        let newPlayer = SKSpriteNode(imageNamed: "PlayerWalk01")
        newPlayer.size = CGSize(width: 40 * scale, height: 40 * scale)
        newPlayer.zPosition = 100
        
        newPlayer.physicsBody = SKPhysicsBody(rectangleOfSize: newPlayer.frame.size)
        //newPlayer.physicsBody?.dynamic = false
        newPlayer.physicsBody?.categoryBitMask = playerCategory
        newPlayer.physicsBody?.collisionBitMask = bulletCategory | boundingBoxCategory
        newPlayer.physicsBody?.contactTestBitMask = bulletCategory | boundingBoxCategory
        
        return newPlayer

    }
    
}




