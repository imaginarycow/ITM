//
//  HelperMethods.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/5/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit


import SpriteKit


//GameScene Helper Methods
extension GameScene {
    
    func loadSelectedMaze(level: Int) {
        
        switch level {
        case 1:
            loadMaze1()
        case 2:
            loadMaze2()
        case 3:
            loadMaze1()
        case 4:
            loadMaze1()
        case 5:
            loadMaze2()
        case 6:
            loadMaze1()
        case 7:
            loadMaze1()
        case 8:
            loadMaze1()
        case 9:
            loadMaze2()
        case 10:
            loadMaze1()
        case 11:
            loadMaze2()
        default:
            loadMaze1()
        }
        
        createCenter()
        
    }
    
    func removeTreasure(node: SKNode) {
        node.removeFromParent()
        let treasureLabel = SKLabelNode(text: "Got the Treasure")
        treasureLabel.zPosition = 100
        treasureLabel.fontName = labelFont
        treasureLabel.fontSize = 24.0
        treasureLabel.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        treasureLabel.fontColor = .greenColor()
        scene?.addChild(treasureLabel)
        delay(1.0) {
            treasureLabel.removeFromParent()
        }
    }
    

    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }

    
    //convert degrees to radians
    func DegToRad(degrees: Double)->CGFloat {
        return CGFloat(degrees * M_PI / 180.0)
    }
    
} //Mark: End Extension

