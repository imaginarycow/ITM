//
//  GameScene.swift
//  Into The Maze
//
//  Created by ramiro beltran on 2/1/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene {

    override func didMoveToView(view: SKView) {


    }
    
    override func willMoveFromView(view: SKView) {
        scene!.removeFromParent()
        scene!.removeAllActions()
    }

    func createNewScene() {
        
        createScoreLabel()
        createControls()
        backgroundColor = SKColor.blackColor()
        //mazeShiftLabel()

    }
    
    func createScoreLabel() {
        
        let scoreLabel = SKLabelNode(fontNamed: "RUBBBI__")
        scoreLabel.name = "scoreLabel"
        scoreLabel.fontColor = mazeColor
        scoreLabel.text = String(format: "Score: %04u", 0)
        scoreLabel.position = CGPoint(x: frame.size.width/2, y: frame.size.height * 0.9)
        scene!.addChild(scoreLabel)
    }
    
    func mazeShiftLabel() {
        
        let timerLabel = SKLabelNode(fontNamed: "Courier")
        timerLabel.name = "timerLabel"
        timerLabel.fontColor = SKColor.redColor()
        timerLabel.text = "Next Maze Shift in: "
        timerLabel.position = CGPoint(x: frame.size.width/2, y: frame.size.height * 0.85)
        scene!.addChild(timerLabel)
    }
        
    func createControls() {
        
        let moveControl: SKShapeNode = SKShapeNode(circleOfRadius: 100.0)
        moveControl.position = CGPoint(x: scene!.size.width * 0.3, y: scene!.size.height * 0.2)
        moveControl.fillColor = SKColor.blueColor()
        moveControl.fillTexture = SKTexture(imageNamed: "moveButton")
        moveControl.zPosition = 100
        moveControl.name = "moveControl"
        scene!.addChild(moveControl)
        
        let shootControl: SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "shootButton.png"))
        shootControl.size = CGSize(width: 200.0, height: 200.0)
        shootControl.position = CGPoint(x: scene!.size.width * 0.7, y: scene!.size.height * 0.2)
        shootControl.zPosition = 100
        shootControl.name = "shootControl"
        scene!.addChild(shootControl)

    }
    
}
            

    

