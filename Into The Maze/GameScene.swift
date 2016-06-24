//
//  GameScene.swift
//  Into The Maze
//
//  Created by ramiro beltran on 2/1/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

let boundingBox = SKSpriteNode()
let boundingBox2 = SKSpriteNode()
let boundingBox3 = SKSpriteNode()

class GameScene: SKScene {
    
    
    var center = SKShapeNode(circleOfRadius: 7.0)
    
    let backButton = SKLabelNode(text: "Back")
    let shootControl: SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "shootButton.png"))
    
    var TextureArray = [SKTexture]()
    var walking: Bool = false
    var playerFacing = PlayerDirection.North
    
    var Player : SKSpriteNode?
    let joystick = AnalogJoystick(diameter: 100, colors: (UIColor.blueColor(), UIColor.yellowColor()))
    
    

    override func didMoveToView(view: SKView) {

        self.removeAllChildren()
        
        TextureArray = createTextureArray()
        
        createNewScene()
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)


        //Mark: Joystick Handlers
        joystick.startHandler = { [unowned self] in
            
//          guard let aN = self.Player else { return }
//          aN.runAction(SKAction.sequence([SKAction.scaleTo(0.5, duration: 0.5), SKAction.scaleTo(1, duration: 0.5)]))
            
            self.Player!.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(self.TextureArray, timePerFrame: 0.2)))
            self.walking = true

        }
        
        joystick.trackingHandler = { [unowned self] data in
            
            guard let plr = self.Player else { return }
            plr.position = CGPointMake(plr.position.x + (data.velocity.x * playerSpeed), plr.position.y + (data.velocity.y * playerSpeed))
            let x = data.velocity.x
            let y = data.velocity.y
            print("x:\(x)")
            print("y:\(y)")
            
            if x > 0 {
                if y < 20 && y > -20 {
                    self.playerFacing = PlayerDirection.East
                    self.Player?.zRotation = self.DegToRad(180.0)
                }else if y >= 20 {
                    self.playerFacing = PlayerDirection.NorthEast
                    self.Player?.zRotation = self.DegToRad(45.0)
                } else {
                    self.playerFacing = PlayerDirection.SouthEast
                    self.Player?.zRotation = self.DegToRad(315.0)
                }
            //test if x < 0
            }else if x < 0{
                if y == 0 {
                    self.playerFacing = PlayerDirection.West
                }else if y > 0 {
                    self.playerFacing = PlayerDirection.NorthWest
                }else {
                    self.playerFacing = PlayerDirection.SouthWest
                }
            //test if x == 0
            }else {
                if y > 0 {
                    self.playerFacing = PlayerDirection.North
                }else {
                    self.playerFacing = PlayerDirection.South
                }

            }
            print(self.playerFacing)
            
            
            
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
    
    override func willMoveFromView(view: SKView) {
        

    }

    //call to all functions for new scene
    func createNewScene() {
        
        createBackButton()
        createBoundingBox()
        createScoreLabel()
        levelLabel(level)
        createControls()
        backgroundColor = SKColor.blackColor()
        //mazeShiftLabel()
        
//        self.Player = SKSpriteNode(imageNamed: "PlayerWalk01")
//        self.Player!.size = CGSize(width: 70, height: 70)
        self.Player = NewPlayer.createNewPlayer(self.scene!)
        Player!.name = "Player"
        boundingBox.addChild(Player!)
        Player!.zPosition = 100

    }
    
    func createBackButton() {
        
        backButton.fontColor = .blueColor()
        backButton.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.94)
        backButton.zPosition = 50
        self.addChild(backButton)
    }
    
    func createScoreLabel() {
        
        let scoreLabel = SKLabelNode(fontNamed: "RUBBBI__")
        scoreLabel.name = "scoreLabel"
        scoreLabel.fontColor = mazeColor
        scoreLabel.text = String(format: "Score: %04u", 0)
        scoreLabel.position = CGPoint(x: frame.size.width/2, y: frame.size.height * 0.93)
        scene!.addChild(scoreLabel)
    }
    
    func levelLabel(level: Int) {
        
        let levelLabel = SKLabelNode(fontNamed: "RUBBBI__")
        levelLabel.name = "levelLabel"
        levelLabel.fontColor = .yellowColor()
        levelLabel.text = "Level: \(level)"
        levelLabel.position = CGPoint(x: frame.size.width/2, y: frame.size.height * 0.80)
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
        
        
        joystick.position = CGPoint(x: scene!.size.width * 0.1, y: scene!.size.height * 0.25)
        scene?.addChild(joystick)
        
        shootControl.size = CGSize(width: 100.0, height: 100.0)
        shootControl.position = CGPoint(x: scene!.size.width * 0.9, y: scene!.size.height * 0.25)
        shootControl.zPosition = 100
        shootControl.name = "shootControl"
        scene!.addChild(shootControl)
        
        let abilityControl: SKShapeNode = SKShapeNode(circleOfRadius: 50.0)
        abilityControl.position = CGPoint(x: scene!.size.width * 0.9, y: scene!.size.height * 0.60)
        abilityControl.fillColor = SKColor.orangeColor()
        abilityControl.fillTexture = SKTexture(imageNamed: "abilityButton")
        abilityControl.zPosition = 100
        abilityControl.name = "abilityControl"
        scene!.addChild(abilityControl)
    }
    
    func createBoundingBox() {
        
        boundingBox.color = SKColor.redColor()
        boundingBox.size = CGSize(width: scene!.size.width * 0.65, height: scene!.size.height * 0.85)
        boundingBox.position = CGPointMake(scene!.size.width/2, scene!.size.height/2)
        boundingBox.zPosition = 0
        boundingBox.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: boundingBox.anchorPoint.x - boundingBox.size.width/2, y: boundingBox.anchorPoint.y - boundingBox.size.height/2, width: boundingBox.size.width, height: boundingBox.size.height))
        boundingBox.physicsBody?.affectedByGravity = false
        boundingBox.name = "boundingBox"
        scene!.addChild(boundingBox)
        
        createCenter()

        //boundingBox2.color = SKColor.greenColor()
        boundingBox2.size = CGSize(width: 200, height: 200)
        boundingBox2.position = CGPointMake(scene!.size.width/2, scene!.size.height/2 + scene!.size.height * 0.2)
        boundingBox2.zPosition = 2
        boundingBox2.name = "boundingBox2"
        scene!.addChild(boundingBox2)

        //boundingBox3.color = SKColor.yellowColor()
        boundingBox3.size = CGSize(width: 100, height: 100)
        boundingBox3.position = CGPointMake(scene!.size.width/2, scene!.size.height/2 + scene!.size.height * 0.2)
        boundingBox3.zPosition = 3
        boundingBox3.name = "boundingBox3"
        scene!.addChild(boundingBox3)

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

    //convert degrees to radians
    func DegToRad(degrees: Double)->CGFloat {
        return CGFloat(degrees * M_PI / 180.0)
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
            
            if shootControl.containsPoint(location) {
                
                let bulletNode = self.createProjectile()
                Player?.addChild(bulletNode)
                bulletNode.physicsBody = SKPhysicsBody(rectangleOfSize: bulletNode.frame.size)
                bulletNode.physicsBody?.applyImpulse(CGVectorMake(300.0, 0.0))
                
            }
            
            if backButton.containsPoint(location) {
                
                goBackToPreviousScene()
            }
        }
    }

    func createProjectile() -> SKSpriteNode {
        
        //let shooterNode = self.childNodeWithName("Player")
        //let shooterPosition = shooterNode!.position
        //let shooterWidth = shooterNode!.frame.size.width
        
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.size = CGSize(width: 20.0, height: 20.0)
        bullet.position = CGPointZero
        
        
        return bullet
    }
    
}
            

    

