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
    
    node.removeFromParent()
}

//get offset and rotation for bullet based on direction player is facing
func getBulletOffset(direction: PlayerDirection) -> (CGFloat, CGFloat, Double) {
    
    var xOffset:CGFloat = 0.0
    var yOffset:CGFloat = 0.0
    var rotation:Double = 0.0
    
    let xDist:CGFloat = 0.1
    let yDist:CGFloat = 0.1
    
    switch direction {
        
    case .North:
        xOffset = 0.0
        yOffset = yDist
        rotation = 90.0
    case .NorthEast:
        xOffset = xDist
        yOffset = yDist
        rotation = 45.0
    case .NorthNorthEast:
        xOffset = xDist
        yOffset = yDist
        rotation = 67.5
    case .EastNorthEast:
        xOffset = xDist
        yOffset = yDist
        rotation = 22.5
    case .NorthNorthWest:
        xOffset = -xDist
        yOffset = yDist
        rotation = 112.5
    case .NorthWest:
        xOffset = -xDist
        yOffset = yDist
        rotation = 135.0
    case .WestNorthWest:
        xOffset = -xDist
        yOffset = yDist
        rotation = 157.5
    case .West:
        xOffset = -xDist
        yOffset = 0.0
        rotation = 180.0
    case .WestSouthWest:
        xOffset = -xDist
        yOffset = -yDist
        rotation = 202.5
    case .SouthWest:
        xOffset = -xDist
        yOffset = -yDist
        rotation = 225.0
    case .SouthSouthWest:
        xOffset = -xDist
        yOffset = -yDist
        rotation = 247.5
    case .South:
        xOffset = 0.0
        yOffset = -yDist
        rotation = 270.0
    case .SouthSouthEast:
        xOffset = xDist
        yOffset = -yDist
        rotation = 292.5
    case .SouthEast:
        xOffset = xDist
        yOffset = -yDist
        rotation = 315.0
    case .EastSouthEast:
        xOffset = xDist
        yOffset = -yDist
        rotation = 337.5
    case .East:
        xOffset = xDist
        yOffset = 0.0
        rotation = 0.0
    default:
        xOffset = 0.0
        yOffset = 0.0
    }
    
    
    return (xOffset, yOffset, rotation)
}

func createSuperBullet() -> SKSpriteNode {
    
    let superBullet = SKSpriteNode(imageNamed: "superBullet.png")
    superBullet.size = CGSize(width: 20.0, height: 20.0)
    superBullet.zPosition = 50
    superBullet.name = "superBullet"
    
    superBullet.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: superBullet.size.width, height: superBullet.size.height))
    superBullet.physicsBody?.affectedByGravity = false
    superBullet.physicsBody?.usesPreciseCollisionDetection = true
    superBullet.physicsBody?.categoryBitMask = superBulletCategory
    superBullet.physicsBody?.collisionBitMask = boundingBoxCategory | monsterCategory | brickCategory
    superBullet.physicsBody?.contactTestBitMask = boundingBoxCategory | monsterCategory | brickCategory
    
    return superBullet
}

func createProjectile() -> SKSpriteNode {

    let bullet = SKSpriteNode(imageNamed: "projectile")
    bullet.size = CGSize(width: 10.0, height: 7.0)
    bullet.zPosition = 50
    
    bullet.name = "bulletNode"
    bullet.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: bullet.size.width, height: bullet.size.height))
    bullet.physicsBody?.usesPreciseCollisionDetection = true
    bullet.physicsBody?.affectedByGravity = false
    bullet.physicsBody?.categoryBitMask = bulletCategory
    bullet.physicsBody?.collisionBitMask = bulletCategory | boundingBoxCategory | playerCategory | monsterCategory
    bullet.physicsBody?.contactTestBitMask = bulletCategory | boundingBoxCategory | playerCategory | monsterCategory
    
    return bullet
}

//get bullet impulse based on player direction and return in CGFloat
func getBulletImpulse(direction: PlayerDirection) -> (CGFloat, CGFloat) {
    
    var xImpulse:CGFloat = 0.0
    var yImpulse:CGFloat = 0.0
    
    let max:CGFloat = 2.0
    
    switch direction {
        
    case .North:
        xImpulse = 0.0
        yImpulse = max
    case .NorthNorthEast:
        xImpulse = max/2
        yImpulse = max
    case .NorthEast:
        xImpulse = max
        yImpulse = max
    case .EastNorthEast:
        xImpulse = max
        yImpulse = max/2
    case .NorthWest:
        xImpulse = -max
        yImpulse = max
    case .NorthNorthWest:
        xImpulse = -max/2
        yImpulse = max
    case .WestNorthWest:
        xImpulse = -max
        yImpulse = max/2
    case .South:
        xImpulse = 0.0
        yImpulse = -max
    case .WestSouthWest:
        xImpulse = -max
        yImpulse = -max/2
    case .SouthWest:
        xImpulse = -max
        yImpulse = -max
    case .SouthSouthWest:
        xImpulse = -max/2
        yImpulse = -max
    case .SouthSouthEast:
        xImpulse = max/2
        yImpulse = -max
    case .SouthEast:
        xImpulse = max
        yImpulse = -max
    case .EastSouthEast:
        xImpulse = max
        yImpulse = -max/2
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

    print("bullet impulses are: \(xImpulse, yImpulse)")
    
    return (xImpulse, yImpulse)
}











