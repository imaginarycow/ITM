//
//  FireParticle.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/29/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import SpriteKit

enum ParticleType {
    case fire, spark, ice
}

var fireCount = 0
var sparkCount = 0

let fire1 = NSBundle.mainBundle().pathForResource("fire1", ofType: "sks")
let fireParticle1 = NSKeyedUnarchiver.unarchiveObjectWithFile(fire1!) as! SKEmitterNode
let fire2 = NSBundle.mainBundle().pathForResource("fire2", ofType: "sks")
let fireParticle2 = NSKeyedUnarchiver.unarchiveObjectWithFile(fire2!) as! SKEmitterNode
let fire3 = NSBundle.mainBundle().pathForResource("fire3", ofType: "sks")
let fireParticle3 = NSKeyedUnarchiver.unarchiveObjectWithFile(fire3!) as! SKEmitterNode
let fire4 = NSBundle.mainBundle().pathForResource("fire4", ofType: "sks")
let fireParticle4 = NSKeyedUnarchiver.unarchiveObjectWithFile(fire4!) as! SKEmitterNode
let fire5 = NSBundle.mainBundle().pathForResource("fire5", ofType: "sks")
let fireParticle5 = NSKeyedUnarchiver.unarchiveObjectWithFile(fire5!) as! SKEmitterNode
let fire6 = NSBundle.mainBundle().pathForResource("fire6", ofType: "sks")
let fireParticle6 = NSKeyedUnarchiver.unarchiveObjectWithFile(fire6!) as! SKEmitterNode
let fire7 = NSBundle.mainBundle().pathForResource("fire7", ofType: "sks")
let fireParticle7 = NSKeyedUnarchiver.unarchiveObjectWithFile(fire7!) as! SKEmitterNode
let fire8 = NSBundle.mainBundle().pathForResource("fire8", ofType: "sks")
let fireParticle8 = NSKeyedUnarchiver.unarchiveObjectWithFile(fire8!) as! SKEmitterNode

func getParticleToUse(type: ParticleType) -> SKEmitterNode {
    
    var particle = SKEmitterNode()
    
    if type == .fire {
        
        switch fireCount {
        case 0:
            particle = fireParticle1
        case 1:
            particle = fireParticle2
        case 2:
            particle = fireParticle3
        case 3:
            particle = fireParticle4
        case 4:
            particle = fireParticle5
        case 5:
            particle = fireParticle6
        case 6:
            particle = fireParticle7
        case 7:
            particle = fireParticle8
        default:
            particle = fireParticle1
        }
        if fireCount < 7 { fireCount += 1 } else { fireCount = 0 }
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

let ice = NSBundle.mainBundle().pathForResource("ice", ofType: "sks")
let iceParticle1 = NSKeyedUnarchiver.unarchiveObjectWithFile(ice!) as! SKEmitterNode

func createIce(point:CGPoint, target: SKNode) -> SKEmitterNode{
    
    let iceParticle = iceParticle1
    
    iceParticle.resetSimulation()
    iceParticle.position = point
    iceParticle.targetNode = target
    iceParticle.zPosition = 100
    
    return iceParticle
    
}

