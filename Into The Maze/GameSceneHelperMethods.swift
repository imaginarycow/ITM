//
//  HelperMethods.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/5/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit


//GameScene Helper Methods
extension GameScene {
    
    //maze shift timer
    func updateClock() {
        
        timer.position = CGPoint(x: frame.size.width * 0.15, y: frame.size.height * 0.80)
        timer.fontName = labelFont
        timer.fontSize = 18.0
        timer.fontColor = .redColor()
        self.addChild(timer)

        let actionwait = SKAction.waitForDuration(1.0)
        var seconds = 15
        let actionrun = SKAction.runBlock({
            
            self.timer.text = "Maze Shift in: \(seconds)"
            if seconds == 3 {
                vc.playSoundEffect(Sound.alarmSound)
            }
            if seconds == 0 {
                //TODO: mazeShift()
                vc.alarmSound!.stop()
                seconds = 16
            }
            
            seconds -= 1
            //if timesecond == mazeShift()

            
        })
        self.timer.runAction(SKAction.repeatActionForever(SKAction.sequence([actionwait,actionrun])))
    }
    
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

