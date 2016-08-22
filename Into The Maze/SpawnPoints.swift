//
//  SpawnPoints.swift
//  Into The Maze
//
//  Created by ramiro beltran on 8/11/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

var playerSpawn: CGPoint!
var lastRandomSpawnPoint:Int = 11

var enemySpawnPoints: [CGPoint] = []
var spawnPoint1: CGPoint = CGPoint(x: (activeScene?.size.width)!/2, y: (activeScene?.size.height)!/2)
var spawnPoint2: CGPoint = CGPoint(x: (activeScene?.size.width)!/2, y: (activeScene?.size.height)! * 0.7)
var spawnPoint3: CGPoint = CGPoint(x: (activeScene?.size.width)!/2, y: (activeScene?.size.height)! * 0.015)
var spawnPoint4: CGPoint = CGPoint(x: (activeScene?.size.width)! * 0.8, y: (activeScene?.size.height)!/2)
var spawnPoint5: CGPoint = CGPoint(x: (activeScene?.size.width)! * 0.7, y: (activeScene?.size.height)! * 0.5)
var spawnPoint6: CGPoint = CGPoint(x: (activeScene?.size.width)! * 0.6, y: (activeScene?.size.height)!/2)
var spawnPoint7: CGPoint = CGPoint(x: (activeScene?.size.width)! * 0.7, y: (activeScene?.size.height)! * 0.7)
var spawnPoint8: CGPoint = CGPoint(x: (activeScene?.size.width)! * 0.6, y: (activeScene?.size.height)! * 0.65)
var spawnPoint9: CGPoint = CGPoint(x: (activeScene?.size.width)! * 0.6, y: (activeScene?.size.height)! * 0.65)
var spawnPoint10: CGPoint = CGPoint(x: (activeScene?.size.width)! * 0.6, y: (activeScene?.size.height)! * 0.65)

func setEnemySpawnPoints() {
    maxMonsterCount = 10
    enemySpawnPoints = []
    spawnPoint1 = CGPoint(x: (activeScene?.size.width)!/2, y: (activeScene?.size.height)! * 0.44)
    spawnPoint2 = CGPoint(x: (activeScene?.size.width)!/2, y: (activeScene?.size.height)! * 0.7)
    spawnPoint3 = CGPoint(x: (activeScene?.size.width)!/2, y: (activeScene?.size.height)! * 0.015)
    spawnPoint4 = CGPoint(x: (activeScene?.size.width)! * 0.6, y: (activeScene?.size.height)!/2)
    spawnPoint5 = CGPoint(x: (activeScene?.size.width)! * 0.55, y: (activeScene?.size.height)! * 0.5)
    spawnPoint6 = CGPoint(x: (activeScene?.size.width)! * 0.2, y: (activeScene?.size.height)!/2)
    spawnPoint7 = CGPoint(x: (activeScene?.size.width)! * 0.45, y: (activeScene?.size.height)! * 0.45)
    spawnPoint8 = CGPoint(x: (activeScene?.size.width)! * 0.33, y: (activeScene?.size.height)! * 0.65)
    spawnPoint9 = CGPoint(x: (activeScene?.size.width)! * 0.3, y: (activeScene?.size.height)! * 0.4)
    spawnPoint10 = CGPoint(x: (activeScene?.size.width)! * 0.25, y: (activeScene?.size.height)! * 0.65)
    
    enemySpawnPoints.append(spawnPoint1)
    enemySpawnPoints.append(spawnPoint2)
    enemySpawnPoints.append(spawnPoint3)
    enemySpawnPoints.append(spawnPoint4)
    enemySpawnPoints.append(spawnPoint5)
    enemySpawnPoints.append(spawnPoint6)
    enemySpawnPoints.append(spawnPoint7)
    enemySpawnPoints.append(spawnPoint8)
    enemySpawnPoints.append(spawnPoint9)
    enemySpawnPoints.append(spawnPoint10)
    
}

func setEnemyAroundFlag() {
    maxMonsterCount = 20
    enemySpawnPoints = []
    
    spawnPoint1 = CGPoint(x: (activeScene?.size.width)! * 0.7, y: (activeScene?.size.height)!/2)
    spawnPoint2 = CGPoint(x: (activeScene?.size.width)! * 0.75, y: (activeScene?.size.height)! * 0.8)
    spawnPoint3 = CGPoint(x: (activeScene?.size.width)! * 0.8, y: (activeScene?.size.height)! * 0.75)
    spawnPoint4 = CGPoint(x: (activeScene?.size.width)! * 0.85, y: (activeScene?.size.height)!/2)
    spawnPoint5 = CGPoint(x: (activeScene?.size.width)! * 0.85, y: (activeScene?.size.height)! * 0.68)
    spawnPoint6 = CGPoint(x: (activeScene?.size.width)! * 0.77, y: (activeScene?.size.height)! * 0.88)
    spawnPoint7 = CGPoint(x: (activeScene?.size.width)! * 0.8, y: (activeScene?.size.height)! * 0.79)
    spawnPoint8 = CGPoint(x: (activeScene?.size.width)! * 0.7, y: (activeScene?.size.height)! * 0.9)
    spawnPoint9 = CGPoint(x: (activeScene?.size.width)! * 0.80, y: (activeScene?.size.height)! * 0.6)
    spawnPoint10 = CGPoint(x: (activeScene?.size.width)! * 0.87, y: (activeScene?.size.height)! * 0.5)
    
    enemySpawnPoints.append(spawnPoint1)
    enemySpawnPoints.append(spawnPoint2)
    enemySpawnPoints.append(spawnPoint3)
    enemySpawnPoints.append(spawnPoint4)
    enemySpawnPoints.append(spawnPoint5)
    enemySpawnPoints.append(spawnPoint6)
    enemySpawnPoints.append(spawnPoint7)
    enemySpawnPoints.append(spawnPoint8)
    enemySpawnPoints.append(spawnPoint9)
    enemySpawnPoints.append(spawnPoint10)
}

func getRandomEnemyPoint() -> CGPoint {
    
    var randomPoint = Int(arc4random_uniform(10))
    if randomPoint == lastRandomSpawnPoint {
        randomPoint = Int(arc4random_uniform(10))
    }
    lastRandomSpawnPoint = randomPoint
    print("enemy spawn point is point: \(randomPoint)")
    let point = enemySpawnPoints[randomPoint]
    
    return point
}
