//
//  Player.swift
//  Into The Maze
//
//  Created by ramiro beltran on 2/2/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

class NewPlayer {
    
    class func createNewPlayer(parent: SKScene) -> SKSpriteNode {
        
        let newPlayer = SKSpriteNode(imageNamed: "PlayerWalk01")
        newPlayer.size = CGSize(width: 50, height: 50)
        newPlayer.zPosition = 100
        
        newPlayer.physicsBody = SKPhysicsBody(rectangleOfSize: newPlayer.frame.size)
        
        return newPlayer
    }
    
}




