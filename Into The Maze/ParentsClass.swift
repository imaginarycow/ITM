//
//  ParentsClass.swift
//  Into The Maze
//
//  Created by ramiro beltran on 8/12/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

class Parent {
    
    class func newParent(point: CGPoint, color: SKColor = .redColor(), size: CGSize) -> SKSpriteNode {
        let parent = SKSpriteNode()
        
        parent.position = point
        parent.zPosition = parentZPosition
        parent.color = color
        parent.size = size
        
        
        return parent
    }
}