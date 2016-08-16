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

func turnPlayer(name: String, node: SKSpriteNode, direction: PlayerDirection) {
    
    var deg = 0.0
    
    switch direction {
        
    case .North:
        deg = 0.0
    case .NorthNorthEast:
        deg = -22.5
    case .NorthEast:
        deg = -45.0
    case .EastNorthEast:
        deg = -67.5
    case .NorthWest:
        deg = 45.0
    case .South:
        deg = 180.0
    case .SouthEast:
        deg = 225.0
    case .SouthWest:
        deg = 135.0
    case .East:
        deg = 270.0
    case .EastSouthEast:
        deg = 247.5
    case .SouthSouthEast:
        deg = 202.5
    case .West:
        deg = 90.0
    case .WestSouthWest:
        deg = 112.5
    case .SouthSouthWest:
        deg = 157.5
    case .NorthNorthWest:
        deg = 22.5
    case .WestNorthWest:
        deg = 67.5
    default:
        deg = 0.0
    }
    
    node.zRotation = DegToRad(deg)
}

//texture array for Player
func createTextureArray() -> [SKTexture]{
    
    var TextureArray = [SKTexture]()
    var TextureAtlas = SKTextureAtlas(named: "walkCycle")
    for i in 1...(TextureAtlas.textureNames.count - 2) {
        
        var Name = "PlayerWalk0\(i)"
        TextureArray.append(SKTexture(imageNamed: Name))
    }
    return TextureArray
}




