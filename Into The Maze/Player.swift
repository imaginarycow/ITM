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
var playerSpeed: CGFloat = 0.05
var playerWidth: CGFloat = 20.0

enum PlayerDirection {
    case North, NorthNorthEast, NorthEast, EastNorthEast, East, EastSouthEast, SouthEast, SouthSouthEast, South, SouthSouthWest, SouthWest, WestSouthWest, West, NorthWest, WestNorthWest, NorthNorthWest
}

class NewPlayer:SKSpriteNode {
    
    class func createNewPlayer() -> SKSpriteNode {
        
        let newPlayer = SKSpriteNode(imageNamed: "PlayerWalk01")
        newPlayer.size = CGSize(width: playerWidth * scale, height: playerWidth * scale)
        newPlayer.zPosition = 100
        let rad:CGFloat = newPlayer.frame.width * 0.4
        newPlayer.physicsBody = SKPhysicsBody(circleOfRadius: rad)
        newPlayer.physicsBody?.allowsRotation = false
        newPlayer.physicsBody?.angularDamping = 1.0
        newPlayer.physicsBody?.restitution = 0
        newPlayer.physicsBody?.usesPreciseCollisionDetection = true
        newPlayer.physicsBody?.categoryBitMask = playerCategory
        newPlayer.physicsBody?.collisionBitMask = bulletCategory | boundingBoxCategory | brickCategory
        newPlayer.physicsBody?.contactTestBitMask = bulletCategory | boundingBoxCategory | brickCategory
        
        return newPlayer

    }
    
}




