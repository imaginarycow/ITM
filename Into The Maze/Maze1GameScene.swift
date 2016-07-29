
import SpriteKit


extension GameScene {
    

    func loadMaze1() {
        
        
        //Mark: Outer Triangle
        
        let sideA = box1Width/2
        let sideB = sqrt((box1Width * box1Width) - (sideA * sideA))
        let yOffset:CGFloat = (box1Width - sideB)
        
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
        
        //Mark: Inner Triangle
        
        let box2 = SKSpriteNode()
        box2.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        let box2Width = box1Width * 0.6
        box2.size = CGSize(width: box2Width, height: box2Width)
        box2.zPosition = 6
        //box2.color = .yellowColor()
        self.addChild(box2)
        let numbBricks2:Int = 6
        let brickWidth2 = box2Width/CGFloat(numbBricks2)
        let yOffset2:CGFloat = 15.0
        
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
        
        
        
        //build outer triangle
        for i in 0...numbOfBricks-1 {
            
            let brick = Brick.createBrick(CGPoint(x: (0.0 + brickWidth/2) + (brickWidth * CGFloat(i)), y: 0.0 + brickHeight/2), rotation: 0.0)
            parent1.addChild(brick)
            if i != numbOfBricks/2 {
                let brick2 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth/2) + (brickWidth * CGFloat(i)), y: 0.0 + brickHeight/2), rotation: 0.0)
                parent2.addChild(brick2)
            }
            let brick3 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth/2) + (brickWidth * CGFloat(i)), y: 0.0 + brickHeight/2), rotation: 0.0)
            parent3.addChild(brick3)
            
        }
        
        for j in 0...numbBricks2-1 {
         
            let brick = Brick.createBrick(CGPoint(x: (0.0 + brickWidth/2) + (brickWidth * CGFloat(j)), y: 0.0 + brickHeight/2), rotation: 0.0)
            parent4.addChild(brick)
            if j != numbBricks2/3 {
                let brick2 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth/2) + (brickWidth * CGFloat(j)), y: 0.0 + brickHeight/2), rotation: 0.0)
                parent6.addChild(brick2)
            }
            let brick3 = Brick.createBrick(CGPoint(x: (0.0 + brickWidth/2) + (brickWidth * CGFloat(j)), y: 0.0 + brickHeight/2), rotation: 0.0)
            parent5.addChild(brick3)
        }
        
        delay(2.0) {
            let action = SKAction.rotateByAngle(self.DegToRad(360), duration: 2.0)
            box1.runAction(action)
            
            let action2 = SKAction.rotateByAngle(self.DegToRad(-360), duration: 2.0)
            box2.runAction(action2)
        }
        
    }
}//Mark: End Extension
    