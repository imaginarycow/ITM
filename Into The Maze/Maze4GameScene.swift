//
//  Maze4GameScene.swift
//  Into The Maze
//
//  Created by ramiro beltran on 8/20/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import SpriteKit


class Maze4GameScene: GameScene {
    
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
        
        updateShiftTimer()
        updateClock()
        
        //set custom enemy spawn points
        //setCustomSpawnPoints()
        
        //ability token set in buildOuterWall()
        
        buildOuterWall()
        buildBox1()
        buildBoxes2_5()
        //buildBox6()
        //buildOuterCircle()
        
    }
    
    override func willMoveFromView(view: SKView) {
        
    }
    
    func buildOuterWall() {
        
        let outerWallLength = CGFloat((scene?.size.height)! * 1.0)
        outerWall.size = CGSize(width: outerWallLength, height: outerWallLength)
        outerWall.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        outerWall.zPosition = boxZPosition
        addChild(outerWall)
        
        abilityToken.position = CGPoint(x: 0.0 + (outerWall.size.width / 2) - abilityToken.size.width, y: 0.0 + (outerWall.size.width / 2) - (abilityToken.size.width/2))
        outerWall.addChild(abilityToken)
        
        let sideLength1:CGFloat = outerWallLength
        
        let size1 = CGSize(width: brickHeight, height: sideLength1)
        let size2 = CGSize(width: sideLength1, height: brickHeight)
        
        let parent1 = Parent.newParent(CGPoint(x: 0.0 - (sideLength1 / 2), y: 0.0), size: size1)
        outerWall.addChild(parent1)
        
        let parent2 = Parent.newParent(CGPoint(x: 0.0 + (sideLength1 / 2), y: 0.0), size: size1)
        outerWall.addChild(parent2)
        
        let parent3 = Parent.newParent(CGPoint(x: 0.0, y: 0.0  - (sideLength1 / 2)), size: size2)
        outerWall.addChild(parent3)
        
        let parent4 = Parent.newParent(CGPoint(x: 0.0, y: 0.0  + (sideLength1 / 2)), size: size2)
        outerWall.addChild(parent4)
        
        //add bricks to outer wall parents 1-4
        for i in 0...numbOfBricks-1 {
            print("building outer wall bricks")
            let rot = Double(DegToRad(90.0))
            let anchorPoint1: CGPoint = CGPoint(x: 0.0, y: 0.0 - (sideLength1 / 2) + (brickWidth/2))
            let brick1 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            let brick2 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            
            // create entry and exit
            if i == numbOfBricks-1 {
                parent2.addChild(brick2)
            }else if i == 0{
                parent1.addChild(brick1)
                
            }else {
                parent1.addChild(brick1)
                parent2.addChild(brick2)
            }
            
            let anchorPoint2: CGPoint = CGPoint(x: 0.0  - (sideLength1 / 2) + (brickWidth/2), y: 0.0)
            let brick3 = Brick.createBrick(CGPoint(x: anchorPoint2.x + (brickWidth * CGFloat(i)), y: anchorPoint2.y), brickWidth: brickWidth, rotation: 0.0)
            let brick4 = Brick.createBrick(CGPoint(x: anchorPoint2.x + (brickWidth * CGFloat(i)), y: anchorPoint2.y), brickWidth: brickWidth, rotation: 0.0)
            parent3.addChild(brick3)
            parent4.addChild(brick4)
        }
    }
    
    func buildBox1() {
        print("building box 1 bricks")
        box1Width = CGFloat((scene?.size.height)! * 0.45)
        box1.size = CGSize(width: box1Width, height: box1Width)
        //box1.color = .greenColor()
        box1.zRotation = DegToRad(45.0)
        box1.zPosition = boxZPosition + 1
        box1.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        //box1.alpha = 0.2
        addChild(box1)
        
        let parentSize1 = CGSize(width: brickHeight, height: box1Width / 2)
        let parentSize2 = CGSize(width: box1Width / 2, height: brickHeight)
        
        let parent5 = Parent.newParent(CGPoint(x: 0.0 - (box1Width / 2), y: 0.0), size: parentSize1)
        box1.addChild(parent5)
        let parent6 = Parent.newParent(CGPoint(x: 0.0 + (box1Width / 2), y: 0.0), size: parentSize1)
        box1.addChild(parent6)
        let parent7 = Parent.newParent(CGPoint(x: 0.0, y: 0.0 - (box1Width / 2)), size: parentSize2)
        box1.addChild(parent7)
        let parent8 = Parent.newParent(CGPoint(x: 0.0, y: 0.0 + (box1Width / 2)), size: parentSize2)
        box1.addChild(parent8)
        
        let numbBricks = Int(parentSize1.height / brickWidth)
        
        for i in 0...numbBricks-1 {
            let rot = Double(DegToRad(90.0))
            let anchorPoint1: CGPoint = CGPoint(x: 0.0, y: 0.0 - (parentSize1.height / 2) + (brickWidth/2))
            let brick1 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            let brick2 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            parent5.addChild(brick1)
            parent6.addChild(brick2)
            
            let anchorPoint2: CGPoint = CGPoint(x: 0.0 - (parentSize2.width / 2) + (brickWidth/2), y: 0.0)
            let brick3 = Brick.createBrick(CGPoint(x: anchorPoint2.x + (brickWidth * CGFloat(i)), y: anchorPoint2.y), brickWidth: brickWidth, rotation: 0.0)
            let brick4 = Brick.createBrick(CGPoint(x: anchorPoint2.x + (brickWidth * CGFloat(i)), y: anchorPoint2.y), brickWidth: brickWidth, rotation: 0.0)
            parent7.addChild(brick3)
            parent8.addChild(brick4)
        }
    }
    
    func buildBoxes2_5() {
        var parents : [SKSpriteNode] = []
        let length = outerWall.size.height
        let width = CGFloat(outerWall.size.height * 0.33)
        
        let size1 = CGSize(width: brickHeight, height: width)
        var box = SKSpriteNode()
        box.size = CGSize(width: width, height: width)
        box.zPosition = boxZPosition
        box.color = .orangeColor()
        
        for i in 0...3 {
            
            if i == 0 {
                box = box2
                box.position = CGPoint(x: 0.0 - (length/4), y: 0.0 + (length/4))
            }
            if i == 1 {
                box = box3
                box.position = CGPoint(x: 0.0 - (length/4), y: 0.0 - (length/4))           }
            if i == 2 {
                box = box4
                box.position = CGPoint(x: 0.0 + (length/4), y: 0.0 + (length/4))
            }
            if i == 3 {
                box = box5
                box.position = CGPoint(x: 0.0 + (length/4), y: 0.0 - (length/4))
            }
            
            outerWall.addChild(box)

            let parent1 = Parent.newParent(CGPoint(x: 0.0 - (width / 2), y: 0.0), size: size1)
            box.addChild(parent1)
            parents.append(parent1)
            let parent2 = Parent.newParent(CGPoint(x: 0.0 - (width/4), y: 0.0), size: size1)
            box.addChild(parent2)
            parents.append(parent2)
            let parent3 = Parent.newParent(CGPoint(x: 0.0, y: 0.0), size: size1)
            box.addChild(parent3)
            parents.append(parent3)
            let parent4 = Parent.newParent(CGPoint(x: 0.0 + (width / 4), y: 0.0), size: size1)
            box.addChild(parent4)
            parents.append(parent4)
            let parent5 = Parent.newParent(CGPoint(x: 0.0 + (width / 2), y: 0.0), size: size1)
            box.addChild(parent5)
            parents.append(parent5)
            
            let rot = Double(DegToRad(90.0))
            for i in 0...parents.count-1 {
                let parent = parents[i]
                if i % 2 == 0 {
                    let bCount = 2
                    let anchorPoint: CGPoint = CGPoint(x: 0.0, y: 0.0 - (size1.height / 4) + (brickWidth/2))

                    for i in 0...bCount {
                        let brick1 = Brick.createBrick(CGPoint(x: anchorPoint.x, y: anchorPoint.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
                        parent.addChild(brick1)
                    }
                }
                else {
                    let bCount = 3
                    let anchorPoint: CGPoint = CGPoint(x: 0.0, y: 0.0 - (size1.height) + (brickWidth/2))

                    for i in 0...bCount {
                        let brick1 = Brick.createBrick(CGPoint(x: anchorPoint.x, y: anchorPoint.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
                        parent.addChild(brick1)
                    }
                }
            }
            
        }
        
    }//End build box2_5
    
    func setCustomSpawnPoints() {
        maxMonsterCount = 10
        enemySpawnPoints = []
        spawnPoint1 = CGPoint(x: (activeScene?.size.width)!/2, y: (activeScene?.size.height)! * 0.53)
        spawnPoint2 = CGPoint(x: (activeScene?.size.width)!/2, y: (activeScene?.size.height)! * 0.47)
        spawnPoint3 = CGPoint(x: (activeScene?.size.width)! * 0.3, y: (activeScene?.size.height)! * 0.7)
        spawnPoint4 = CGPoint(x: (activeScene?.size.width)! * 0.3, y: (activeScene?.size.height)!/2)
        spawnPoint5 = CGPoint(x: (activeScene?.size.width)! * 0.4, y: (activeScene?.size.height)! * 0.5)
        spawnPoint6 = CGPoint(x: (activeScene?.size.width)! * 0.4, y: (activeScene?.size.height)! * 0.3)
        spawnPoint7 = CGPoint(x: (activeScene?.size.width)! * 0.55, y: (activeScene?.size.height)! * 0.32)
        spawnPoint8 = CGPoint(x: (activeScene?.size.width)! * 0.62, y: (activeScene?.size.height)! * 0.65)
        spawnPoint9 = CGPoint(x: (activeScene?.size.width)! * 0.7, y: (activeScene?.size.height)! * 0.65)
        spawnPoint10 = CGPoint(x: (activeScene?.size.width)! * 0.72, y: (activeScene?.size.height)! * 0.25)
        
        enemySpawnPoints.append(spawnPoint1)
        enemySpawnPoints.append(spawnPoint2)
        enemySpawnPoints.append(spawnPoint3)
        enemySpawnPoints.append(spawnPoint4)
        enemySpawnPoints.append(spawnPoint5)
        enemySpawnPoints.append(spawnPoint6)
        enemySpawnPoints.append(spawnPoint7)
        enemySpawnPoints.append(spawnPoint8)
        enemySpawnPoints.append(spawnPoint9)
        enemySpawnPoints.append(spawnPoint10)
        
    }

    //maze4 shift1 animation
    func maze4Shift1() {
        //before user grabs treasuer
        if treasureTaken == false {
            
            let duration = 0.5
            
            let rotateAction1 = SKAction.rotateByAngle(DegToRad(45), duration: duration)
            let rotateAction2 = SKAction.rotateByAngle(DegToRad(-180), duration: duration)
            let sequence = SKAction.sequence([rotateAction1,rotateAction2])
            box1.runAction(sequence)
            
        }else {
            
            let duration = 0.5
            
            let rotateAction1 = SKAction.rotateByAngle(DegToRad(135), duration: duration)
            let rotateAction2 = SKAction.rotateByAngle(DegToRad(-360), duration: duration)
            let sequence = SKAction.sequence([rotateAction1,rotateAction2])
            box1.runAction(sequence)
        }
        
        
        
    } // End: Maze4Shift
    
    func mazeShift() {
        
        if mazeShiftIndex % 2 == 0 {
            let duration = 1.0
            
            let rotateAction1 = SKAction.rotateByAngle(DegToRad(90.0), duration: duration)
            box2.runAction(rotateAction1)
            box5.runAction(rotateAction1)
        } else {
            let duration = 1.0
            
            let rotateAction1 = SKAction.rotateByAngle(DegToRad(-90.0), duration: duration)
            box3.runAction(rotateAction1)
            box4.runAction(rotateAction1)
        }
        
    }
    
    //maze shift timer
    func updateShiftTimer() {
        
        timer.position = CGPoint(x: frame.size.width * 0.10, y: frame.size.height * 0.80)
        timer.fontName = labelFont
        timer.fontSize = 14.0 * scale
        timer.fontColor = .redColor()
        self.addChild(timer)
        
        let actionwait = SKAction.waitForDuration(1.0)
        var seconds = 10
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
                self.maze4Shift1()
                
                self.timer.text = "Shift in \(seconds)"
                if seconds == 3 {
                    vc.playSoundEffect(Sound.alarmSound)
                }
                if seconds == 0 {
                    
                    self.mazeShift()
                    vc.alarmSound!.stop()
                    seconds = 11
                    self.mazeShiftIndex += 1
                }
                
                seconds -= 1
                
            }
            
            
        })
        self.timer.runAction(SKAction.repeatActionForever(SKAction.sequence([actionwait,actionrun])))
    }
    
}
// End: Maze4GameScene