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
    
    func setJoystickHandler() {
        
        //Mark: Joystick Handlers
        joystick.startHandler = { [unowned self] in
            
            //          guard let aN = self.Player else { return }
            //          aN.runAction(SKAction.sequence([SKAction.scaleTo(0.5, duration: 0.5), SKAction.scaleTo(1, duration: 0.5)]))
            
            self.Player!.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(self.TextureArray, timePerFrame: 0.2)))
            self.walking = true
            
        }
        
        //handles player position and rotation and gives direction for projectiles
        joystick.trackingHandler = { [unowned self] data in
            
            guard let plr = self.Player else { return }
            plr.position = CGPointMake(plr.position.x + (data.velocity.x * playerSpeed), plr.position.y + (data.velocity.y * playerSpeed))
            let x = data.velocity.x
            let y = data.velocity.y
            print("x:\(x)")
            print("y:\(y)")
            
            let xNum:CGFloat = 10.0
            let yNum:CGFloat = 15.0
            
            
            if x > xNum {
                if y < yNum && y > -yNum {
                    currentDirection = PlayerDirection.East
                    self.turnPlayer(currentDirection)
                }else if y >= yNum {
                    currentDirection = PlayerDirection.NorthEast
                    self.turnPlayer(currentDirection)
                } else {
                    currentDirection = PlayerDirection.SouthEast
                    self.turnPlayer(currentDirection)
                }
                //test if x < 0
            }else if x < -xNum{
                if y < yNum && y > -yNum {
                    currentDirection = PlayerDirection.West
                    self.turnPlayer(currentDirection)
                }else if y >= yNum {
                    currentDirection = PlayerDirection.NorthWest
                    self.turnPlayer(currentDirection)
                }else {
                    currentDirection = PlayerDirection.SouthWest
                    self.turnPlayer(currentDirection)
                }
                //test if x == 0
            }else {
                if y > 0 {
                    currentDirection = PlayerDirection.North
                    self.turnPlayer(currentDirection)
                }else {
                    currentDirection = PlayerDirection.South
                    self.turnPlayer(currentDirection)
                }
                
            }
            print(currentDirection)
            
            
            
        }
        
        joystick.stopHandler = { [unowned self] in
            
            //          guard let aN = self.Player else { return }
            //          aN.runAction(SKAction.sequence([SKAction.scaleTo(1.5, duration: 0.5), SKAction.scaleTo(1, duration: 0.5)]))
            self.Player!.removeAllActions()
            self.Player!.texture = SKTexture(imageNamed: "PlayerWalk01.png")
            self.walking = false
            
        }
        //Mark: End Joystick Handlers
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

