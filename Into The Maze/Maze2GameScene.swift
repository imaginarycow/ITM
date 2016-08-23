
import SpriteKit

let boxZPosition: CGFloat = 5
let parentZPosition: CGFloat = 10


class Maze2GameScene: GameScene {
    
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
        
        //ability token set in buildOuterWall()
        
        buildOuterWall()
        buildBox1A()
        buildBoxes2_5()
        buildBox6()
        buildOuterCircle()
        
    }
    
    override func willMoveFromView(view: SKView) {
        
    }
    
    func buildOuterWall() {
        
        let outerWallLength = CGFloat((scene?.size.height)! * 1.0)
        outerWall.size = CGSize(width: outerWallLength, height: outerWallLength)
        outerWall.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        outerWall.zPosition = boxZPosition
        addChild(outerWall)
        
        abilityToken.position = CGPoint(x: 0.0 + (outerWall.size.width / 2) - abilityToken.size.width, y: 0.0 + (outerWall.size.width / 2) - abilityToken.size.width)
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
            if i == numbOfBricks / 2 {
                
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
    
    func buildBox1A() {
        box1.removeAllActions()
        box1.removeAllChildren()
        box1.removeFromParent()
        box1 = SKSpriteNode() //reset box1
        print("building box 1 bricks")
        box1Width = CGFloat((scene?.size.height)! * 0.8)
        box1.size = CGSize(width: box1Width, height: box1Width)
        //box1.color = .greenColor()
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
    func buildBox1B() { //for maze shift
        box1.removeAllActions()
        box1.removeAllChildren()
        box1.removeFromParent()
        box1 = SKSpriteNode()  //reset box1
        print("building box 1 bricks")
        box1Width = CGFloat((scene?.size.height)! * 0.67)
        box1.size = CGSize(width: box1Width, height: box1Width)
        //box1.color = .greenColor()
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
        
        let width = CGFloat(outerWall.size.height * 0.2)
        box2.size = CGSize(width: width, height: width)
        box2.position = CGPoint(x: 0.0 - (width * 1.5), y: 0.0 + (width * 1.5))
        box2.zPosition = boxZPosition
        box2.zRotation = DegToRad(180.0)
        //box2.color = .orangeColor()
        outerWall.addChild(box2)
        
        box3.size = CGSize(width: width, height: width)
        box3.position = CGPoint(x: 0.0 - (width * 1.5), y: 0.0 - (width * 1.5))
        box3.zPosition = boxZPosition
        box3.zRotation = DegToRad(180.0)
        //box3.color = .orangeColor()
        outerWall.addChild(box3)
        
        box4.size = CGSize(width: width, height: width)
        box4.position = CGPoint(x: 0.0 + (width * 1.5), y: 0.0 + (width * 1.5))
        box4.zPosition = boxZPosition
        box4.zRotation = DegToRad(180.0)
        //box4.color = .orangeColor()
        outerWall.addChild(box4)
        
        box5.size = CGSize(width: width, height: width)
        box5.position = CGPoint(x: 0.0 + (width * 1.5), y: 0.0 - (width * 1.5))
        box5.zPosition = boxZPosition
        box5.zRotation = DegToRad(180.0)
        //box5.color = .orangeColor()
        outerWall.addChild(box5)
        
        let size1 = CGSize(width: brickHeight, height: width)
        let rot = DegToRad(90.0)
        
        let parent1 = Parent.newParent(CGPoint(x: 0.0 - (width / 2), y: 0.0), size: size1)
        box2.addChild(parent1)
        let parent2 = Parent.newParent(CGPoint(x: 0.0, y: 0.0 + (width / 2)), size: size1)
        parent2.zRotation = rot
        box2.addChild(parent2)
        
        let parent3 = Parent.newParent(CGPoint(x: 0.0 - (width / 2), y: 0.0), size: size1)
        box3.addChild(parent3)
        let parent4 = Parent.newParent(CGPoint(x: 0.0, y: 0.0 - (width / 2)), size: size1)
        parent4.zRotation = rot
        box3.addChild(parent4)
        
        let parent5 = Parent.newParent(CGPoint(x: 0.0 + (width / 2), y: 0.0), size: size1)
        box4.addChild(parent5)
        let parent6 = Parent.newParent(CGPoint(x: 0.0, y: 0.0 + (width / 2)), size: size1)
        parent6.zRotation = rot
        box4.addChild(parent6)
        
        let parent7 = Parent.newParent(CGPoint(x: 0.0 + (width / 2), y: 0.0), size: size1)
        box5.addChild(parent7)
        let parent8 = Parent.newParent(CGPoint(x: 0.0, y: 0.0 - (width / 2)), size: size1)
        parent8.zRotation = rot
        box5.addChild(parent8)
        
        let numbBricks = Int(size1.height / brickWidth)
        for i in 0...numbBricks-1 {
            let rot = Double(DegToRad(90.0))
            let anchorPoint1: CGPoint = CGPoint(x: 0.0, y: 0.0 - (size1.height / 2) + (brickWidth/2))
            let brick1 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            let brick2 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            parent1.addChild(brick1)
            parent2.addChild(brick2)
            
            let brick3 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            let brick4 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            parent3.addChild(brick3)
            parent4.addChild(brick4)

            let brick5 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            let brick6 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            parent5.addChild(brick5)
            parent6.addChild(brick6)

            let brick7 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            let brick8 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            parent7.addChild(brick7)
            parent8.addChild(brick8)
        }

    }
    
    func buildBox6() {
        
        let width = CGFloat(outerWall.size.height * 0.5)
        box6.size = CGSize(width: width, height: width)
        box6.position = CGPoint(x: 0.0, y: 0.0)
        box6.zPosition = boxZPosition
        box6.zRotation = DegToRad(45.0)
        //box6.color = .greenColor()
        outerWall.addChild(box6)
        
        let length = width * 0.8
        let size1 = CGSize(width: brickHeight, height: length)
        let size2 = CGSize(width: length, height: brickHeight)
        
        let parent1 = Parent.newParent(CGPoint(x: 0.0 - (width / 2), y: 0.0), size: size1)
        box6.addChild(parent1)
        let parent2 = Parent.newParent(CGPoint(x: 0.0 + (width / 2), y: 0.0), size: size1)
        box6.addChild(parent2)
        let parent3 = Parent.newParent(CGPoint(x: 0.0, y: 0.0 + (width / 2)), size: size2)
        box6.addChild(parent3)
        let parent4 = Parent.newParent(CGPoint(x: 0.0, y: 0.0 - (width / 2)), size: size2)
        box6.addChild(parent4)
        
        let numbBricks = Int(size1.height / brickWidth)
        for i in 0...numbBricks-1 {
            let rot = Double(DegToRad(90.0))
            let anchorPoint1: CGPoint = CGPoint(x: 0.0, y: 0.0 - (size1.height / 2) + (brickWidth/2))
            let brick1 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            let brick2 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            parent1.addChild(brick1)
            parent2.addChild(brick2)
            
            let anchorPoint2: CGPoint = CGPoint(x: 0.0 - (size1.height / 2) + (brickWidth/2), y: 0.0)
            let brick3 = Brick.createBrick(CGPoint(x: anchorPoint2.x + (brickWidth * CGFloat(i)), y: anchorPoint2.y), brickWidth: brickWidth, rotation: 0.0)
            let brick4 = Brick.createBrick(CGPoint(x: anchorPoint2.x + (brickWidth * CGFloat(i)), y: anchorPoint2.y), brickWidth: brickWidth, rotation: 0.0)
            parent3.addChild(brick3)
            parent4.addChild(brick4)
        }
    }
    
    func buildOuterCircle() {
        
        let width = CGFloat(outerWall.size.height * 0.3)
        box7.size = CGSize(width: width, height: width)
        box7.position = CGPoint(x: 0.0, y: 0.0)
        box7.zPosition = boxZPosition
        //box7.color = .redColor()
        outerWall.addChild(box7)
        
        let length = width * 0.4
        let size1 = CGSize(width: brickHeight, height: length)
        let rot = DegToRad(90.0)
        
        let parent1 = Parent.newParent(CGPoint(x: 0.0 - (width / 2), y: 0.0), size: size1)
        parent1.zRotation = rot
        box7.addChild(parent1)
        let parent2 = Parent.newParent(CGPoint(x: 0.0 + (width / 2), y: 0.0), size: size1)
        parent2.zRotation = rot
        box7.addChild(parent2)
        let parent3 = Parent.newParent(CGPoint(x: 0.0, y: 0.0 + (width / 2)), size: size1)
        box7.addChild(parent3)
        let parent4 = Parent.newParent(CGPoint(x: 0.0, y: 0.0 - (width / 2)), size: size1)
        box7.addChild(parent4)
        
        let numbBricks = Int(size1.height / brickWidth)
        for i in 0...numbBricks-1 {
            let rot = Double(DegToRad(90.0))
            let anchorPoint1: CGPoint = CGPoint(x: 0.0, y: 0.0 - (size1.height / 2) + (brickWidth/2))
            let brick1 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            let brick2 = Brick.createBrick(CGPoint(x: anchorPoint1.x, y: anchorPoint1.y + (brickWidth * CGFloat(i))), brickWidth: brickWidth, rotation: rot)
            parent1.addChild(brick1)
            parent2.addChild(brick2)
            
            let anchorPoint2: CGPoint = CGPoint(x: 0.0 - (size1.height / 2) + (brickWidth/2), y: 0.0)
            let brick3 = Brick.createBrick(CGPoint(x: anchorPoint2.x + (brickWidth * CGFloat(i)), y: anchorPoint2.y), brickWidth: brickWidth, rotation: rot)
            let brick4 = Brick.createBrick(CGPoint(x: anchorPoint2.x + (brickWidth * CGFloat(i)), y: anchorPoint2.y), brickWidth: brickWidth, rotation: rot)
            parent3.addChild(brick3)
            parent4.addChild(brick4)
        }

    }
    
    //maze2 shift1 animation
    func maze2Shift() {
        //before user grabs treasure
        if treasureTaken == false {
            
            let duration = 0.5
            
            let rotateAction = SKAction.rotateByAngle(DegToRad(30), duration: duration)
            box2.runAction(rotateAction)
            box3.runAction(rotateAction)
            box4.runAction(rotateAction)
            box5.runAction(rotateAction)
            
            let rotateAction2 = SKAction.rotateByAngle(DegToRad(-75), duration: 1.0)
            box7.runAction(rotateAction2)
        }else {
            
            let duration = 0.5
            
            let rotateAction = SKAction.rotateByAngle(DegToRad(90), duration: duration)
            box2.runAction(rotateAction)
            box3.runAction(rotateAction)
            box4.runAction(rotateAction)
            box5.runAction(rotateAction)
            
            let rotateAction2 = SKAction.rotateByAngle(DegToRad(-180), duration: 1.0)
            box7.runAction(rotateAction2)
        }
        
    } // End: Maze2Shift
    
    func box1Shift() {
        
        if mazeShiftIndex % 2 == 0 {
            buildBox1B()
            mazeShiftIndex += 1
        }else {
            buildBox1A()
            mazeShiftIndex += 1
        }
        
    }
    
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
                self.maze2Shift()
                
                self.timer.text = "Maze Shifting!"
                if seconds == 3 {
                    vc.playSoundEffect(Sound.alarmSound)
                }
                if seconds == 0 {
                    
                    self.box1Shift()
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