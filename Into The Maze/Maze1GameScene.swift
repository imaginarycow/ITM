
import SpriteKit


extension GameScene {
    

    func loadMaze1() {
        
        let sideA = box1Width/2
        let sideB = sqrt((box1Width * box1Width) - (sideA * sideA))
        let yOffset:CGFloat = (box1Width - sideB)
        
        let parent1 = SKSpriteNode()
        let parent2 = SKSpriteNode()
        let parent3 = SKSpriteNode()
        let parent4 = SKSpriteNode()
        
        parent1.zPosition = 10
        parent1.position = CGPoint(x: startPoint.x - parent1.size.width/2, y: startPoint.y + yOffset)
        parent1.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        parent1.size = CGSize(width: box1Width, height: brickHeight + 5)
        //parent1.color = .blueColor()
        parent1.zRotation = DegToRad(0.0)
        box1.addChild(parent1)
        
        parent2.zPosition = 10
        parent2.position = CGPoint(x: startPoint.x + brickHeight, y: startPoint.y + yOffset)
        parent2.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        parent2.size = CGSize(width: box1Width, height: brickHeight + 5)
        //parent2.color = .redColor()
        parent2.zRotation = DegToRad(60.0)
        box1.addChild(parent2)
        
        parent3.zPosition = 10
        parent3.position = CGPoint(x: startPoint.x + box1Width, y: startPoint.y + yOffset + brickHeight/2)
        parent3.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        parent3.size = CGSize(width: box1Width, height: brickHeight + 5)
        //parent3.color = .redColor()
        parent3.zRotation = DegToRad(120.0)
        box1.addChild(parent3)

        
        parent4.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        boundingBox.addChild(parent4)
        
        
        
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

        
        delay(2.0) {
            let action = SKAction.rotateByAngle(self.DegToRad(360), duration: 2.0)
            box1.runAction(action)
        }
        
    }
}//Mark: End Extension
    