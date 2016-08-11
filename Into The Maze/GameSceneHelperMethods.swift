//
//  HelperMethods.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/5/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

//creates explosion sprite at contact point
func createAnimationAtPoint(scene: SKScene, point: CGPoint, imageNamed: String = "explosion.png") {
    
    let explosion = SKSpriteNode(imageNamed: imageNamed)
    explosion.position = point
    explosion.size = CGSize(width: 30.0 * scale, height: 30.0 * scale)
    explosion.zPosition = 101
    scene.addChild(explosion)
    
    delay(0.1) {
        explosion.removeFromParent()
    }
    
}

func checkForInBounds(node: SKSpriteNode) -> Bool{
    var isInbounds = true
    
    if (node.position.x > activeScene.size.width) || (node.position.x < 0.0) {
        isInbounds = false
    }
    if (node.position.y > activeScene.size.height) || (node.position.y < 0.0) {
        isInbounds = false
    }
    
    return isInbounds
}

//GameScene Helper Methods
extension GameScene {
    
    func updateClock() {
        totalTime = 0
        let actionwait = SKAction.waitForDuration(1.0)
        var seconds = 0
        let actionrun = SKAction.runBlock({
            
            self.totalTime += 1
        })
        self.timer.runAction(SKAction.repeatActionForever(SKAction.sequence([actionwait,actionrun])))

    }
    
    func setFinishFlag(position: CGPoint) {
        
        finishFlag.size = CGSize(width: 20.0 * scale, height: 30.0 * scale)
        finishFlag.position = position
        finishFlag.zPosition = 100
        let rad: CGFloat = finishFlag.size.width
        finishFlag.physicsBody = SKPhysicsBody(circleOfRadius: rad)
        finishFlag.physicsBody?.usesPreciseCollisionDetection = true
        finishFlag.physicsBody?.categoryBitMask = finishCategory
        finishFlag.physicsBody?.contactTestBitMask = playerCategory
        finishFlag.physicsBody?.collisionBitMask = playerCategory
        self.addChild(finishFlag)
    }
    
    //called when player killed in maze
    func playerDied() {
        
        vc.alarmSound?.pause()
        vc.alarmSound?.stop()
        
        let notification = SKLabelNode(text: "You Died!")
        notification.position = centerOfScene
        notification.fontName = labelFont
        notification.fontColor = .redColor()
        notification.fontSize = 50.0 * scale
        notification.zPosition = 100
        box1 = SKSpriteNode()
        box2 = SKSpriteNode()
        box3 = SKSpriteNode()
        box4 = SKSpriteNode()
        self.scene?.removeAllActions()
        self.scene?.removeAllChildren()
        addChild(notification)
        
        delay(2.0) {
            
            vc.gameSound?.pause()
            vc.gameSound?.stop()
            self.scene?.removeAllChildren()
            
            if adsRemoved == false {
                
                AdMob.sharedInstance.showInterstitial()
            }else {
                self.goBackToPreviousScene()
            }

        }
    }
    
    func playerBeatMaze(level: Int) {
        
        vc.alarmSound?.pause()
        vc.alarmSound?.stop()
        
        let notification = SKLabelNode(text: "You Beat the Maze")
        notification.position = centerOfScene
        notification.fontName = labelFont
        notification.fontColor = mazeColor
        notification.fontSize = 50.0 * scale
        notification.zPosition = 100
        
        //convert time if seconds > 60 
        var minutes = 0
        var seconds = totalTime
        if totalTime >= 60 {
            minutes = (totalTime / 60) % 60
            seconds = (totalTime % 60)
        }
        
        let notification2 = SKLabelNode(text: "in \(minutes) minutes, \(seconds) seconds!")
        notification2.position = CGPoint(x: centerOfScene.x, y: centerOfScene.y - 60.0)
        notification2.fontName = labelFont
        notification2.fontColor = mazeColor
        notification2.fontSize = 30.0 * scale
        notification2.zPosition = 100
        box1 = SKSpriteNode()
        box2 = SKSpriteNode()
        box3 = SKSpriteNode()
        box4 = SKSpriteNode()
        self.scene?.removeAllActions()
        self.scene?.removeAllChildren()
        addChild(notification)
        addChild(notification2)
        
        delay(3.0) {
            vc.gameSound?.pause()
            vc.gameSound?.stop()
            self.scene?.removeAllChildren()
            
            if adsRemoved == false {
                
                AdMob.sharedInstance.showInterstitial()
            }else {
                self.goBackToPreviousScene()
            }
            
        }

    }
    
    //super bullet for brick breaker ability
    func shootSuperBullet() {
        print("shooting super bullet")
        
        //get bullet direction, rotation and speed
        if let plr = Player {
            
            let xOffset:CGFloat = getBulletOffset(currentDirection).0
            let yOffset:CGFloat = getBulletOffset(currentDirection).1
            
            var bulletSpeedX:CGFloat = 0.0
            var bulletSpeedY:CGFloat = 0.0
            
            bulletSpeedX = getBulletImpulse(currentDirection).0 * 10
            bulletSpeedY = getBulletImpulse(currentDirection).1 * 10
            let rotation = getBulletOffset(currentDirection).2
            let superBullet = createSuperBullet()
            superBullet.name = "superB"
            superBullet.position = CGPoint(x: plr.position.x + xOffset, y: plr.position.y + yOffset)
            superBullet.zRotation = DegToRad(rotation)
            
            addChild(superBullet)
            //check to see if super bullet has already collided with wall before applying vector
            if self.childNodeWithName("superB")?.parent != nil {
                
                let vector = CGVectorMake(bulletSpeedX, bulletSpeedY)
                superBullet.physicsBody?.applyImpulse(vector)
            }
            

        }
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
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)
                    
                }else if y > maxY * 0.5 {
                    currentDirection = PlayerDirection.NorthEast
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)

                }else if y > maxY * 0.25 {
                    currentDirection = PlayerDirection.EastNorthEast
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)

                }else if y <= maxY * 0.25 && y >= -maxY * 0.25 {
                    currentDirection = PlayerDirection.East
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)

                }else if y < -maxY * 0.75 {
                    currentDirection = PlayerDirection.SouthSouthEast
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)

                }else if y < -maxY * 0.5 {
                    currentDirection = PlayerDirection.SouthEast
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)

                }else if y < -maxY * 0.25 {
                    currentDirection = PlayerDirection.EastSouthEast
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)
                }
                
            }
            //check to see if x is negative
            if x < -maxX * 0.25 {
                if y > maxY * 0.75 {
                    currentDirection = PlayerDirection.NorthNorthWest
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)
                    
                }else if y > maxY * 0.5 {
                    currentDirection = PlayerDirection.NorthWest
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)
                    
                }else if y > maxY * 0.25 {
                    currentDirection = PlayerDirection.WestNorthWest
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)
                    
                }else if y <= maxY * 0.25 && y >= -maxY * 0.25 {
                    currentDirection = PlayerDirection.West
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)
                    
                }else if y < -maxY * 0.75 {
                    currentDirection = PlayerDirection.SouthSouthWest
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)
                    
                }else if y < -maxY * 0.5 {
                    currentDirection = PlayerDirection.SouthWest
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)
                    
                }else if y < -maxY * 0.25 {
                    currentDirection = PlayerDirection.WestSouthWest
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)
                }

            }
            //check to see if x is in center area
            if x >= -maxX * 0.25 && x <= maxX * 0.25 {
                if y > 0 {
                    currentDirection = PlayerDirection.North
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)
                    
                }else {
                    currentDirection = PlayerDirection.South
                    self.turnNode(Player!, direction: currentDirection)
                    self.turnNode(playerBase, direction: currentDirection)
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

    
} //Mark: End Extension

