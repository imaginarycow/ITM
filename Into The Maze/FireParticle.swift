//
//  FireParticle.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/29/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import SpriteKit


let path = NSBundle.mainBundle().pathForResource("fire", ofType: "sks")
let fireParticle = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode

func createFireball(texture:SKTexture, point:CGPoint, target: SKNode) -> SKEmitterNode{
    
    let fireball = fireParticle
    
    fireball.resetSimulation()
    fireball.particleTexture = texture
    fireball.position = point
    fireball.targetNode = target
    fireball.zPosition = 100
    
    return fireball
    
}