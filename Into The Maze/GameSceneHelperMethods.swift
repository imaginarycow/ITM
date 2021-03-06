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
        
        let actionrun = SKAction.runBlock({
            
            self.totalTime += 1
            
            //create monsters every 3 seconds
            if self.totalTime % 3 == 0 && monsterCount < maxMonsterCount {
                
                self.createNewMonster(getRandomEnemyPoint())
                monsterCount += 1
                print("monster count: \(monsterCount)")
            }
        })
        self.timer.runAction(SKAction.repeatActionForever(SKAction.sequence([actionwait,actionrun])))

    }
    
    func setFinishFlag(position: CGPoint) {
        
        setEnemyAroundFlag()
        vc.playSoundEffect(.zombieSound)
        treasureTaken = true
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
        
        let fadeIn = SKAction.fadeAlphaTo(1.0, duration: 1.5)
        let fadeOut = SKAction.fadeAlphaTo(0.0, duration: 1.5)
        finishFlag.runAction((SKAction.repeatActionForever(SKAction.sequence([fadeIn,fadeOut]))))
    }
    
    //called when player killed in maze
    func playerDied() {
        
        vc.alarmSound?.pause()
        vc.alarmSound?.stop()
        vc.playSoundEffect(.zombieSound)
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
        box5 = SKSpriteNode()
        box6 = SKSpriteNode()
        box7 = SKSpriteNode()
        self.scene?.removeAllActions()
        self.scene?.removeAllChildren()
        addChild(notification)
        
        delay(2.0) {
            
            vc.gameSound?.pause()
            vc.gameSound?.stop()
            self.scene?.removeAllChildren()
            
            if adsRemoved == false && vc.interstitial.isReady && (adShowIndex % 2 == 0) {
                
                AdMob.sharedInstance.showInterstitial()
                
            }else {
                self.goBackToPreviousScene()
            }
            adShowIndex += 1
        }
    }
    
    func playerBeatMaze(level: Int) {
        
        vc.alarmSound?.pause()
        vc.alarmSound?.stop()
        
        let notification = SKLabelNode(text: "You Beat the Maze")
        notification.position = CGPoint(x: centerOfScene.x, y: centerOfScene.y + 60.0)
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
        
        let notification2 = SKLabelNode(text: "in \(minutes) minutes, \(seconds) seconds")
        notification2.position = CGPoint(x: centerOfScene.x, y: centerOfScene.y)
        notification2.fontName = labelFont
        notification2.fontColor = mazeColor
        notification2.fontSize = 30.0 * scale
        notification2.zPosition = 100
        
        let notification3 = SKLabelNode(text: "and killed \(monstersKilledInLevel) zombies!")
        notification3.position = CGPoint(x: centerOfScene.x, y: centerOfScene.y - 50.0)
        notification3.fontName = labelFont
        notification3.fontColor = mazeColor
        notification3.fontSize = 30.0 * scale
        notification3.zPosition = 100

        box1 = SKSpriteNode()
        box2 = SKSpriteNode()
        box3 = SKSpriteNode()
        box4 = SKSpriteNode()
        box5 = SKSpriteNode()
        box6 = SKSpriteNode()
        box7 = SKSpriteNode()
        self.scene?.removeAllActions()
        self.scene?.removeAllChildren()
        addChild(notification)
        addChild(notification2)
        addChild(notification3)
        
        vc.playSoundEffect(.zombieSound)
        delay(5.0) {
            vc.gameSound?.pause()
            vc.gameSound?.stop()
            self.scene?.removeAllChildren()
            
            if adsRemoved == false && vc.interstitial.isReady && (adShowIndex % 2 == 0){
                
                AdMob.sharedInstance.showInterstitial()
                
            }else {
                self.goBackToPreviousScene()
            }
            adShowIndex += 1
        }
        setHighScore(level)
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
            
            bulletSpeedX = getBulletImpulse(currentDirection).0 * 5
            bulletSpeedY = getBulletImpulse(currentDirection).1 * 5
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
        let treasureLabel = SKLabelNode(text: "Get Out!")
        treasureLabel.zPosition = 100
        treasureLabel.fontName = labelFont
        treasureLabel.fontSize = 24.0 * scale
        treasureLabel.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        treasureLabel.fontColor = .redColor()
        scene?.addChild(treasureLabel)
        delay(1.0) {
            treasureLabel.removeFromParent()
        }
    }
    
    
    
} //Mark: End Extension

