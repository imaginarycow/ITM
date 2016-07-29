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


enum PlayerDirection {
    case North, NorthEast, East, SouthEast, South, SouthWest, West, NorthWest
}

class NewPlayer:SKSpriteNode {
    
    class func createNewPlayer() -> SKSpriteNode {
        
        let newPlayer = SKSpriteNode(imageNamed: "PlayerWalk01")
        newPlayer.size = CGSize(width: 20 * scale, height: 20 * scale)
        newPlayer.zPosition = 100
        let rad:CGFloat = newPlayer.frame.width * 0.4
        newPlayer.physicsBody = SKPhysicsBody(circleOfRadius: rad)
        newPlayer.physicsBody?.usesPreciseCollisionDetection = true
        newPlayer.physicsBody?.categoryBitMask = playerCategory
        newPlayer.physicsBody?.collisionBitMask = bulletCategory | boundingBoxCategory | brickCategory
        newPlayer.physicsBody?.contactTestBitMask = bulletCategory | boundingBoxCategory | brickCategory
        
        return newPlayer

    }
    
}




