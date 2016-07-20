//
//  GameScene.swift
//  Into The Maze
//
//  Created by ramiro beltran on 2/1/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

var boundingBox = SKSpriteNode()
var outerWall = [SKSpriteNode]()

var bulletNode = SKSpriteNode()
var bullets = [bulletNode]

let boundingBoxCategory: UInt32 = 0x1 << 1
let bulletCategory: UInt32 = 0x1 << 2
let playerCategory: UInt32 = 0x1 << 3

//the direction the player is currently moving the thumbstick in
var currentDirection:PlayerDirection!

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var center = SKShapeNode(circleOfRadius: 7.0)
    //on screen buttons
    let backButton = SKLabelNode(text: "Back")
    let shootControl: SKShapeNode = SKShapeNode(circleOfRadius: 40.0 * scale)
    let abilityControl: SKShapeNode = SKShapeNode(circleOfRadius: 40.0 * scale)
    
    var TextureArray = [SKTexture]()
    var walking: Bool = false
    var playerFacing = PlayerDirection.North
    
    var Player : SKSpriteNode?
    let joystick = AnalogJoystick(diameter: 80.0 * scale, colors: (.clearColor(), .clearColor()), images: (UIImage(named: "substrate.png"), UIImage(named: "stick.png")))
    
    
    let parent1 = SKSpriteNode()
    let parent2 = SKSpriteNode()
    let parent3 = SKSpriteNode()

    override func didMoveToView(view: SKView) {
        
        
        createNewScene()
        createNewPlayer()
        
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
        
        
        parent1.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        addChild(parent1)
        
        parent2.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        addChild(parent2)
        
        parent3.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        addChild(parent3)
        
        let triangle1 = Triangle.createTriangle(self, scale: 1.0, buffer: 0.0, color: .redColor())
        
        let triangle2 = Triangle.createTriangle(self, scale: 0.7, buffer: -10.0, color: .redColor())
        
        let triangle3 = Triangle.createTriangle(self, scale: 0.4, buffer: -20.0, color: .redColor())

        parent1.addChild(triangle1)
        parent2.addChild(triangle2)
        parent3.addChild(triangle3)


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

    }
    
    func createNewPlayer() {
        
        //create texture array for player movement
        TextureArray = createTextureArray()
        
        self.Player = NewPlayer.createNewPlayer()
        Player!.name = "Player"
        
        addChild(Player!)
        
        Player?.position = CGPoint(x: ((scene?.size.width)!/2), y: (scene?.size.height)! * 0.1)
        
        //give player's start direction
        currentDirection = PlayerDirection.North
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
        shootControl.position = CGPoint(x: scene!.size.width * 0.91, y: scene!.size.height * 0.25)
        shootControl.zPosition = 100
        shootControl.name = "shootControl"
        scene!.addChild(shootControl)
        
        
        abilityControl.position = CGPoint(x: scene!.size.width * 0.91, y: scene!.size.height * 0.60)
        abilityControl.fillColor = SKColor.whiteColor()
        
        switch abilitySelected {
        case ability.wallBuster:
            abilityControl.fillTexture = SKTexture(imageNamed: "wallBuster.png")
        case ability.speedDemon:
            abilityControl.fillTexture = SKTexture(imageNamed: "speedDemon.png")
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
        
        //boundingBox.color = SKColor.clearColor()
        boundingBox.color = SKColor.blackColor()
        boundingBox.size = CGSize(width: scene!.size.width, height: scene!.size.height)
        //boundingBox.texture = SKTexture(imageNamed: "cobblestone.png")
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
        //createOuterWall()

    }
    
    func createOuterWall() {
        
        let thickness:CGFloat = 20.0
        
        let wall1 = SKShapeNode(rectOfSize: CGSize(width: (scene?.size.width)!, height: thickness))
        let wall2 = SKShapeNode(rectOfSize: CGSize(width: thickness, height: (scene?.size.height)!))
        let wall3 = SKShapeNode(rectOfSize: CGSize(width: (scene?.size.width)!, height: thickness))
        let wall4 = SKShapeNode(rectOfSize: CGSize(width: thickness, height: (scene?.size.height)!))
        
        wall1.position = CGPoint(x: (scene?.size.width)!/2, y: (scene?.size.height)! * 0.97)
        wall1.fillColor = mazeColor
        wall1.zPosition = 5
        wall1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: (scene?.size.width)!, height: thickness))
        wall1.physicsBody?.affectedByGravity = false
        wall1.physicsBody?.dynamic = false
        addChild(wall1)
        
        wall3.position = CGPoint(x: (scene?.size.width)!/2, y: (scene?.size.height)! * 0.03)
        wall3.fillColor = mazeColor
        wall3.zPosition = 5
        addChild(wall3)
        
        
    }
    
    //create target area for player to reach
    func createCenter() {
        
        center.position = CGPointMake(0.0, 0.0)
        center.physicsBody = SKPhysicsBody(circleOfRadius: 7.0)
        center.fillColor = .greenColor()
        center.zPosition = 5
        center.name = "center"
        boundingBox.addChild(center)
        center.physicsBody?.restitution = 0.6
    }
    
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
        self.scene?.removeAllChildren()
        let transition = SKTransition.crossFadeWithDuration(2.0)
        self.scene!.view?.presentScene(mazeSelectScene, transition: transition)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch! {
            let location = touch.locationInNode(self)
            
            //check to see if a bullet should be fired
            if shootControl.containsPoint(location) {
                
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
                
                goBackToPreviousScene()
            }
        }
    }

    func didBeginContact(contact: SKPhysicsContact) {
        
        let firstBody = SKPhysicsBody()
        let secondBody = SKPhysicsBody()
        
        firstBody.categoryBitMask = contact.bodyA.categoryBitMask
        secondBody.categoryBitMask = contact.bodyB.categoryBitMask
        
        print("firstBody bitmask: \(firstBody.categoryBitMask)")
        print("secondBody bitmask: \(secondBody.categoryBitMask)")
        
        if (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == bulletCategory) || (firstBody.categoryBitMask == bulletCategory && secondBody.categoryBitMask == playerCategory) {
            print("bullet hit player")
        }
        if (firstBody.categoryBitMask == bulletCategory && secondBody.categoryBitMask == boundingBoxCategory) || (firstBody.categoryBitMask == boundingBoxCategory && secondBody.categoryBitMask == bulletCategory) {
            print("bullet hit wall")
            for bullet in bullets {
                //Add animation for bullet hitting wall
                bullet.removeFromParent()
            }
        }

    }
    
    
    override func update(currentTime: NSTimeInterval) {
        

    }
    
        
}
            

    

