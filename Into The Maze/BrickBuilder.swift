//
//  BrickBuilder.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/27/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

let numbOfBricks:Int = 10
let brickWidth = box1Width/CGFloat(numbOfBricks)
//let brickWidth = box1Width/CGFloat(numbOfBricks)
let brickHeight = 8.0 * scale


let startPoint = CGPointMake((box1.anchorPoint.x - box1Width/2), (box1.anchorPoint.y - box1Width/2)+brickHeight/2)
var lastPoint = CGPointMake(0.0, 0.0)

class Brick {
    
    class func createBrick(point:CGPoint, brickWidth: CGFloat, rotation:Double) -> SKSpriteNode {
        
        
        let brick = SKSpriteNode(imageNamed: "brickTexture.png")
        brick.size = CGSize(width: brickWidth, height: brickHeight)
        brick.position = CGPoint(x: point.x, y: point.y)
        brick.zPosition = 50.0
        brick.zRotation = CGFloat(rotation)
        brick.name = "brick"
        brick.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: brick.size.width, height: brick.size.height))
        brick.physicsBody?.affectedByGravity = false
        //brick.physicsBody?.dynamic = false
        brick.physicsBody?.mass = 1000
        brick.physicsBody?.usesPreciseCollisionDetection = true
        brick.physicsBody?.categoryBitMask = brickCategory
        brick.physicsBody?.collisionBitMask = playerCategory | monsterCategory
        brick.physicsBody?.contactTestBitMask = playerCategory | bulletCategory | monsterCategory
        
        return brick
    }
    
}
//only called when user has brick breaker ability
func removeBrick(node:SKNode) {
    print("attemting to remove brick")
    node.removeFromParent()
}


