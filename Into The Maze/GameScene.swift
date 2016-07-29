//
//  GameScene.swift
//  Into The Maze
//
//  Created by ramiro beltran on 2/1/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit
import GoogleMobileAds



var boundingBox = SKSpriteNode()
var outerWall = [SKSpriteNode]()

var bulletNode = SKSpriteNode()
var bullets = [bulletNode]

let boundingBoxCategory: UInt32 = 0x1 << 1
let bulletCategory: UInt32 = 0x1 << 2
let playerCategory: UInt32 = 0x1 << 3
let monsterCategory: UInt32 = 0x1 << 4
let brickCategory: UInt32 = 0x1 << 5

//the direction the player is currently moving the thumbstick in
var currentDirection:PlayerDirection!

var box1Width:CGFloat = 0.0
let box1 = SKSpriteNode()

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    let center = SKShapeNode(circleOfRadius: 7.0)
    //on screen buttons
    let backButton = SKLabelNode(text: "Quit")
    let shootControl: SKShapeNode = SKShapeNode(circleOfRadius: 40.0 * scale)
    let abilityControl: SKShapeNode = SKShapeNode(circleOfRadius: 40.0 * scale)
    
    var TextureArray = [SKTexture]()
    var walking: Bool = false
    var playerFacing = PlayerDirection.North
    
    var Player : SKSpriteNode?
    let joystick = AnalogJoystick(diameter: 80.0 * scale, colors: (.clearColor(), .clearColor()), images: (UIImage(named: "substrate.png"), UIImage(named: "stick.png")))
    
    

    override func didMoveToView(view: SKView) {
    
        box1Width = CGFloat((scene?.size.height)! * 0.85)
        box1.size = CGSize(width: box1Width, height: box1Width)
        box1.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        box1.zPosition = 5
        //box1.color = .orangeColor()
        self.addChild(box1)

        //all calls will be handled in each maze scene
        createNewScene()
        
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        self.physicsWorld.contactDelegate = self
        
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
        
        
        loadSelectedMaze(level) 
    }
    
    override func willMoveFromView(view: SKView) {
        

    }

    //call to all functions for new scene
    func createNewScene() {
        
        createBackButton()
        createBoundingBox()
        createScoreLabel()
        //levelLabel(level)
        createControls()
        backgroundColor = backgroundColor
        //mazeShiftLabel()
        createNewPlayer()
        //createNewMonster()
        AdMob.sharedInstance.delegate = self
    }
    
    func createNewMonster() {
        
        let monster = Monster.newMonster()
        monster.position = CGPoint(x: (scene?.size.width)!/2, y: (scene?.size.height)! * 0.9)
        addChild(monster)
    }
    
    func createNewPlayer() {
        
        //create texture array for player movement
        TextureArray = createTextureArray()
        
        self.Player = NewPlayer.createNewPlayer()
        Player!.name = "Player"
        
        addChild(Player!)
        
        //give player's start direction and location
        Player?.position = CGPoint(x: ((scene?.size.width)! * 0.2), y: (scene?.size.height)!/2)
        currentDirection = PlayerDirection.East
        turnPlayer(currentDirection)
    }
    
    func turnPlayer(direction: PlayerDirection) {
        
        var deg = 0.0
        
        switch direction {
            
        case .North:
            deg = 0.0
        case .NorthEast:
            deg = -45.0
        case .NorthWest:
            deg = 45.0
        case .South:
            deg = 180.0
        case .SouthEast:
            deg = 220.0
        case .SouthWest:
            deg = 135.0
        case .East:
            deg = 270.0
        case .West:
            deg = 90.0
        default:
            deg = 0.0
        }
        
        Player?.zRotation = DegToRad(deg)
        currentDirection = direction
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
        
        let scoreLabel = SKLabelNode(fontNamed: "RUBBBI__")
        scoreLabel.name = "scoreLabel"
        scoreLabel.fontColor = mazeColor
        scoreLabel.fontSize = 16.0
        scoreLabel.text = String(format: "Score: %04u", 0)
        scoreLabel.position = CGPoint(x: frame.size.width * 0.1, y: frame.size.height * 0.92)
        scene!.addChild(scoreLabel)
    }
    
    func levelLabel(level: Int) {
        
        let levelLabel = SKLabelNode(fontNamed: "RUBBBI__")
        levelLabel.name = "levelLabel"
        levelLabel.fontColor = .yellowColor()
        levelLabel.text = "Level: \(level)"
        levelLabel.position = CGPoint(x: frame.size.width/2, y: frame.size.height * 0.80)
        levelLabel.zPosition = 50.0
        scene!.addChild(levelLabel)
    }
    
    func mazeShiftLabel() {
        
        let timerLabel = SKLabelNode(fontNamed: "Courier")
        timerLabel.name = "timerLabel"
        timerLabel.fontColor = SKColor.redColor()
        timerLabel.text = "Next Maze Shift in: "
        timerLabel.position = CGPoint(x: frame.size.width/2, y: frame.size.height * 0.85)
        scene!.addChild(timerLabel)
    }
        
    func createControls() {
        
        joystick.position = CGPoint(x: scene!.size.width * 0.085, y: scene!.size.height * 0.25)
        scene?.addChild(joystick)
        
        shootControl.fillTexture = SKTexture(imageNamed: "shootButton.png")
        shootControl.fillColor = SKColor.whiteColor()
        shootControl.strokeColor = .clearColor()
        shootControl.position = CGPoint(x: scene!.size.width * 0.91, y: scene!.size.height * 0.25)
        shootControl.zPosition = 100
        shootControl.name = "shootControl"
        scene!.addChild(shootControl)
        
        
        abilityControl.position = CGPoint(x: scene!.size.width * 0.91, y: scene!.size.height * 0.60)
        abilityControl.fillColor = SKColor.whiteColor()
        
        switch abilitySelected {
        case ability.wallBuster:
            abilityControl.fillTexture = SKTexture(imageNamed: "brickBreaker.png")
        case ability.speedDemon:
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
        
        createCenter()


    }
    
    //create target area for player to reach
    func createCenter() {
        
        center.position = CGPointMake(0.0, 0.0)
        center.physicsBody = SKPhysicsBody(circleOfRadius: 7.0)
        center.fillColor = .greenColor()
        center.zPosition = 11
        center.name = "center"
        boundingBox.addChild(center)
        center.physicsBody?.restitution = 0.6
        
    }
    //texture array for Player
    func createTextureArray() -> [SKTexture]{
        
        
        var TextureArray = [SKTexture]()
        var TextureAtlas = SKTextureAtlas(named: "walkCycle")
        for i in 1...(TextureAtlas.textureNames.count - 2) {
            
            var Name = "PlayerWalk0\(i)"
            TextureArray.append(SKTexture(imageNamed: Name))
        }
        return TextureArray
    }

    func goBackToPreviousScene() {
        
        let mazeSelectScene = MazeSelectScene()
        mazeSelectScene.size = self.size
        mazeSelectScene.scaleMode = self.scaleMode
        Player?.removeFromParent()
        Player = nil
        boundingBox.removeAllChildren()
        boundingBox.removeFromParent()
        box1.removeAllChildren()
        box1.removeFromParent()
        self.scene?.removeAllChildren()
        let transition = SKTransition.crossFadeWithDuration(1.0)
        self.scene!.view?.presentScene(mazeSelectScene, transition: transition)
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
                addChild(bullets[0])
                
                let vector = CGVectorMake(bulletSpeedX, bulletSpeedY)
                bullets[0].physicsBody?.applyImpulse(vector)
                
            }
            
            if backButton.containsPoint(location) {
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
        
        print("firstBody bitmask: \(firstBody.categoryBitMask)")
        print("secondBody bitmask: \(secondBody.categoryBitMask)")
        
        if (firstBody.categoryBitMask == bulletCategory && secondBody.categoryBitMask == boundingBoxCategory)  {
            print("bullet bounding box")
            removeBullet(firstBody.node!)
        }
        if (firstBody.categoryBitMask == boundingBoxCategory && secondBody.categoryBitMask == bulletCategory) {
            print("bullet bounding box")
            removeBullet(secondBody.node!)
        }
        
        if (firstBody.categoryBitMask == bulletCategory && secondBody.categoryBitMask == brickCategory) {
            print("bullet hit brick wall")
            removeBrick(secondBody.node!)
            
        }
        if (firstBody.categoryBitMask == brickCategory && secondBody.categoryBitMask == bulletCategory) {
            removeBrick(firstBody.node!)
        }
        if (firstBody.categoryBitMask == brickCategory && secondBody.categoryBitMask == playerCategory) {
            
        }
        if (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == brickCategory) {
            
        }

    }
    
    
    override func update(currentTime: NSTimeInterval) {
        

    }
    
        
}
            

    

