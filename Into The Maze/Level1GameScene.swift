
import SpriteKit
import GameplayKit



class Level1GameScene: GameScene {
    
    
    //var TextureAtlas = SKTextureAtlas()
    
    
//    override func didMoveToView(view: SKView) {
//        
//        
////        let sceneBox = SKSpriteNode()
////        sceneBox.texture = SKTexture(imageNamed: "grassBackground.jpg")
////        sceneBox.size = CGSize(width: scene!.size.width, height: scene!.size.height * 0.5)
////        sceneBox.position = CGPointMake(scene!.size.width/2, scene!.size.height/2 + 170)
////        sceneBox.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: -scene!.size.width/2, y: -sceneBox.size.height/2, width: scene!.size.width, height: scene!.size.height * 0.5))
////        sceneBox.zPosition = 1
////        sceneBox.name = "sceneBox"
////        scene!.addChild(sceneBox)
//
//        
//        boundingBox2.zRotation = CGFloat(M_PI/3)
//        boundingBox3.zRotation = CGFloat(-M_PI/3)
//        
//        //build triangle maze
//        let tri1 = triangle.createNewTriangle(0.1, buffer: 50.0, parent: boundingBox, color: SKColor.greenColor())
//        triangle.createNewTriangle(0.5, buffer: 15.0, parent: boundingBox2,color: SKColor.greenColor())
//        triangle.createNewTriangle(0.8, buffer: 0.0, parent: boundingBox3,color: SKColor.yellowColor())
//        
//        delay(6.0) {
//            
//
//        }
//        
//        
//        //begin animation before game start
//        beginningAnimation(boundingBox, tri2: boundingBox2, tri3: boundingBox3)
//        
//        createNewScene()
//    }
    override func willMoveFromView(view: SKView) {
        

    }
    
    
    func beginningAnimation(tri1:SKSpriteNode,tri2:SKSpriteNode,tri3:SKSpriteNode) {
        let delay = SKAction.waitForDuration(1.0)
        let rotate = SKAction.rotateByAngle(CGFloat(2*M_PI), duration: 3.0)
        tri1.runAction(SKAction.sequence([delay, rotate]))
        //tri2.runAction(SKAction.sequence([delay, rotate]))
        tri3.runAction(SKAction.sequence([delay, rotate]))
        
        //tri2.runAction(SKAction.sequence([delay, rotate]))
        let del = SKAction.waitForDuration(2.0)
        let rot = SKAction.rotateByAngle(CGFloat(-2*M_PI), duration: 2.0)
        tri2.runAction(SKAction.sequence([del, rot]))

    }


    class triangle {

        
        class func createNewTriangle(scale: CGFloat, buffer: CGFloat, parent: SKSpriteNode, color:SKColor) -> SKShapeNode{
            
            //set length of side of Triangle based on scale passed in
            //which determines size of triangle
            let sideLength = boundingBox.size.width - boundingBox.size.width * scale
            let sideA = (sideLength/2)
            let sideB = sqrt((sideLength * sideLength) - (sideA * sideA))
            let startPoint = CGPointMake(-sideLength/2, (-sideB/2 + 20) + buffer)
            
            let path:CGMutablePathRef = CGPathCreateMutable()
            
            //start drawing triangle at Gap
            CGPathMoveToPoint(path, nil, 3 * sideLength/5, 0.0)
            CGPathAddLineToPoint(path, nil, sideLength, 0.0)
            CGPathAddLineToPoint(path, nil, sideLength/2, sideB)
            CGPathAddLineToPoint(path, nil, 0.0, 0.0)
            CGPathAddLineToPoint(path, nil, 2 * sideLength/5, 0.0)
            
            //build perpendicular bars based on scale of triangle
            if scale == 0.1 {
                CGPathAddLineToPoint(path, nil, 2 * sideLength/5, 60)
            }else if scale == 0.5{
                CGPathAddLineToPoint(path, nil, 2 * sideLength/5, 50)
            }else{
                
            }
            
            let triangle = SKShapeNode(path: path)
            triangle.lineWidth = 8.0
            triangle.strokeColor = mazeColor
            triangle.position = CGPoint(x: startPoint.x, y: startPoint.y)
            triangle.physicsBody = SKPhysicsBody(edgeChainFromPath: path)
            triangle.zPosition = 5
            triangle.name = "triangle"
            
            //add triangle to assigned boundingbox(parent) from argument
            parent.addChild(triangle)
            return triangle
        }
        
        class func getSpawnPoint(scale:CGFloat) -> CGPoint {
            let sideLength = boundingBox.size.width - boundingBox.size.width * scale
            let point:CGPoint = CGPointMake(2.5 * sideLength/5, 0.0)
            return point
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
}
    