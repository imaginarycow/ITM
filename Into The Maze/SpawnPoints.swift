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

var enemySpawnPoints: [CGPoint] = []
var spawnPoint1: CGPoint = CGPoint(x: (activeScene?.size.width)!/2, y: (activeScene?.size.height)!/2)
var spawnPoint2: CGPoint = CGPoint(x: (activeScene?.size.width)!/2, y: (activeScene?.size.height)! * 0.85)
var spawnPoint3: CGPoint = CGPoint(x: (activeScene?.size.width)!/2, y: (activeScene?.size.height)! * 0.015)
var spawnPoint4: CGPoint = CGPoint(x: (activeScene?.size.width)! * 0.8, y: (activeScene?.size.height)!/2)
var spawnPoint5: CGPoint = CGPoint(x: (activeScene?.size.width)! * 0.1, y: (activeScene?.size.height)! * 0.65)
var spawnPoint6: CGPoint = CGPoint(x: (activeScene?.size.width)!/2, y: (activeScene?.size.height)!/2)
var spawnPoint7: CGPoint = CGPoint(x: (activeScene?.size.width)!/2, y: (activeScene?.size.height)!/2)
var spawnPoint8: CGPoint = CGPoint(x: (activeScene?.size.width)!/2, y: (activeScene?.size.height)!/2)


func setEnemySpawnPoints() {
    
    enemySpawnPoints.append(spawnPoint1)
    enemySpawnPoints.append(spawnPoint2)
    enemySpawnPoints.append(spawnPoint3)
    enemySpawnPoints.append(spawnPoint4)
    enemySpawnPoints.append(spawnPoint5)
    
}

func getRandomEnemyPoint() -> CGPoint {
    
    let randomPoint = Int(arc4random_uniform(5))
    print("enemy spawn point is point: \(randomPoint)")
    let point = enemySpawnPoints[randomPoint]
    
    return point
}
