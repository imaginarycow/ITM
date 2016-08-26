//
//  Maze5GameScene.swift
//  Into The Maze
//
//  Created by ramiro beltran on 8/20/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import SpriteKit


class Maze5GameScene: GameScene {
    
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
        
        buildOuterCircle()
        buildInnermostCircle()

    }
    
    override func willMoveFromView(view: SKView) {
        circle3 = SKShapeNode()
    }
    
    func buildOuterCircle() {
        
        let rad: CGFloat = activeScene.size.height / 2
        circle1 = SKShapeNode(circleOfRadius: rad)
        //circle1.fillColor = .redColor()
        circle1.strokeColor = .clearColor()
        circle1.zPosition = boxZPosition
        circle1.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        addChild(circle1)
        
        let pi = M_PI
        let circ = 2 * pi * Double(rad)
        let numb = Int(circ / Double(brickWidth))
        let radians = (2 * pi) / Double(numb)
        var rot: Double = 0.0
        for i in 1...numb {
            
            if i % 4 == 0 {
                rot = 0.0
            }

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
        let rad2: CGFloat = activeScene.size.height / 6 //radius of inner most circle
        let size1 = CGSize(width: brickHeight, height: (rad - rad2))
        let number = Int((rad-rad2) / brickWidth)
        var parents:[SKSpriteNode] = []
        for i in 0...3 {
            var parent = SKSpriteNode()
            if i == 0 {
                parent = Parent.newParent(CGPoint(x: 0.0, y: 0.0 + rad/2), size: size1)
            }
            if i == 1 {
                parent = Parent.newParent(CGPoint(x: 0.0 + rad/2, y: 0.0), size: size1)
                parent.zRotation = DegToRad(-90.0)
            }
            if i == 2 {
                parent = Parent.newParent(CGPoint(x: 0.0, y: 0.0 - rad/2), size: size1)
                parent.zRotation = DegToRad(-180.0)
            }
            if i == 3 {
                parent = Parent.newParent(CGPoint(x: 0.0 - rad/2, y: 0.0), size: size1)
                parent.zRotation = DegToRad(90.0)
            }

            circle1.addChild(parent)
            for j in 1...number{

                let rot = Double(DegToRad(90.0))
                let anchorPoint1: CGPoint = CGPoint(x: 0.0, y: 0.0 - (size1.height / 2) + (brickWidth/2))
                let brick = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(j))), brickWidth: brickWidth, rotation: rot)
                
                if i == 0{
                    if j == 1 {
                        
                    }else {
                        parent.addChild(brick)
                    }
                }
                if i == 1{
                    if j == 3 {
                        
                    }else {
                        parent.addChild(brick)
                    }
                }
                if i == 2{
                    if j == 1 {
                        
                    }else {
                        parent.addChild(brick)
                    }
                }
                if i == 3{
                    if j == 2 {
                        
                    }else {
                        parent.addChild(brick)
                    }
                }

        
                
            }
        }
    }
    
    func buildInnerCircle() {
        
        let rad: CGFloat = activeScene.size.height / 3
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
    
    func buildInnermostCircle() {
        let rad: CGFloat = activeScene.size.height / 6
        circle3 = SKShapeNode(circleOfRadius: rad)
        //circle1.fillColor = .redColor()
        circle3.strokeColor = .clearColor()
        circle3.zPosition = boxZPosition
        circle3.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        addChild(circle3)
        
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
            
            if i >= 1 {
                rot = Double(DegToRad(-60.0)) + (Double(i-1) * radians)
            }
            
            let x:CGFloat = 0.0 + rad * CGFloat(cos(Double(i)*radians))
            let y:CGFloat = 0.0 + rad * CGFloat(sin(Double(i)*radians))
            
            if i == 7 {
                
            }else {
                let brick = Brick.createBrick(CGPoint(x: x, y: y), brickWidth: brickWidth, rotation: rot)
                circle3.addChild(brick)
            }
            
        }

    }
    
    //maze2 shift1 animation
    func maze5Shift() {
        
        if treasureTaken == false {
            let duration = 1.0
            
            let rotateAction1 = SKAction.rotateByAngle(DegToRad(-45), duration: duration)
            circle1.runAction(rotateAction1)
            
            let rotateAction3 = SKAction.rotateByAngle(DegToRad(45), duration: duration)
            circle3.runAction(rotateAction3)
            
        }else {
            let duration = 1.0
            
            let rotateAction1 = SKAction.rotateByAngle(DegToRad(75), duration: duration)
            circle1.runAction(rotateAction1)
            
            let rotateAction3 = SKAction.rotateByAngle(DegToRad(-75), duration: duration)
            circle3.runAction(rotateAction3)
        }
        
        
    } // End: Maze3Shift
    
    //maze shift timer
    func updateShiftTimer() {
        
        timer.position = CGPoint(x: frame.size.width * 0.10, y: frame.size.height * 0.80)
        timer.zPosition = 200
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
                self.maze5Shift()
                
                self.timer.text = "Shifting!"
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
//End Maze5GameScene
