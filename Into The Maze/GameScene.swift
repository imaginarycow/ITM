//
//  GameScene.swift
//  Into The Maze
//
//  Created by ramiro beltran on 2/1/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation
import GoogleMobileAds

var centerOfScene = CGPoint()
var activeScene: SKScene!
var boundingBox = SKSpriteNode()
var outerWall = [SKSpriteNode]()

var bulletNode = SKSpriteNode()
var bullets = [bulletNode]

//category bit masks
let boundingBoxCategory: UInt32 = 0x1 << 1
let bulletCategory: UInt32 = 0x1 << 2
let playerCategory: UInt32 = 0x1 << 3
let monsterCategory: UInt32 = 0x1 << 4
let brickCategory: UInt32 = 0x1 << 5
let centerCategory: UInt32 = 0x1 << 6
let abilityCategory: UInt32 = 0x1 << 7
let superBulletCategory: UInt32 = 0x1 << 8
let finishCategory: UInt32 = 0x1 << 9

let buttonRad = joystickDiameter/2
let abilityControl: SKShapeNode = SKShapeNode(circleOfRadius: buttonRad)

//the direction the player is currently moving the thumbstick in
var currentDirection:PlayerDirection!
var Player : SKSpriteNode?
var playerPosition: CGPoint = (Player?.position)!

let playerGun = SKSpriteNode(imageNamed: "gun.png")
var finishPosition = CGPoint(x: 0,y: 0)

var box1Width:CGFloat =  CGFloat((activeScene.size.height) * 1.0)
var box1 = SKSpriteNode()
var box2 = SKSpriteNode()
var box3 = SKSpriteNode()
var box4 = SKSpriteNode()
var box5 = SKSpriteNode()
var box6 = SKSpriteNode()
var box7 = SKSpriteNode()
var box8 = SKSpriteNode()

var timerIsFrozen = false

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var totalTime:Int = 0
    var levelScore = 0
    let scoreLabel = SKLabelNode(fontNamed: labelFont)
    var mazeShiftIndex = 0
    let timer = SKLabelNode(text: "")
    let center = SKSpriteNode(imageNamed: "diamond.png")
    let finishFlag = SKSpriteNode(imageNamed: "finish.png")
    //on screen buttons
    let backButton = SKLabelNode(text: "Quit")
    
    let shootControl = SKSpriteNode(imageNamed: "shootButton.png")
    
    var TextureArray = [SKTexture]()
    var walking: Bool = false
    var playerFacing = PlayerDirection.North
    
    let joystick = AnalogJoystick(diameter: joystickDiameter, colors: (.clearColor(), .clearColor()), images: (UIImage(named: "substrate.png"), UIImage(named: "stick.png")))
    
    
    override func didMoveToView(view: SKView) {
    
        
        //all mazeBuilds will be handled in each maze scene file
        
    }

    //call to all functions for new scene
    func createNewScene() {
        centerOfScene = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        activeScene = self
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        self.physicsWorld.contactDelegate = self
        
        monsterCount = 0
        monsterIndex = 0
        vc.playSoundEffect(.gameSound)
        createBackButton()
        createBoundingBox()
        createScoreLabel()
        createControls()
        backgroundColor = backgroundColor
        createNewPlayer()
        //createNewMonster()
        createCenter()
        setAbilityToken()
        AdMob.sharedInstance.delegate = self
        
        setJoystickHandler()
        
    }
    
    func createNewMonster(point: CGPoint) {
        
        let spawnImage = SKSpriteNode(imageNamed: "spiderWeb.png")
        spawnImage.size = CGSize(width: monsterSize * 1.5, height: monsterSize * 1.5)
        spawnImage.position = point
        spawnImage.zPosition = 50
        spawnImage.alpha = 0.0
        addChild(spawnImage)
        let fade = SKAction.fadeInWithDuration(1.5)
        spawnImage.runAction(fade)
        vc.playSoundEffect(.spawnSound)
        delay(1.5) {
            let monster = Monster(id: monsterIndex)
            monsterIndex += 1
            monster.position = point
            monster.size = CGSize(width: monsterSize, height: monsterSize)
            monster.zPosition = 100
            monster.name = "monster"
            
            monster.physicsBody = SKPhysicsBody(rectangleOfSize: monster.frame.size)
            monster.physicsBody?.usesPreciseCollisionDetection = true
            monster.physicsBody?.categoryBitMask = monsterCategory
            monster.physicsBody?.collisionBitMask = bulletCategory | boundingBoxCategory | playerCategory | brickCategory
            monster.physicsBody?.contactTestBitMask = bulletCategory | boundingBoxCategory | playerCategory | brickCategory
            monster.alpha = 0
            
            self.addChild(monster)
            monster.runAction(fade)
            turnNode("monster", node: monster, direction: .North)
            spawnImage.removeFromParent()
        }
        
    }
    
    func createNewPlayer() {
        
        //create texture array for player movement
        TextureArray = createTextureArray()
        
        Player = NewPlayer.createNewPlayer()
        Player!.name = "Player"
        addChild(Player!)
        
        //give player's start direction and location
        Player?.position = CGPoint(x: playerSpawn.x, y: playerSpawn.y)
        currentDirection = PlayerDirection.East
        turnNode("player", node: Player!, direction: currentDirection)
        
        playerGun.zPosition = 50
        playerGun.size = CGSize(width: (Player?.size.width)!, height: Player!.size.height * 1.5)
        turnNode("gun", node: playerGun, direction: currentDirection)
        playerGun.alpha = 1.0
        playerGun.position = (Player?.position)!
        addChild(playerGun)
    }
    
        
    func createBackButton() {
        
        backButton.fontColor = .redColor()
        backButton.fontSize = 14.0
        backButton.position = CGPoint(x: self.size.width * 0.9, y: self.size.height * 0.92)
        backButton.zPosition = 50
        backButton.fontName = labelFont
        self.addChild(backButton)
    }
    
    func createScoreLabel() {
        
        scoreLabel.name = "scoreLabel"
        scoreLabel.fontColor = mazeColor
        scoreLabel.fontSize = 16.0
        scoreLabel.text = String(format: "Score: %04u", levelScore)
        scoreLabel.position = CGPoint(x: frame.size.width * 0.1, y: frame.size.height * 0.92)
        scene!.addChild(scoreLabel)
    }
    
    func updateScore(points: Int) {
        levelScore += points
        
        let texture = SKTexture(imageNamed: "spark.png")
        let sparks = createSpark(texture, point: CGPointZero, target: scoreLabel)
        scoreLabel.addChild(sparks)
        
        delay(0.3) {
            sparks.removeFromParent()
            sparks.targetNode = nil
            sparks.resetSimulation()
        }

        scoreLabel.text = String(format: "Score: %04u", levelScore)
    }
        
    func createControls() {
        
        joystick.position = CGPoint(x: scene!.size.width * 0.085, y: scene!.size.height * 0.25)
        //joystick.physicsBody = SKPhysicsBody(circleOfRadius: buttonRad)
        scene?.addChild(joystick)
        
        shootControl.size = CGSize(width: buttonRad * 2, height: buttonRad * 2)
        shootControl.position = CGPoint(x: scene!.size.width * 0.91, y: scene!.size.height * 0.25)
        shootControl.zPosition = 100
        shootControl.name = "shootControl"
        
        //shootControl.physicsBody = SKPhysicsBody(circleOfRadius: buttonRad)
        scene!.addChild(shootControl)
        
        
        abilityControl.position = CGPoint(x: scene!.size.width * 0.91, y: scene!.size.height * 0.60)
        abilityControl.fillColor = SKColor.whiteColor()
        abilityControl.strokeColor = .clearColor()
        //abilityControl.physicsBody = SKPhysicsBody(circleOfRadius: buttonRad)
        
        setAbilityForUse(abilityTokens)
 
        switch abilitySelected {
        case ability.brickBreaker:
            abilityControl.fillTexture = SKTexture(imageNamed: "brickBreaker.png")
        case ability.instaKill:
            abilityControl.fillTexture = SKTexture(imageNamed: "instakill.png")
        case ability.timeFreeze:
            abilityControl.fillTexture = SKTexture(imageNamed: "timeFreeze.png")
        default:
            abilityControl.fillTexture = SKTexture(imageNamed: "abilityButton")
        }
        
        abilityControl.zPosition = 100
        abilityControl.name = "abilityControl"
        scene!.addChild(abilityControl)
    }
    
    //box that encloses entire scene
    //so as not to let player go off-screen
    func createBoundingBox() {

        boundingBox.color = SKColor.blackColor()
        boundingBox.size = CGSize(width: scene!.size.width, height: scene!.size.height)
        boundingBox.position = CGPointMake(scene!.size.width/2, scene!.size.height/2)
        boundingBox.zPosition = 0
        boundingBox.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: boundingBox.anchorPoint.x - boundingBox.size.width/2, y: boundingBox.anchorPoint.y - boundingBox.size.height/2, width: boundingBox.size.width, height: boundingBox.size.height))
        boundingBox.physicsBody?.affectedByGravity = false
        boundingBox.physicsBody?.usesPreciseCollisionDetection = true
        boundingBox.physicsBody?.categoryBitMask = boundingBoxCategory
        boundingBox.physicsBody?.collisionBitMask = playerCategory
        boundingBox.physicsBody?.contactTestBitMask = bulletCategory | playerCategory
        boundingBox.name = "boundingBox"
        scene!.addChild(boundingBox)

    }
    
    //create target area for player to reach
    func createCenter() {
        
        center.position = CGPointMake(0.0, 0.0)
        center.size = CGSize(width: 20.0 * scale, height: 20.0 * scale)
        center.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: center.size.width, height: center.size.height))
        center.physicsBody?.usesPreciseCollisionDetection = true
        center.physicsBody?.categoryBitMask = centerCategory
        center.physicsBody?.contactTestBitMask = playerCategory
        center.zPosition = 11
        center.name = "center"
        box1.addChild(center)
        
    }
    

    func goBackToPreviousScene() {
        
        let mazeSelectScene = MazeSelectScene()
        mazeSelectScene.size = self.size
        mazeSelectScene.scaleMode = self.scaleMode
        
        monstersArray = []
        Player?.removeFromParent()
        abilityToken = SKSpriteNode()
        boundingBox.removeAllChildren()
        boundingBox.removeFromParent()
        box1.removeAllChildren()
        box2.removeAllChildren()
        box3.removeAllChildren()
        box4.removeAllChildren()
        box1 = SKSpriteNode()
        box2 = SKSpriteNode()
        box3 = SKSpriteNode()
        box4 = SKSpriteNode()
        box5 = SKSpriteNode()
        box6 = SKSpriteNode()
        box7 = SKSpriteNode()
        self.removeAllActions()
        self.removeAllChildren()
        self.scene?.removeAllActions()
        self.scene?.removeAllChildren()
        
        let transition = SKTransition.crossFadeWithDuration(1.0)
        self.scene!.view?.presentScene(mazeSelectScene, transition: transition)
        self.scene?.removeFromParent()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        shootControl.alpha = 1.0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch! {
            let location = touch.locationInNode(self)
            
            //check to see if a bullet should be fired
            if shootControl.containsPoint(location) {
                
                shootControl.alpha = 0.4
                
                print("Bullet fired")
                
                //get bullet direction, rotation and speed
                let xOffset:CGFloat = getBulletOffset(currentDirection).0
                let yOffset:CGFloat = getBulletOffset(currentDirection).1
                
                var bulletSpeedX:CGFloat = 0.0
                var bulletSpeedY:CGFloat = 0.0
                
                bulletSpeedX = getBulletImpulse(currentDirection).0
                bulletSpeedY = getBulletImpulse(currentDirection).1
                let rotation = getBulletOffset(currentDirection).2

                bulletNode = createProjectile()
                bulletNode.position = CGPoint(x: Player!.position.x + xOffset, y: Player!.position.y + yOffset)
                bulletNode.zRotation = DegToRad(rotation)
                bullets.insert(bulletNode, atIndex: 0) 
                addChild(bulletNode)
                vc.playSoundEffect(Sound.gunSound)
                
                let vector = CGVectorMake(bulletSpeedX, bulletSpeedY)
                bullets[0].physicsBody?.applyImpulse(vector)
                
            }
            
            if abilityControl.containsPoint(location) {
                
                if abilityTokens > 0 {
                    useAbility(abilitySelected)
                    if abilitySelected == .brickBreaker {
                        print("attempting to call shootSuperBullet()")
                        shootSuperBullet()
                    }
                }
            }
            
            if backButton.containsPoint(location) {
                vc.alarmSound?.pause()
                vc.alarmSound?.stop()
                vc.gameSound?.pause()
                vc.gameSound?.stop()
                vc.playSoundEffect(Sound.buttonPress)
                scene?.removeAllChildren()
                
                if adsRemoved == false {
                    
                    AdMob.sharedInstance.showInterstitial()
                }else {
                    goBackToPreviousScene()
                }
                
            }
        }
    }

    func didBeginContact(contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        let contactPoint: CGPoint = contact.contactPoint
        
        print("firstBody bitmask: \(firstBody.categoryBitMask)")
        print("secondBody bitmask: \(secondBody.categoryBitMask)")
        
        if (firstBody.categoryBitMask == boundingBoxCategory && secondBody.categoryBitMask == bulletCategory) {
            print("bullet bounding box")
            removeBullet(secondBody.node!)
            createAnimationAtPoint(self, point: contactPoint)
        }
        if (firstBody.categoryBitMask == bulletCategory && secondBody.categoryBitMask == brickCategory) {
            print("bullet hit brick wall")
            removeBullet(firstBody.node!)
            createAnimationAtPoint(self, point: contactPoint)
        }
        if (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == monsterCategory) {
            print("Monster got player, player died")
            playerDied()
        }
        if (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == centerCategory) {
            print("Player got treasure")
            vc.playSoundEffect(.redeemSound)
            removeTreasure(secondBody.node!)
            setFinishFlag(finishPosition)
            //TODO: Show animation
        }
        if (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == abilityCategory) {
            print("player got ability token")
            abilityTokens += 1
            updateScore(50)
            vc.playSoundEffect(.redeemSound)
            removeToken(secondBody.node!)
            setAbilityForUse(abilityTokens)
        }
        if (firstBody.categoryBitMask == bulletCategory && secondBody.categoryBitMask == monsterCategory) {
            print("bullet hit enemy")
            removeEnemy(secondBody.node!)
            removeBullet(firstBody.node!)
            updateScore(25)
        }
        if (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == finishCategory) {
            print("Player beat maze")
            playerBeatMaze(level)
        }
        if (firstBody.categoryBitMask == brickCategory && secondBody.categoryBitMask == superBulletCategory) {
            print("superBullet hit wall")
            if let superNode = secondBody.node {
                removeBullet(superNode)
            }
            vc.playSoundEffect(.explosionSound)
            createAnimationAtPoint(self, point: contactPoint)
            removeBrick(firstBody.node!)
        }
        if (firstBody.categoryBitMask == boundingBoxCategory && secondBody.categoryBitMask == superBulletCategory) {
            print("superBullet hit boundingBox")
            if let superNode = secondBody.node {
                removeBullet(superNode)
            }
            createAnimationAtPoint(self, point: contactPoint)
            removeBrick(firstBody.node!)
        }
        if (firstBody.categoryBitMask == monsterCategory && secondBody.categoryBitMask == superBulletCategory) {
            print("superBullet hit monster")
            if let superNode = secondBody.node {
                removeBullet(superNode)
            }
            removeEnemy(firstBody.node!)
        }

    }
    
    override func update(currentTime: NSTimeInterval) {
        
        playerGun.position = (Player!.position)
        
        if checkForInBounds(Player!) == false {
            print("player went out of bounds, replacing at spawn point")
            Player?.position = playerSpawn
        }
        
        // monster movement
        var monsterArray: [Monster] = []
        //find all nodes in current scene with name "monster"
        activeScene.enumerateChildNodesWithName("monster", usingBlock: { (node, stop) -> Void in
            if node.name == "monster" {
                let monster = node as! Monster
                monsterArray.append(monster)
            }
        })
        for monster in monsterArray {
            monster.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(monsterTextures, timePerFrame: 0.2)))
        }
        
        for monster in monsterArray {
            if checkForInBounds(monster) == false {
                print("monster went out of bounds, placing at new spawn point")
                monster.position = getRandomEnemyPoint()
            }else {
                let firstPosition = monster.position
                monster.position = monster.moveMonster(monster.position, point2: Player!.position)
                
                //check if monster is stuck on wall and teleport accordingly
                if (monster.position.x > Player?.position.x) && (monster.position.x >= firstPosition.x) {
                    
                    monster.position = monster.teleportMonster(monster.position, direction: .left)
                }
                if (monster.position.x < Player?.position.x) && (monster.position.x <= firstPosition.x) {
                    
                    monster.position = monster.teleportMonster(monster.position, direction: .right)
                }
                if (monster.position.y > Player?.position.y) && (monster.position.y >= firstPosition.y) {
                    
                    monster.position = monster.teleportMonster(monster.position, direction: .down)
                }
                if (monster.position.y < Player?.position.y) && (monster.position.y <= firstPosition.y) {
                    
                    monster.position = monster.teleportMonster(monster.position, direction: .up)
                }
//                    if (monster.position.x > Player?.position.x) && (monster.position.y == Player?.position.y) {
//                        monster.position = monster.teleportMonster(monster.position, direction: .left)
//                    }
//                    if (monster.position.y < Player?.position.y) && (monster.position.x == Player?.position.x) {
//                        monster.position = monster.teleportMonster(monster.position, direction: .up)
//                    }
//                    if (monster.position.y > Player?.position.y) && (monster.position.x == Player?.position.x) {
//                        monster.position = monster.teleportMonster(monster.position, direction: .down)
//                    }

                
            }
        }
    }
    
        
}
            

    

