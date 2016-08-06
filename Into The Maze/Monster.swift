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
var monsterIndex = 0
var monstersArray: [SKSpriteNode] = []

enum MonsterDirection {
    case North, NorthEast, East, SouthEast, South, SouthWest, West, NorthWest
}

class Monster:SKSpriteNode {
    
    var id = monsterIndex
    var alive = true
    
    init(id: Int) {
        self.alive = true
        let texture = SKTexture(imageNamed: "monster")
        super.init(texture: texture, color: .whiteColor(), size: texture.size())
    }
    
    func getIsAlive() -> Bool{
        return self.alive
    }
    func setIsAlive(bool: Bool) {
        self.alive = bool
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
    
    for monster in monstersArray {
            
        //createAnimationAtPoint(activeScene, point: monster.position, imageNamed: "instakill.png")
        let texture = SKTexture(imageNamed: "fireTexture.png")
        let fireball = createFireball(texture, point: CGPointZero, target: monster)
        monster.addChild(fireball)
        
        delay(0.5) {
            fireball.removeFromParent()
            fireball.targetNode = nil
            fireball.resetSimulation()
            
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
    let fireball = createFireball(texture, point: CGPointZero, target: node)
    node.addChild(fireball)
    
    delay(0.3) {
        fireball.removeFromParent()
        fireball.targetNode = nil
        fireball.resetSimulation()
        
        node.removeAllActions()
        node.removeFromParent()
    }
    monsterCount -= 1
    print("monster count: \(monsterCount)")
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











