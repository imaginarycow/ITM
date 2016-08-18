//
//  JoystickHelper.swift
//  Into The Maze
//
//  Created by ramiro beltran on 8/17/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    
    func setJoystickHandler() {
        
        //Mark: Joystick Handlers
        joystick.startHandler = { [unowned self] in
            
            //          guard let aN = self.Player else { return }
            //          aN.runAction(SKAction.sequence([SKAction.scaleTo(0.5, duration: 0.5), SKAction.scaleTo(1, duration: 0.5)]))
            
            Player!.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(self.TextureArray, timePerFrame: 0.2)))
            self.walking = true
            
        }
        
        //handles player position and rotation and gives direction for projectiles
        joystick.trackingHandler = { [unowned self] data in
            
            guard let plr = Player else { return }
            plr.position = CGPointMake(plr.position.x + (data.velocity.x * playerSpeed), plr.position.y + (data.velocity.y * playerSpeed))
            
            let x = data.velocity.x
            let y = data.velocity.y
            print("x:\(x)")
            print("y:\(y)")
            
            let maxX:CGFloat = joystickDiameter/2
            let maxY:CGFloat = joystickDiameter/2
            
            //check to see if x is positive
            if x > maxX * 0.25 {
                if y > maxY * 0.75 {
                    currentDirection = PlayerDirection.NorthNorthEast
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                    
                }else if y > maxY * 0.5 {
                    currentDirection = PlayerDirection.NorthEast
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                    
                }else if y > maxY * 0.25 {
                    currentDirection = PlayerDirection.EastNorthEast
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                    
                }else if y <= maxY * 0.25 && y >= -maxY * 0.25 {
                    currentDirection = PlayerDirection.East
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                    
                }else if y < -maxY * 0.75 {
                    currentDirection = PlayerDirection.SouthSouthEast
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                    
                }else if y < -maxY * 0.5 {
                    currentDirection = PlayerDirection.SouthEast
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                    
                }else if y < -maxY * 0.25 {
                    currentDirection = PlayerDirection.EastSouthEast
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                }
                
            }
            //check to see if x is negative
            if x < -maxX * 0.25 {
                if y > maxY * 0.75 {
                    currentDirection = PlayerDirection.NorthNorthWest
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                    
                }else if y > maxY * 0.5 {
                    currentDirection = PlayerDirection.NorthWest
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                    
                }else if y > maxY * 0.25 {
                    currentDirection = PlayerDirection.WestNorthWest
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                    
                }else if y <= maxY * 0.25 && y >= -maxY * 0.25 {
                    currentDirection = PlayerDirection.West
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                    
                }else if y < -maxY * 0.75 {
                    currentDirection = PlayerDirection.SouthSouthWest
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                    
                }else if y < -maxY * 0.5 {
                    currentDirection = PlayerDirection.SouthWest
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                    
                }else if y < -maxY * 0.25 {
                    currentDirection = PlayerDirection.WestSouthWest
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                }
                
            }
            //check to see if x is in center area
            if x >= -maxX * 0.25 && x <= maxX * 0.25 {
                if y > 0 {
                    currentDirection = PlayerDirection.North
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                    
                }else {
                    currentDirection = PlayerDirection.South
                    turnPlayer("player", node: Player!, direction: currentDirection)
                    turnNode("gun", node: playerGun, direction: currentDirection)
                }
            }
            
            print(currentDirection)
            
            
            
        }
        
        joystick.stopHandler = { [unowned self] in
            
            //          guard let aN = self.Player else { return }
            //          aN.runAction(SKAction.sequence([SKAction.scaleTo(1.5, duration: 0.5), SKAction.scaleTo(1, duration: 0.5)]))
            Player!.removeAllActions()
            Player!.texture = SKTexture(imageNamed: "PlayerWalk01.png")
            self.walking = false
            
        }
        //Mark: End Joystick Handlers
    }

    
}