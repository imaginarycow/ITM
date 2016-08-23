//
//  Maze3GameScene.swift
//  Into The Maze
//
//  Created by ramiro beltran on 8/17/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import SpriteKit


class Maze3GameScene: GameScene {
    
    let numbBricks2:Int = 6
    var brickWidth2:CGFloat!
    
    let outerWall = SKSpriteNode()
    let box2 = SKSpriteNode()
    let box3 = SKSpriteNode()
    let box4 = SKSpriteNode()
    let box5 = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        
        playerSpawn = CGPoint(x: ((scene?.size.width)! * 0.1), y: (scene?.size.height)!/2)
        finishPosition = CGPoint(x: ((scene?.size.width)! * 0.9), y: (scene?.size.height)! * 0.85)
        createNewScene()
        abilityToken.position = CGPoint(x: centerOfScene.x, y: centerOfScene.y - (box1Width * 0.4 + abilityToken.size.height))
        addChild(abilityToken)
        
        updateShiftTimer()
        updateClock()
        
        
        //ability token set in buildOuterWall()
        
        buildBox2()
        buildOuterCircle()
        buildInnerCircle()
        buildBox3()
    }
    
    override func willMoveFromView(view: SKView) {
        
    }
    func buildBox3() {
        
        let width = CGFloat(activeScene.size.height * 0.4)
        box6.size = CGSize(width: width, height: width)
        box6.position = CGPoint(x: centerOfScene.x, y: centerOfScene.y)
        //box6.color = .blueColor()
        box6.zPosition = boxZPosition + 3
        addChild(box6)
        
        let size1 = CGSize(width: width, height: brickHeight)
        let rot = DegToRad(90.0)
        
        let parent1 = Parent.newParent(CGPoint(x: 0.0, y: 0.0 - (width/2)), size: size1)
        box6.addChild(parent1)
        let parent2 = Parent.newParent(CGPoint(x: 0.0, y: 0.0 + (width/2)), size: size1)
        box6.addChild(parent2)
        
        let numbBricks = Int(size1.width / brickWidth)
        for i in 0...numbBricks-1 {
            
            let rot = Double(DegToRad(0.0))
            let anchorPoint1: CGPoint = CGPoint(x: 0.0 - (size1.width / 2) + (brickWidth/2), y: 0.0)
            let brick1 = Brick.createBrick(CGPoint(x: anchorPoint1.x + (brickWidth * CGFloat(i)), y: anchorPoint1.y), brickWidth: brickWidth, rotation: rot)
            let brick2 = Brick.createBrick(CGPoint(x: anchorPoint1.x + (brickWidth * CGFloat(i)), y: anchorPoint1.y), brickWidth: brickWidth, rotation: rot)
            parent1.addChild(brick1)
            parent2.addChild(brick2)
            
        }

    }
    
    func buildBox2() {
        
        let width = CGFloat(activeScene.size.height * 0.3)
        box2.size = CGSize(width: width, height: width)
        box2.position = CGPoint(x: centerOfScene.x,y: centerOfScene.y)
        box2.zPosition = boxZPosition + 1
        //box2.color = .orangeColor()
        addChild(box2)
        
        let size1 = CGSize(width: brickHeight, height: width)
        let rot = DegToRad(90.0)
        
        let parent1 = Parent.newParent(CGPoint(x: 0.0 - (width * 0.2), y: 0.0), size: size1)
        box2.addChild(parent1)
        let parent2 = Parent.newParent(CGPoint(x: 0.0 + (width * 0.2), y: 0.0), size: size1)
        box2.addChild(parent2)
        
        let numbBricks = Int(size1.height / brickWidth)
        for i in 0...numbBricks-1 {
            
            let rot = Double(DegToRad(90.0))
            let anchorPoint1: CGPoint = CGPoint(x: 0.0, y: 0.0 - (size1.height / 2) + (brickWidth/2))
            let brick1 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            let brick2 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            parent1.addChild(brick1)
            parent2.addChild(brick2)
            
        }
        
    }
    
    func buildOuterCircle() {
        
        let rad: CGFloat = activeScene.size.height / 2
        circle1 = SKShapeNode(circleOfRadius: rad)
        //circle1.fillColor = .redColor()
        circle1.strokeColor = .clearColor()
        circle1.zPosition = boxZPosition
        circle1.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        addChild(circle1)
        
//        let brickWidth3 = brickWidth * 2.6
//        let numb = 12
//        let pi = M_PI
//        let radians = pi/6
        
        let pi = M_PI
        let circ = 2 * pi * Double(rad)
        let numb = Int(circ / Double(brickWidth))
        let radians = (2 * pi) / Double(numb)
        
        var rot: Double = 0.0
        for i in 1...numb {
            
            if i % 4 == 0 {
                rot = 0.0
            }
//            if i == 1 || i == 8 {
//                rot = 90.0
//            }
            if i >= 1 {
                rot = Double(DegToRad(-60.0)) + (Double(i-1) * radians)
            }
            
            let x:CGFloat = 0.0 + rad * CGFloat(cos(Double(i)*radians))
            let y:CGFloat = 0.0 + rad * CGFloat(sin(Double(i)*radians))
            
            if i == 7 {
                
            }else {
                let brick = Brick.createBrick(CGPoint(x: x, y: y), brickWidth: brickWidth, rotation: rot)
                circle1.addChild(brick)
            }
            
        }
        
    }
    
    func buildInnerCircle() {
        
        let rad: CGFloat = activeScene.size.height / 2.8
        circle2 = SKShapeNode(circleOfRadius: rad)
        //circle2.fillColor = .redColor()
        circle2.strokeColor = .clearColor()
        circle2.zPosition = boxZPosition
        circle2.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        addChild(circle2)
        
        let brickWidth3 = brickWidth * 1.4
        let numb = 12
        let pi = M_PI
        let radians = pi/6
        var rot: Double = 0.0
        for i in 1...numb {
            
            if i % 4 == 0 {
                rot = 0.0
            }
            if i == 1 || i == 8 {
                rot = 90.0
            }
            if i > 0 {
                rot = Double(DegToRad(60.0)) + (Double(i-1) * radians)
            }
            
            let x:CGFloat = 0.0 + rad * CGFloat(cos(Double(i)*radians))
            let y:CGFloat = 0.0 + rad * CGFloat(sin(Double(i)*radians))
            
            let brick = Brick.createBrick(CGPoint(x: x, y: y), brickWidth: brickWidth3, rotation: rot)
            circle2.addChild(brick)
            
        }
        
    }

    //maze2 shift1 animation
    func maze3Shift() {
        
        if treasureTaken == false {
            let duration = 1.0
            
            let rotateAction1 = SKAction.rotateByAngle(DegToRad(45), duration: duration)
            circle1.runAction(rotateAction1)
            
            let rotateAction2 = SKAction.rotateByAngle(DegToRad(-45), duration: duration)
            circle2.runAction(rotateAction2)
            
            let rotateAction3 = SKAction.rotateByAngle(DegToRad(90), duration: duration)
            box2.runAction(rotateAction3)
            
        }else {
            let duration = 1.0
            
            let rotateAction1 = SKAction.rotateByAngle(DegToRad(75), duration: duration)
            circle1.runAction(rotateAction1)
            
            let rotateAction2 = SKAction.rotateByAngle(DegToRad(-75), duration: duration)
            circle2.runAction(rotateAction2)
            
            let rotateAction3 = SKAction.rotateByAngle(DegToRad(150), duration: duration)
            box2.runAction(rotateAction3)
            
            box6.runAction(rotateAction2)
        }
        
        
    } // End: Maze3Shift
    
    //maze shift timer
    func updateShiftTimer() {
        
        timer.position = CGPoint(x: frame.size.width * 0.10, y: frame.size.height * 0.80)
        timer.fontName = labelFont
        timer.fontSize = 16.0 * scale
        timer.fontColor = .redColor()
        self.addChild(timer)
        
        let actionwait = SKAction.waitForDuration(1.0)
        var seconds = 15
        var freezeTimer = 10
        let actionrun = SKAction.runBlock({
            
            //check if user is using TimeFreeze ability
            if timerIsFrozen {
                self.timer.fontColor = freezeColor
                self.timer.text = "Time Freeze"
                if freezeTimer > 9 {
                    let ice = createIce2(CGPointZero, target: self.timer)
                    self.timer.addChild(ice)
                    
                    delay(0.3) {
                        ice.removeFromParent()
                        ice.targetNode = nil
                        ice.resetSimulation()
                    }
                    
                }
                
                freezeTimer -= 1
                if freezeTimer == 0 {
                    timerIsFrozen = false
                    freezeTimer = 10
                    self.timer.fontColor = .redColor()
                }
                
                
            } else {
                self.maze3Shift()
                
                self.timer.text = "Maze Shifting!"
                if seconds == 3 {
                    vc.playSoundEffect(Sound.alarmSound)
                }
                if seconds == 0 {
                    
                    
                    vc.alarmSound!.stop()
                    seconds = 16
                    self.mazeShiftIndex += 1
                }
                
                seconds -= 1
                
            }
            
            
        })
        self.timer.runAction(SKAction.repeatActionForever(SKAction.sequence([actionwait,actionrun])))
    }
    
}
//End Maze3GameScene