//
//  MazeBuilders.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/5/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

//triangle Maze Builder
class Triangle {
    
    
    class func createTriangle(scene: SKScene, scale: CGFloat, buffer: CGFloat, color:SKColor) -> SKShapeNode {
        
        //set length of side of Triangle based on scale passed in
        //which determines size of triangle
        let sideLength = (scene.size.height * 0.6) * scale
        let sideA = (sideLength/2)
        let sideB = sqrt((sideLength * sideLength) - (sideA * sideA))
        let startPoint = CGPointMake(-sideLength/2, (-sideB/2 + 20) + buffer)
        
        let path:CGMutablePathRef = CGPathCreateMutable()
        
        //start drawing triangle at Gap
        CGPathMoveToPoint(path, nil, 3 * sideLength/5, 0.0)
        CGPathAddLineToPoint(path, nil, sideLength, 0.0)
        CGPathAddLineToPoint(path, nil, sideLength/2, sideB)
        CGPathAddLineToPoint(path, nil, 0.0, 0.0)
        CGPathAddLineToPoint(path, nil, 2 * sideLength/5, 0.0)
        
        //build perpendicular bars based on scale of triangle
        if scale == 0.1 {
            CGPathAddLineToPoint(path, nil, 2 * sideLength/5, 60)
        }else if scale == 0.5 {
            CGPathAddLineToPoint(path, nil, 2 * sideLength/5, 50)
        }else{
            
        }
        
        let triangle = SKShapeNode(path: path)
        triangle.lineWidth = 8.0
        triangle.strokeColor = mazeColor
        triangle.position = CGPoint(x: startPoint.x, y: startPoint.y)
        triangle.physicsBody = SKPhysicsBody(edgeChainFromPath: path)
        triangle.zPosition = 20
        triangle.name = "triangle"
        

        return triangle
    }
    
    class func beginningAnimation(tri1:SKSpriteNode,tri2:SKSpriteNode,tri3:SKSpriteNode) {
        let delay = SKAction.waitForDuration(0.3)
        let rotate = SKAction.rotateByAngle(CGFloat(2*M_PI), duration: 2.0)
        tri1.runAction(SKAction.sequence([delay, rotate]))
        //tri2.runAction(SKAction.sequence([delay, rotate]))
        tri3.runAction(SKAction.sequence([delay, rotate]))
        
        //tri2.runAction(SKAction.sequence([delay, rotate]))
        let del = SKAction.waitForDuration(0.3)
        let rot = SKAction.rotateByAngle(CGFloat(-2*M_PI), duration: 2.0)
        tri2.runAction(SKAction.sequence([del, rot]))
        
    }

    
    class func getSpawnPoint(scale:CGFloat) -> CGPoint {
        let sideLength = boundingBox.size.width - boundingBox.size.width * scale
        let point:CGPoint = CGPointMake(2.5 * sideLength/5, 0.0)
        return point
    }
} //End of Triangle Class
