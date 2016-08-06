//
//  AbilityHelper.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/29/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

var abilitySelected:ability = .brickBreaker
var abilityEnabled = false
var abilityTokens = 20
let abilityToken = SKSpriteNode(imageNamed: "abilityToken.png")

enum ability {
    case brickBreaker, instaKill, timeFreeze
}

func useAbility(special: ability) {
    
    switch special {
    case .brickBreaker:
        useBrickBreaker()
        
    case .instaKill:
        useInstaKill()
        
    case .timeFreeze:
        useTimeFreeze()
        
    default:
        useBrickBreaker()
    }

    
    abilityTokens -= 1
    setAbilityForUse(abilityTokens)
}

func useBrickBreaker() {
    print("Player using Brick Breaker ability")
    //shoot super bullet function found in GameSceneHelperMethods.swift
    
    let texture = SKTexture(imageNamed: "brickBreaker.png")
    let fireball = createFireball(texture, point: CGPointZero, target: abilityControl)
    abilityControl.addChild(fireball)
    vc.playSoundEffect(.abilitySound)
    
    delay(0.5) {
        fireball.removeFromParent()
        fireball.targetNode = nil
        fireball.resetSimulation()
    }
}

func useInstaKill() {
    print("Player using instaKill ability")
    
    removeAllEnemies()
    
    let texture = SKTexture(imageNamed: "instakill.png")
    let fireball = createFireball(texture, point: CGPointZero, target: abilityControl)
    abilityControl.addChild(fireball)
    vc.playSoundEffect(.abilitySound)
    
    delay(0.5) {
        fireball.removeFromParent()
        fireball.targetNode = nil
        fireball.resetSimulation()
    }
}

func useTimeFreeze() {
    print("Player using TimeFreeze ability")
    timerIsFrozen = true
    
    let texture = SKTexture(imageNamed: "timeFreeze.png")
    let fireball = createFireball(texture, point: CGPointZero, target: abilityControl)
    abilityControl.addChild(fireball)
    vc.playSoundEffect(.abilitySound)
    
    delay(0.5) {
        fireball.removeFromParent()
        fireball.targetNode = nil
        fireball.resetSimulation()
    }
}

func setAbilityForUse(tokens: Int) {
    print("AbilityTokens: \(abilityTokens)")

    if tokens > 0 {
        
        let action1 = SKAction.fadeAlphaTo(0.3, duration: 0.5)
        let action2 = SKAction.fadeAlphaTo(1.5, duration: 0.5)
        let actions = SKAction.sequence([action1, action2])
        abilityControl.runAction(SKAction.repeatActionForever(actions))
    }else {
        abilityControl.removeAllActions()
        abilityControl.alpha = 0.3
    }
    
}

func removeToken(node: SKNode) {

    node.removeAllActions()
    node.removeFromParent()
}