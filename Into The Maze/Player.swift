//
//  Player.swift
//  Into The Maze
//
//  Created by ramiro beltran on 2/2/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

func createPlayer() -> SKSpriteNode {
    
    let Player = SKSpriteNode(imageNamed: "PlayerWalk01")
    Player.size = CGSize(width: 70, height: 70)
    //Player.position = CGPoint(x: 500, y: 500)
    return Player
}

func createTextureArray() -> [SKTexture]{
    
    
    var TextureArray = [SKTexture]()
    var TextureAtlas = SKTextureAtlas(named: "walkCycle")
    for i in 1...(TextureAtlas.textureNames.count - 2) {
    
        var Name = "PlayerWalk0\(i)"
        TextureArray.append(SKTexture(imageNamed: Name))
    }
    return TextureArray
}

