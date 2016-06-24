//
//  MainMenuScene.swift
//  Into The Maze
//
//  Created by ramiro beltran on 6/23/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    let mazeSelectLabel = SKLabelNode(text: "Main Menu")
    
    override func didMoveToView(view: SKView) {
        
        scene?.backgroundColor = .yellowColor()
        
        createLabels()
        
        let tri = Triangle.createNewTriangle
        
    }
    
    func createLabels() {
        
        mazeSelectLabel.fontColor = .blueColor()
        mazeSelectLabel.fontSize = 42.0
        mazeSelectLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.85)
        self.addChild(mazeSelectLabel)
    }
    
    func moveToMazeSelectScene() {
        
        let mazeSelectScene = MazeSelectScene()
        mazeSelectScene.size = self.size
        mazeSelectScene.scaleMode = self.scaleMode
        let transition = SKTransition.moveInWithDirection(.Right, duration: 1)
        self.scene!.view?.presentScene(mazeSelectScene, transition: transition)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first as UITouch! {
            let location = touch.locationInNode(self)
            
            if mazeSelectLabel.containsPoint(location) {
                moveToMazeSelectScene()
            }
        }
    }
    
}
