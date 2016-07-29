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

