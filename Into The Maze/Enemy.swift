//
//  Monster.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/25/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

var MonsterSpeed : CGFloat = 0.2
let monsterSize:CGFloat = 15.0 * scale
let teleportSize: CGFloat = 15.0 * scale

var monsterCount = 0
var maxMonsterCount = 10
var monsterIndex = 0
var monstersArray: [SKSpriteNode] = []
var monstersKilled = 0
var monstersKilledInLevel = 0
var monsterTextures = [SKTexture]()

enum MonsterDirection {
    case North, NorthEast, East, SouthEast, South, SouthWest, West, NorthWest
}
enum TeleportDirection {
    case up, down, left, right
}

class Monster:SKSpriteNode {
    
    var id = monsterIndex
    
    init(id: Int) {
        
        let texture = SKTexture(imageNamed: "walk01.png")
        super.init(texture: texture, color: .whiteColor(), size: texture.size())
    }
    
    func moveMonster(point1: CGPoint, point2: CGPoint) -> CGPoint {
        var moveToPoint = CGPoint()
        let x1 = point1.x
        let x2 = point2.x
        let y1 = point1.y
        let y2 = point2.y
        
        if x1 < x2 {
            moveToPoint.x = x1 + MonsterSpeed
        }else {
            moveToPoint.x = x1 - (MonsterSpeed)
        }
        if y1 < y2 {
            moveToPoint.y = y1 + (MonsterSpeed)
        }else {
            moveToPoint.y = y1 - (MonsterSpeed)
        }
        
        // then turn the zombie
        if moveToPoint.x == x1 {
            if moveToPoint.y == y1 {
                turnNode("player", node: self, direction: PlayerDirection.South)
            }else if moveToPoint.y > y1 {
                turnNode("player", node: self, direction: PlayerDirection.North)
            }else {
                turnNode("player", node: self, direction: PlayerDirection.South)
            }
            
        }
        if moveToPoint.x > x1 {
            if moveToPoint.y == y1 {
                turnNode("player", node: self, direction: PlayerDirection.East)
            }else if moveToPoint.y > y1 {
                turnNode("player", node: self, direction: PlayerDirection.NorthEast)
            }else {
                turnNode("player", node: self, direction: PlayerDirection.SouthEast)
            }
            
        }
        if moveToPoint.x < x1 {
            if moveToPoint.y == y1 {
                turnNode("player", node: self, direction: PlayerDirection.West)
            }else if moveToPoint.y > y1 {
                turnNode("player", node: self, direction: PlayerDirection.NorthWest)
            }else {
                turnNode("player", node: self, direction: PlayerDirection.SouthWest)
            }
            
        }
        
        return moveToPoint
    }
    
    func teleportMonster(point1: CGPoint, direction: TeleportDirection) -> CGPoint {
        var moveToPoint = CGPoint()
        let x1 = point1.x
        let y1 = point1.y
        
//        let teleportSprite1 = SKSpriteNode(imageNamed: "teleport.png")
//        teleportSprite1.size = CGSize(width: monsterSize, height: monsterSize)
//        self.addChild(teleportSprite1)
        
        
        switch direction {
        case .left:
            moveToPoint.x = x1 - (monsterSize + brickHeight)
            moveToPoint.y = y1
        case .right:
            moveToPoint.x = x1 + (monsterSize + brickHeight)
            moveToPoint.y = y1
        case .up:
            moveToPoint.x = x1
            moveToPoint.y = y1 + (monsterSize + brickHeight)
        case .down:
            moveToPoint.x = x1
            moveToPoint.y = y1 - (monsterSize + brickHeight)
        default:
            moveToPoint.x = x1 + (monsterSize + brickHeight)
            moveToPoint.y = y1

        }
        
        return moveToPoint
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

func removeAllEnemies() {
    monstersArray = []
    print("attempting to remove all monsters with instakill")
    print("monters in monstersArray: \(monstersArray.count)")
    
    //find all nodes in current scene with name "monster"
    activeScene.enumerateChildNodesWithName("monster", usingBlock: { (node, stop) -> Void in
        if node.name == "monster" {
            let monster = node as! SKSpriteNode
            monstersArray.append(monster)
        }
    })
    print("monters in monstersArray: \(monstersArray.count)")
    monstersKilledInLevel += monstersArray.count
    let points = 25 * monstersArray.count
    levelScore += points
    
    let texture = SKTexture(imageNamed: "spark.png")
    let sparks = createSpark(texture, point: CGPointZero, target: scoreLabel)
    scoreLabel.addChild(sparks)
    
    delay(0.3) {
        sparks.removeFromParent()
        sparks.targetNode = nil
        sparks.resetSimulation()
    }
    
    scoreLabel.text = String(format: "Score: %04u", levelScore)

    var i = 0
    for monster in monstersArray {
        
        //limit due to number of skemitters
        if i < 7 {
            
            //createAnimationAtPoint(activeScene, point: monster.position, imageNamed: "instakill.png")
            let texture = SKTexture(imageNamed: "fireTexture.png")
            let fireball = createFireball(texture, point: CGPointZero, target: monster)
            monster.addChild(fireball)
            i += 1
            
            delay(0.5) {
                fireball.removeFromParent()
                fireball.targetNode = nil
                fireball.resetSimulation()
                monster.removeAllActions()
                monster.removeFromParent()
            }

        } else {
            monster.removeAllActions()
            monster.removeFromParent()
        }
    }
    monstersArray = []
    monsterCount = 0
}

func removeEnemy(node:SKNode) {
    
    print("attempting to remove enemy")
    
    let texture = SKTexture(imageNamed: "fireTexture.png")
    let fireball = createFireball(texture, point: CGPointZero, target: activeScene)
    fireball.position = node.position
    activeScene.addChild(fireball)
    node.removeAllActions()
    node.removeFromParent()
    
    delay(0.3) {
        
        fireball.removeFromParent()
        fireball.targetNode = nil
        fireball.resetSimulation()
    }
    monsterCount -= 1
    print("monster count: \(monsterCount)")
    
    if monstersKilled < 10 {
        monstersKilled += 1
    }
    if monstersKilled == 10 {
        monstersKilled = 0
        abilityTokens += 1
        setAbilityForUse(abilityTokens)
        gameData.setInteger(abilityTokens, forKey: "abilityTokens")
    }
    monstersKilledInLevel += 1
}


//build monster texture atlas
func setEnemyTexture() {
    monsterTextures = []
    let TextureAtlas = SKTextureAtlas(named: "zombieWalk")
    var Name = ""
    for i in 01...(TextureAtlas.textureNames.count - 1) {
        if i < 10 {
            Name = "walk0\(i)"
        }else {
            Name = "walk\(i)"
        }
        
        monsterTextures.append(SKTexture(imageNamed: Name))
    }
    print("number in monsterTextures: \(monsterTextures.count)")
   
}











