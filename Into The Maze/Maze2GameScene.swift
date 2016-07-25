

import Foundation
import SpriteKit

class Maze2GameScene: GameScene {
    
    
    let parent1 = SKSpriteNode()
    let parent2 = SKSpriteNode()
    let parent3 = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        
        
        createNewScene()
        createNewPlayer()
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        self.physicsWorld.contactDelegate = self
        
        //Mark: Joystick Handlers
        joystick.startHandler = { [unowned self] in
            
            //          guard let aN = self.Player else { return }
            //          aN.runAction(SKAction.sequence([SKAction.scaleTo(0.5, duration: 0.5), SKAction.scaleTo(1, duration: 0.5)]))
            
            self.Player!.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(self.TextureArray, timePerFrame: 0.2)))
            self.walking = true
            
        }
        
        //handles player position and rotation and gives direction for projectiles
        joystick.trackingHandler = { [unowned self] data in
            
            guard let plr = self.Player else { return }
            plr.position = CGPointMake(plr.position.x + (data.velocity.x * playerSpeed), plr.position.y + (data.velocity.y * playerSpeed))
            let x = data.velocity.x
            let y = data.velocity.y
            print("x:\(x)")
            print("y:\(y)")
            
            let xNum:CGFloat = 10.0
            let yNum:CGFloat = 15.0
            
            
            if x > xNum {
                if y < yNum && y > -yNum {
                    currentDirection = PlayerDirection.East
                    self.turnPlayer(currentDirection)
                }else if y >= yNum {
                    currentDirection = PlayerDirection.NorthEast
                    self.turnPlayer(currentDirection)
                } else {
                    currentDirection = PlayerDirection.SouthEast
                    self.turnPlayer(currentDirection)
                }
                //test if x < 0
            }else if x < -xNum{
                if y < yNum && y > -yNum {
                    currentDirection = PlayerDirection.West
                    self.turnPlayer(currentDirection)
                }else if y >= yNum {
                    currentDirection = PlayerDirection.NorthWest
                    self.turnPlayer(currentDirection)
                }else {
                    currentDirection = PlayerDirection.SouthWest
                    self.turnPlayer(currentDirection)
                }
                //test if x == 0
            }else {
                if y > 0 {
                    currentDirection = PlayerDirection.North
                    self.turnPlayer(currentDirection)
                }else {
                    currentDirection = PlayerDirection.South
                    self.turnPlayer(currentDirection)
                }
                
            }
            print(currentDirection)
            
            
            
        }
        
        joystick.stopHandler = { [unowned self] in
            
            //          guard let aN = self.Player else { return }
            //          aN.runAction(SKAction.sequence([SKAction.scaleTo(1.5, duration: 0.5), SKAction.scaleTo(1, duration: 0.5)]))
            self.Player!.removeAllActions()
            self.Player!.texture = SKTexture(imageNamed: "PlayerWalk01.png")
            self.walking = false
            
        }
        //Mark: End Joystick Handlers
        
        
        parent1.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        addChild(parent1)
        
        parent2.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        addChild(parent2)
        
        parent3.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        addChild(parent3)
        
        let triangle1 = Triangle.createTriangle(self, scale: 1.0, buffer: 0.0, color: .redColor())
        
        let triangle2 = Triangle.createTriangle(self, scale: 0.7, buffer: -10.0, color: .redColor())
        
        let triangle3 = Triangle.createTriangle(self, scale: 0.4, buffer: -20.0, color: .redColor())
        
        parent1.addChild(triangle1)
        //parent2.addChild(triangle2)
        parent3.addChild(triangle3)
        
    }

    
    
}