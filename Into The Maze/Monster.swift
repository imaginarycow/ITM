//
//  Monster.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/25/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

var MonsterSpeed : CGFloat = 0.1
let monsterSize:CGFloat = 15.0 * scale
var enemySpawnPoints: [CGPoint] = []
var monsterCount = 0
var monstersArray: [SKSpriteNode] = []

enum MonsterDirection {
    case North, NorthEast, East, SouthEast, South, SouthWest, West, NorthWest
}

class Monster:SKSpriteNode {
    
    class func newMonster() -> SKSpriteNode {
        
        let newMonster = SKSpriteNode(imageNamed: "monster")
        newMonster.size = CGSize(width: monsterSize * scale, height: monsterSize * scale)
        newMonster.zPosition = 100
        newMonster.name = "monster"
        
        newMonster.physicsBody = SKPhysicsBody(rectangleOfSize: newMonster.frame.size)
        newMonster.physicsBody?.categoryBitMask = monsterCategory
        newMonster.physicsBody?.collisionBitMask = bulletCategory | boundingBoxCategory | playerCategory | brickCategory
        newMonster.physicsBody?.contactTestBitMask = bulletCategory | boundingBoxCategory | playerCategory | brickCategory
        
        monstersArray.append(newMonster)
        
        return newMonster
        
    }
    
}
func removeAllEnemies() {
    
    for monster in monstersArray {
        monster.removeAllActions()
        monster.removeFromParent()
    }
    monstersArray = []
    monsterCount = 0
}

func removeEnemy(node:SKNode) {
    
    print("attempting to remove enemy")
    node.removeAllActions()
    node.removeFromParent()
    monsterCount -= 1
    
}

func setEnemySpawnPoints(point1:CGPoint, point2:CGPoint, point3:CGPoint, point4: CGPoint, point5:CGPoint) {
    
    enemySpawnPoints.append(point1)
    enemySpawnPoints.append(point2)
    enemySpawnPoints.append(point3)
    enemySpawnPoints.append(point4)
    enemySpawnPoints.append(point5)
    
}

func getRandomEnemyPoint() -> CGPoint {
    
    let randomPoint = Int(arc4random_uniform(5))
    print("enemy spawn point is point: \(randomPoint)")
    let point = enemySpawnPoints[randomPoint]
    
    return point
}











