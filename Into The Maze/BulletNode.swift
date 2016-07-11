//
//  BulletNode.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/4/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

let bulletSpeedX:CGFloat = 50.0
let bulletSpeedY:CGFloat = 0.0

func createProjectile() -> SKSpriteNode {
    
    //let shooterNode = self.childNodeWithName("Player")
    //let shooterPosition = shooterNode!.position
    //let shooterWidth = shooterNode!.frame.size.width
    
    let bullet = SKSpriteNode(imageNamed: "bullet")
    bullet.size = CGSize(width: 20.0, height: 20.0)
    bullet.position = CGPointZero
    bullet.zPosition = 50
    
    bullet.name = "bulletNode"
    bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.frame.size)
    
    bullet.physicsBody?.usesPreciseCollisionDetection = true
    
    bullet.physicsBody?.categoryBitMask = bulletCategory
    bullet.physicsBody?.collisionBitMask = bulletCategory | boundingBoxCategory | playerCategory
    bullet.physicsBody?.contactTestBitMask = bulletCategory | boundingBoxCategory | playerCategory
    
    
    
    return bullet
}
