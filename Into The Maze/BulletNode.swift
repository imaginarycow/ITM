//
//  BulletNode.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/4/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//
//  All About Bullets here!

import Foundation
import SpriteKit

//remove bullet from scene
func removeBullet(node:SKNode) {
    print("attempting to remove bullet")
    node.removeAllChildren()
    node.removeFromParent()
}

//get offset and rotation for bullet based on direction player is facing
func getBulletOffset(direction: PlayerDirection) -> (CGFloat, CGFloat, Double) {
    
    var xOffset:CGFloat = 0.0
    var yOffset:CGFloat = 0.0
    var rotation:Double = 0.0
    
    let xDist:CGFloat = 5.0
    let yDist:CGFloat = 5.0
    
    switch direction {
        
    case .North:
        xOffset = 0.0
        yOffset = yDist
        rotation = 90.0
    case .NorthEast:
        xOffset = xDist
        yOffset = yDist
        rotation = 45.0
    case .NorthWest:
        xOffset = -xDist
        yOffset = yDist
        rotation = 135.0
    case .South:
        xOffset = 0.0
        yOffset = -yDist
        rotation = 270.0
    case .SouthEast:
        xOffset = xDist
        yOffset = -yDist
        rotation = 315.0
    case .SouthWest:
        xOffset = -xDist
        yOffset = -yDist
        rotation = 225.0
    case .East:
        xOffset = xDist
        yOffset = 0.0
        rotation = 0.0
    case .West:
        xOffset = -xDist
        yOffset = 0.0
        rotation = 180.0
    default:
        xOffset = 0.0
        yOffset = 0.0
    }
    
    
    return (xOffset, yOffset, rotation)
}

func createProjectile() -> SKSpriteNode {

    
    let bullet = SKSpriteNode(imageNamed: "projectile")
    bullet.size = CGSize(width: 10.0, height: 10.0)
    bullet.zPosition = 50
    
    bullet.name = "bulletNode"
    bullet.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: bullet.size.width, height: bullet.size.height))
    
    bullet.physicsBody?.usesPreciseCollisionDetection = true
    bullet.physicsBody?.affectedByGravity = false
    
    bullet.physicsBody?.categoryBitMask = bulletCategory
    bullet.physicsBody?.collisionBitMask = bulletCategory | boundingBoxCategory | playerCategory
    bullet.physicsBody?.contactTestBitMask = bulletCategory | boundingBoxCategory | playerCategory
    
    return bullet
}

//get bullet impulse based on player direction and return in CGFloat
func getBulletImpulse(direction: PlayerDirection) -> (CGFloat, CGFloat) {
    
    var xImpulse:CGFloat = 0.0
    var yImpulse:CGFloat = 0.0
    
    let max:CGFloat = 1.0
    
    switch direction {
        
    case .North:
        xImpulse = 0.0
        yImpulse = max
    case .NorthEast:
        xImpulse = max
        yImpulse = max
    case .NorthWest:
        xImpulse = -max
        yImpulse = max
    case .South:
        xImpulse = 0.0
        yImpulse = -max
    case .SouthEast:
        xImpulse = max
        yImpulse = -max
    case .SouthWest:
        xImpulse = -max
        yImpulse = -max
    case .East:
        xImpulse = max
        yImpulse = 0.0
    case .West:
        xImpulse = -max
        yImpulse = 0.0
    default:
        xImpulse = 0.0
        yImpulse = 0.0
    }

    
    return (xImpulse, yImpulse)
}











