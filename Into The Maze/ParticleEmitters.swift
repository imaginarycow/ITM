//
//  FireParticle.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/29/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import SpriteKit

enum ParticleType {
    case fire, spark
}

var fireCount = 0
var sparkCount = 0

let fire1 = NSBundle.mainBundle().pathForResource("fire1", ofType: "sks")
let fireParticle1 = NSKeyedUnarchiver.unarchiveObjectWithFile(fire1!) as! SKEmitterNode

let fire2 = NSBundle.mainBundle().pathForResource("fire2", ofType: "sks")
let fireParticle2 = NSKeyedUnarchiver.unarchiveObjectWithFile(fire2!) as! SKEmitterNode

func getParticleToUse(type: ParticleType) -> SKEmitterNode {
    
    var particle = SKEmitterNode()
    
    if type == .fire {
        if fireCount % 2 == 0 {
            particle = fireParticle2
            fireParticle2.removeAllActions()
            fireParticle2.removeFromParent()
            fireParticle2.resetSimulation()
            fireParticle2.targetNode = nil
        }else {
            particle = fireParticle1
            fireParticle1.removeAllActions()
            fireParticle1.removeFromParent()
            fireParticle1.resetSimulation()
            fireParticle1.targetNode = nil
        }
        fireCount += 1
    }
    if type == .spark {
        if sparkCount % 2 == 0 {
            particle = sparkParticle2
            sparkParticle2.removeAllActions()
            sparkParticle2.removeFromParent()
            sparkParticle2.resetSimulation()
            sparkParticle2.targetNode = nil
        }else {
            particle = sparkParticle1
            sparkParticle1.removeAllActions()
            sparkParticle1.removeFromParent()
            sparkParticle1.resetSimulation()
            sparkParticle1.targetNode = nil
        }
        sparkCount += 1
    }
    
    return particle
}

func createFireball(texture:SKTexture, point:CGPoint, target: SKNode) -> SKEmitterNode{
    
    let fireball = getParticleToUse(.fire)
    
    fireball.resetSimulation()
    fireball.particleTexture = texture
    fireball.position = point
    fireball.targetNode = target
    fireball.zPosition = 100
    
    return fireball
    
}

let spark1 = NSBundle.mainBundle().pathForResource("spark1", ofType: "sks")
let sparkParticle1 = NSKeyedUnarchiver.unarchiveObjectWithFile(spark1!) as! SKEmitterNode

let spark2 = NSBundle.mainBundle().pathForResource("spark2", ofType: "sks")
let sparkParticle2 = NSKeyedUnarchiver.unarchiveObjectWithFile(spark2!) as! SKEmitterNode

func createSpark(texture:SKTexture, point:CGPoint, target: SKNode) -> SKEmitterNode{
    
    let spark = getParticleToUse(.spark)
    
    spark.resetSimulation()
    spark.particleTexture = texture
    spark.position = point
    spark.targetNode = target
    spark.zPosition = 100
    
    return spark
    
}
