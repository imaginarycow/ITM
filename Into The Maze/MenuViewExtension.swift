//
//  MenuViewExtension.swift
//  Into The Maze
//
//  Created by ramiro beltran on 2/2/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
    
    
//    class Triangle {
//        
//        
//        class func createNewTriangle(scale: CGFloat, buffer: CGFloat, parent: SKSpriteNode, color:SKColor) -> SKShapeNode{
//            
//            //set length of side of Triangle based on scale passed in
//            //which determines size of triangle
//            let sideLength = boundingBox.size.width - boundingBox.size.width * scale
//            let sideA = (sideLength/2)
//            let sideB = sqrt((sideLength * sideLength) - (sideA * sideA))
//            let startPoint = CGPointMake(-sideLength/2, (-sideB/2 + 20) + buffer)
//            
//            let path:CGMutablePathRef = CGPathCreateMutable()
//            
//            //start drawing triangle at Gap
//            CGPathMoveToPoint(path, nil, 3 * sideLength/5, 0.0)
//            CGPathAddLineToPoint(path, nil, sideLength, 0.0)
//            CGPathAddLineToPoint(path, nil, sideLength/2, sideB)
//            CGPathAddLineToPoint(path, nil, 0.0, 0.0)
//            CGPathAddLineToPoint(path, nil, 2 * sideLength/5, 0.0)
//            
//            //build perpendicular bars based on scale of triangle
//            if scale == 0.1 {
//                CGPathAddLineToPoint(path, nil, 2 * sideLength/5, 60)
//            }else if scale == 0.5{
//                CGPathAddLineToPoint(path, nil, 2 * sideLength/5, 50)
//            }else{
//                
//            }
//            //CGPathCloseSubpath(path)
//            
//            let triangle = SKShapeNode(path: path)
//            triangle.lineWidth = 8.0
//            triangle.position = CGPoint(x: startPoint.x, y: startPoint.y)
//            triangle.physicsBody = SKPhysicsBody(edgeChainFromPath: path)
//            triangle.zPosition = 5
//            
//            //add triangle to assigned boundingbox(parent) from argument
//            parent.addChild(triangle)
//            return triangle
//        }
//    }

