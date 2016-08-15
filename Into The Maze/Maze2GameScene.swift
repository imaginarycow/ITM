
import SpriteKit

let boxZPosition: CGFloat = 5
let parentZPosition: CGFloat = 10

class Maze2GameScene: GameScene {
    
    let numbBricks2:Int = 6
    var brickWidth2:CGFloat!
    
//    var parent1 = SKSpriteNode()
//    let parent2 = SKSpriteNode()
//    let parent3 = SKSpriteNode()
//    let parent4 = SKSpriteNode()
//    let parent5 = SKSpriteNode()
//    let parent6 = SKSpriteNode()
//    let parent7 = SKSpriteNode()
//    let parent8 = SKSpriteNode()
//    let parent9 = SKSpriteNode()
//    let parent10 = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        
        playerSpawn = CGPoint(x: ((scene?.size.width)! * 0.2), y: (scene?.size.height)!/2)
        finishPosition = CGPoint(x: ((scene?.size.width)! * 0.9), y: (scene?.size.height)! * 0.85)
        createNewScene()
        
        updateShiftTimer()
        updateClock()
        setEnemySpawnPoints()
        
        abilityToken.position = CGPoint()
        box1.addChild(abilityToken)
        
        buildOuterWall()
        buildBox1()
        buildBoxes2_5()
        buildBox6()
        buildOuterCircle()
        buildInnerCircle()
        
    }
    
    override func willMoveFromView(view: SKView) {
//        parent1.removeAllActions()
//        parent2.removeAllActions()
//        parent3.removeAllActions()
//        parent4.removeAllActions()
//        parent5.removeAllActions()
//        parent6.removeAllActions()
//        box1.removeAllActions()
//        box1.removeAllChildren()
//        box1.removeFromParent()
//        box2.removeAllActions()
//        box2.removeAllChildren()
//        box2.removeFromParent()
//        box3.removeAllActions()
//        box3.removeAllChildren()
//        box3.removeFromParent()
    }
    
    func buildOuterWall() {
        
        let outerWall = SKSpriteNode()
        let outerWallLength = CGFloat((scene?.size.height)! * 1.0)
        outerWall.size = CGSize(width: outerWallLength, height: outerWallLength)
        outerWall.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        outerWall.zPosition = boxZPosition
        outerWall.color = .orangeColor()
        outerWall.alpha = 0.3
        self.addChild(outerWall)
        
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
            let rot = Double(DegToRad(90.0))
            let anchorPoint1: CGPoint = CGPoint(x: 0.0, y: 0.0 - (sideLength1 / 2) + (brickWidth/2))
            let brick = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            let brick2 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            
            // create entry and exit
            if i == numbOfBricks / 2 {
                
            }else {
                parent1.addChild(brick)
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
        box1Width = CGFloat((scene?.size.height)! * 0.8)
        box1.size = CGSize(width: box1Width, height: box1Width)
        box1.color = .greenColor()
        box1.zPosition = boxZPosition + 1
        box1.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        box1.alpha = 0.5
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
        
        let scale = CGFloat((scene?.size.height)! * 1.0) / box1Width
        let numbBricks = numbOfBricks * Int(scale)
        
        for i in 0...numbBricks-1 {
            let rot = Double(DegToRad(90.0))
            let anchorPoint1: CGPoint = CGPoint(x: 0.0, y: 0.0 - (parentSize1.height / 2) + (brickWidth/2))
            let brick1 = Brick.createBrick(CGPoint(x: anchorPoint1.x,y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: 0.0)
            parent5.addChild(brick1)
        }
    }
    
    func buildBoxes2_5() {
        
    }
    
    func buildBox6() {
        
        
    }
    
    func buildOuterCircle() {
        
    }
    
    func buildInnerCircle() {
        
    }
    
    //maze1 shift1 animation
//    func maze2Shift(index: Int) {
//        
//        let duration = 6.0
//        
//        if index % 2 == 0 {
//            
//            let action = SKAction.rotateByAngle(DegToRad(360), duration: duration)
//            box1.runAction(action)
//            
//            let action2 = SKAction.rotateByAngle(DegToRad(-360), duration: duration)
//            box2.runAction(action2)
//            parent4.removeAllChildren()
//            parent5.removeAllChildren()
//            parent6.removeAllChildren()
//            
//            for j in 0...numbBricks2-1 {
//                
//                let brick = Brick.createBrick(CGPoint(x: (0.0 + brickWidth2/2) + (brickWidth2 * CGFloat(j)), y: 0.0 + brickHeight/2),brickWidth: brickWidth2, rotation: 0.0)
//                parent5.addChild(brick)
//                
//                if j != numbBricks2/3 {
//                    let brick2 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth2/2) + (brickWidth2 * CGFloat(j)), y: 0.0 + brickHeight/2),brickWidth: brickWidth2, rotation: 0.0)
//                    parent4.addChild(brick2)
//                }
//                
//                let brick3 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth2/2) + (brickWidth2 * CGFloat(j)), y: 0.0 + brickHeight/2),brickWidth: brickWidth2, rotation: 0.0)
//                parent6.addChild(brick3)
//            }
//            
//            parent1.removeAllChildren()
//            parent2.removeAllChildren()
//            parent3.removeAllChildren()
//            
//            for i in 0...numbOfBricks-1 {
//                
//                let brick = Brick.createBrick(CGPoint(x: (0.0 + brickWidth/2) + (brickWidth * CGFloat(i)), y: 0.0 + brickHeight/2),brickWidth: brickWidth, rotation: 0.0)
//                parent1.addChild(brick)
//                if i != numbOfBricks/2 {
//                    let brick2 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth/2) + (brickWidth * CGFloat(i)), y: 0.0 + brickHeight/2),brickWidth: brickWidth, rotation: 0.0)
//                    parent2.addChild(brick2)
//                }
//                let brick3 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth/2) + (brickWidth * CGFloat(i)), y: 0.0 + brickHeight/2),brickWidth: brickWidth, rotation: 0.0)
//                parent3.addChild(brick3)
//                
//            }
//            
//            
//            let action3 = SKAction.rotateByAngle(DegToRad(360), duration: duration)
//            box3.runAction(action3)
//            
//        }else {
//            
//            let action = SKAction.rotateByAngle(DegToRad(-360), duration: duration)
//            box1.runAction(action)
//            
//            let action2 = SKAction.rotateByAngle(DegToRad(360), duration: duration)
//            box2.runAction(action2)
//            parent1.removeAllChildren()
//            parent2.removeAllChildren()
//            parent3.removeAllChildren()
//            
//            for i in 0...numbOfBricks-1 {
//                
//                let brick = Brick.createBrick(CGPoint(x: (0.0 + brickWidth/2) + (brickWidth * CGFloat(i)), y: 0.0 + brickHeight/2),brickWidth: brickWidth, rotation: 0.0)
//                parent1.addChild(brick)
//                if i != numbOfBricks/2 {
//                    let brick2 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth/2) + (brickWidth * CGFloat(i)), y: 0.0 + brickHeight/2),brickWidth: brickWidth, rotation: 0.0)
//                    parent3.addChild(brick2)
//                }
//                let brick3 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth/2) + (brickWidth * CGFloat(i)), y: 0.0 + brickHeight/2),brickWidth: brickWidth, rotation: 0.0)
//                parent2.addChild(brick3)
//                
//            }
//            
//            let action3 = SKAction.rotateByAngle(DegToRad(-360), duration: duration)
//            box3.runAction(action3)
//        }
//        
//    } // End: Maze1Shift
    
    //maze shift timer
    func updateShiftTimer() {
        
        timer.position = CGPoint(x: frame.size.width * 0.15, y: frame.size.height * 0.80)
        timer.fontName = labelFont
        timer.fontSize = 18.0
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
                    let texture = SKTexture(imageNamed: "spark.png")
                    let sparks = createSpark(texture, point: CGPointZero, target: self.timer)
                    self.timer.addChild(sparks)
                    
                    delay(0.3) {
                        sparks.removeFromParent()
                        sparks.targetNode = nil
                        sparks.resetSimulation()
                    }
                    
                }
                
                freezeTimer -= 1
                if freezeTimer == 0 {
                    timerIsFrozen = false
                    freezeTimer = 10
                    self.timer.fontColor = .redColor()
                }
                
                
            } else {
                if seconds % 5 == 0 && monsterCount < maxMonsterCount {
                    
                    self.createNewMonster(getRandomEnemyPoint())
                    monsterCount += 1
                    print("monster count: \(monsterCount)")
                }
                
                self.timer.text = "Maze Shift in: \(seconds)"
                if seconds == 3 {
                    vc.playSoundEffect(Sound.alarmSound)
                }
                if seconds == 0 {
                    
                    //self.maze2Shift(self.mazeShiftIndex)
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
// End: Maze2GameScene