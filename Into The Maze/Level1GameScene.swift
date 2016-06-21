
import SpriteKit
import GameplayKit

let boundingBox = SKSpriteNode()

class level1GameScene: GameScene {
    
    //var TextureAtlas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    var Player = SKSpriteNode()
    var walking: Bool = false
    
    override func didMoveToView(view: SKView) {
                
        //boundingBox.color = SKColor.redColor()
        boundingBox.size = CGSize(width: scene!.size.width * 0.7, height: scene!.size.width * 0.7)
        boundingBox.position = CGPointMake(scene!.size.width/2, scene!.size.height/2 + scene!.size.height * 0.2 )
        boundingBox.zPosition = 1
        boundingBox.name = "boundingBox"
        scene!.addChild(boundingBox)
        
        let boundingBox2 = SKSpriteNode()
        //boundingBox2.color = SKColor.greenColor()
        boundingBox2.size = CGSize(width: 200, height: 200)
        boundingBox2.position = CGPointMake(scene!.size.width/2, scene!.size.height/2 + scene!.size.height * 0.2)
        boundingBox2.zPosition = 2
        boundingBox2.name = "boundingBox2"
        scene!.addChild(boundingBox2)
        
        let boundingBox3 = SKSpriteNode()
        //boundingBox3.color = SKColor.yellowColor()
        boundingBox3.size = CGSize(width: 100, height: 100)
        boundingBox3.position = CGPointMake(scene!.size.width/2, scene!.size.height/2 + scene!.size.height * 0.2)
        boundingBox3.zPosition = 3
        boundingBox3.name = "boundingBox3"
        scene!.addChild(boundingBox3)
        
        let sceneBox = SKSpriteNode()
        //sceneBox.texture = SKTexture(imageNamed: "grassBackground.jpg")
        sceneBox.size = CGSize(width: scene!.size.width, height: scene!.size.height * 0.5)
        sceneBox.position = CGPointMake(scene!.size.width/2, scene!.size.height/2 + 170)
        sceneBox.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: -scene!.size.width/2, y: -sceneBox.size.height/2, width: scene!.size.width, height: scene!.size.height * 0.5))
        sceneBox.zPosition = 1
        sceneBox.name = "sceneBox"
        scene!.addChild(sceneBox)
        
        let redCirc = SKShapeNode(circleOfRadius: 7.0)
        redCirc.position = CGPointMake(0.0, 0.0)
        redCirc.physicsBody = SKPhysicsBody(circleOfRadius: 7.0)
        redCirc.fillColor = .redColor()
        redCirc.zPosition = 5
        redCirc.name = "redCirc"
        boundingBox2.addChild(redCirc)
        //redBox.physicsBody?.applyForce(CGVector(dx: 50.0,dy: 600.0))
        redCirc.physicsBody?.restitution = 0.6
        
        boundingBox.zRotation = CGFloat(M_PI)
        boundingBox2.zRotation = CGFloat(M_PI/3)
        boundingBox3.zRotation = CGFloat(-M_PI/3)
        
        //build triangle maze
        let tri1 = triangle.createNewTriangle(0.1, buffer: 50.0, parent: boundingBox, color: SKColor.greenColor())
        triangle.createNewTriangle(0.5, buffer: 15.0, parent: boundingBox2,color: SKColor.greenColor())
        triangle.createNewTriangle(0.8, buffer: 0.0, parent: boundingBox3,color: SKColor.yellowColor())
        
        delay(6.0) {
            
            self.Player = createPlayer()
            self.Player.position = triangle.getSpawnPoint(0.1)
            self.Player.zPosition = 100
            self.Player.alpha = 1.0
            tri1.addChild(self.Player)
        }
        
        TextureArray = createTextureArray()
        //begin animation before game start
        beginningAnimation(boundingBox, tri2: boundingBox2, tri3: boundingBox3)
        
        createNewScene()
    }
    override func willMoveFromView(view: SKView) {

        boundingBox.removeFromParent()
        boundingBox.removeAllChildren()
        
        Player.removeFromParent()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if walking {
            Player.removeAllActions()
            Player.texture = SKTexture(imageNamed: "PlayerWalk01.png")
            walking = false
        }else {
            Player.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(TextureArray, timePerFrame: 0.2)))
            walking = true
        }
        
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
    