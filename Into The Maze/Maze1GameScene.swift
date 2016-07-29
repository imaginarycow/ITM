
import SpriteKit


extension GameScene {
    

    func loadMaze1() {
        
        
        //Mark: Outer Triangle
        
        box1Width = CGFloat((scene?.size.height)! * 1.0)
        box1.size = CGSize(width: box1Width, height: box1Width)
        box1.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2 - 20.0)
        box1.zPosition = 5
        //box1.color = .orangeColor()
        self.addChild(box1)

        let sideA = box1Width/2
        let sideB = sqrt((box1Width * box1Width) - (sideA * sideA))
        let yOffset:CGFloat = (box1Width - sideB)
        
        
        abilityToken.position = CGPoint(x: 0.0 + (box1Width/2) - (abilityToken.size.width * 1.5), y: startPoint.y + yOffset + abilityToken.size.height)
        box1.addChild(abilityToken)
        
        let parent1 = SKSpriteNode()
        let parent2 = SKSpriteNode()
        let parent3 = SKSpriteNode()
        
        parent1.zPosition = 10
        parent1.position = CGPoint(x: startPoint.x - parent1.size.width/2, y: startPoint.y + yOffset)
        parent1.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        parent1.size = CGSize(width: box1Width, height: brickHeight)
        //parent1.color = .blueColor()
        parent1.zRotation = DegToRad(0.0)
        box1.addChild(parent1)
        
        parent2.zPosition = 10
        parent2.position = CGPoint(x: startPoint.x + brickHeight/2, y: startPoint.y + yOffset)
        parent2.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        parent2.size = CGSize(width: box1Width, height: brickHeight)
        //parent2.color = .redColor()
        parent2.zRotation = DegToRad(60.0)
        box1.addChild(parent2)
        
        parent3.zPosition = 10
        parent3.position = CGPoint(x: startPoint.x + box1Width + brickHeight/2, y: startPoint.y + yOffset + brickHeight/2)
        parent3.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        parent3.size = CGSize(width: box1Width, height: brickHeight)
        //parent3.color = .redColor()
        parent3.zRotation = DegToRad(120.0)
        box1.addChild(parent3)
        
        //End: Outer Triangle
        
        //Mark: Begin Middle Triangle
        
        let box2 = SKSpriteNode()
        box2.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2 - 20)
        let box2Width = box1Width * 0.7
        box2.size = CGSize(width: box2Width, height: box2Width)
        box2.zPosition = 6
        //box2.color = .yellowColor()
        self.addChild(box2)
        let numbBricks2:Int = 6
        let brickWidth2 = box2Width/CGFloat(numbBricks2)
        
        let side2A = box2Width/2
        let side2B = sqrt((box2Width * box2Width) - (side2A * side2A))
        let yOffset2:CGFloat = (box2Width - side2B)
        
        let parent4 = SKSpriteNode()
        let parent5 = SKSpriteNode()
        let parent6 = SKSpriteNode()
        let startPoint2 = CGPointMake((box2.anchorPoint.x - box2Width/2), (box2.anchorPoint.y - box2Width/2)+brickHeight/2)
        
        parent4.zPosition = 10
        parent4.position = CGPoint(x: startPoint2.x - parent4.size.width/2, y: startPoint2.y + yOffset2)
        parent4.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        parent4.size = CGSize(width: box2Width, height: brickHeight)
        //parent4.color = .blueColor()
        parent4.zRotation = DegToRad(0.0)
        box2.addChild(parent4)
        
        parent5.zPosition = 10
        parent5.position = CGPoint(x: startPoint2.x + brickHeight/2, y: startPoint2.y + yOffset2)
        parent5.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        parent5.size = CGSize(width: box2Width, height: brickHeight)
        //parent5.color = .redColor()
        parent5.zRotation = DegToRad(60.0)
        box2.addChild(parent5)
        
        parent6.zPosition = 10
        parent6.position = CGPoint(x: startPoint2.x + box2Width + brickHeight/2, y: startPoint2.y + yOffset2 + brickHeight/2)
        parent6.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        parent6.size = CGSize(width: box2Width, height: brickHeight)
        //parent6.color = .redColor()
        parent6.zRotation = DegToRad(120.0)
        box2.addChild(parent6)
        //End: Middle Triangle
        
        //Mark: InnerMostTriangle
        
        let box3 = SKSpriteNode()
        box3.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2 - 20)
        let box3Width = box1Width * 0.4
        box3.size = CGSize(width: box3Width, height: box3Width)
        box3.zPosition = 7
        //box2.color = .yellowColor()
        self.addChild(box3)
        let numbBricks3:Int = 3
        let brickWidth3 = box3Width/CGFloat(numbBricks3)
        let side3A = box3Width/2
        let side3B = sqrt((box3Width * box3Width) - (side3A * side3A))
        let yOffset3:CGFloat = (box3Width - side3B)
        
        let parent7 = SKSpriteNode()
        let parent8 = SKSpriteNode()
        let parent9 = SKSpriteNode()
        let startPoint3 = CGPointMake((box3.anchorPoint.x - box3Width/2), (box3.anchorPoint.y - box3Width/2)+brickHeight/2)
        
        parent7.zPosition = 10
        parent7.position = CGPoint(x: startPoint3.x - parent7.size.width/2, y: startPoint3.y + yOffset3)
        parent7.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        parent7.size = CGSize(width: box3Width, height: brickHeight)
        //parent7.color = .blueColor()
        parent7.zRotation = DegToRad(0.0)
        box3.addChild(parent7)
        
        parent8.zPosition = 10
        parent8.position = CGPoint(x: startPoint3.x + brickHeight/2, y: startPoint3.y + yOffset3)
        parent8.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        parent8.size = CGSize(width: box3Width, height: brickHeight)
        //parent8.color = .redColor()
        parent8.zRotation = DegToRad(60.0)
        box3.addChild(parent8)
        
        parent9.zPosition = 10
        parent9.position = CGPoint(x: startPoint3.x + box3Width + brickHeight/2, y: startPoint3.y + yOffset3 + brickHeight/2)
        parent9.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        parent9.size = CGSize(width: box3Width, height: brickHeight)
        //parent9.color = .redColor()
        parent9.zRotation = DegToRad(120.0)
        box3.addChild(parent9)
        //End: Inner Most Triangle
        
        //build outer triangle
        for i in 0...numbOfBricks-1 {
            
            let brick = Brick.createBrick(CGPoint(x: (0.0 + brickWidth/2) + (brickWidth * CGFloat(i)), y: 0.0 + brickHeight/2),brickWidth: brickWidth, rotation: 0.0)
            parent1.addChild(brick)
            if i != numbOfBricks/2 {
                let brick2 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth/2) + (brickWidth * CGFloat(i)), y: 0.0 + brickHeight/2),brickWidth: brickWidth, rotation: 0.0)
                parent2.addChild(brick2)
            }
            let brick3 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth/2) + (brickWidth * CGFloat(i)), y: 0.0 + brickHeight/2),brickWidth: brickWidth, rotation: 0.0)
            parent3.addChild(brick3)
            
        }
        //build middle triangle
        for j in 0...numbBricks2-1 {
         
            let brick = Brick.createBrick(CGPoint(x: (0.0 + brickWidth2/2) + (brickWidth2 * CGFloat(j)), y: 0.0 + brickHeight/2),brickWidth: brickWidth2, rotation: 0.0)
            parent4.addChild(brick)
            if j != numbBricks2/3 {
                let brick2 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth2/2) + (brickWidth2 * CGFloat(j)), y: 0.0 + brickHeight/2),brickWidth: brickWidth2, rotation: 0.0)
                parent6.addChild(brick2)
            }
            let brick3 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth2/2) + (brickWidth2 * CGFloat(j)), y: 0.0 + brickHeight/2),brickWidth: brickWidth2, rotation: 0.0)
            parent5.addChild(brick3)
        }
        //build inner most triangle
        for k in 0...numbBricks3-1 {
            
            let brick = Brick.createBrick(CGPoint(x: (0.0 + brickWidth3/2) + (brickWidth3 * CGFloat(k)), y: 0.0 + brickHeight/2),brickWidth: brickWidth3, rotation: 0.0)
            parent7.addChild(brick)
            if k != numbBricks3/3 {
                let brick2 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth3/2) + (brickWidth3 * CGFloat(k)), y: 0.0 + brickHeight/2),brickWidth: brickWidth3, rotation: 0.0)
                parent8.addChild(brick2)
            }
            let brick3 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth3/2) + (brickWidth3 * CGFloat(k)), y: 0.0 + brickHeight/2),brickWidth: brickWidth3, rotation: 0.0)
            parent9.addChild(brick3)
        }
        
        //rotation action
        delay(10.0) {
            let action = SKAction.rotateByAngle(self.DegToRad(360), duration: 2.0)
            box1.runAction(action)
            
            let action2 = SKAction.rotateByAngle(self.DegToRad(-360), duration: 2.0)
            box2.runAction(action2)
            parent4.removeAllChildren()
            parent5.removeAllChildren()
            parent6.removeAllChildren()
            for j in 0...numbBricks2-1 {
                
                let brick = Brick.createBrick(CGPoint(x: (0.0 + brickWidth2/2) + (brickWidth2 * CGFloat(j)), y: 0.0 + brickHeight/2),brickWidth: brickWidth2, rotation: 0.0)
                parent5.addChild(brick)
                if j != numbBricks2/3 {
                    let brick2 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth2/2) + (brickWidth2 * CGFloat(j)), y: 0.0 + brickHeight/2),brickWidth: brickWidth2, rotation: 0.0)
                    parent4.addChild(brick2)
                }
                let brick3 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth2/2) + (brickWidth2 * CGFloat(j)), y: 0.0 + brickHeight/2),brickWidth: brickWidth2, rotation: 0.0)
                parent6.addChild(brick3)
            }

            
            let action3 = SKAction.rotateByAngle(self.DegToRad(360), duration: 2.0)
            box3.runAction(action3)
        }
        
    }
}//Mark: End Extension
    