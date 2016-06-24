//
//  MazeSelectScene.swift
//  Into The Maze
//
//  Created by ramiro beltran on 6/23/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

class MazeSelectScene: SKScene {
    
    let homeButton = SKLabelNode(text: "Home")
    
    var mazes = [SKShapeNode]()
    var index = 0
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = .greenColor()
        createLabels()
        createMazeIcons()
        
    }
    
    func createMazeIcons() {
        
        for i in 0...2 {
            
            let maze = SKShapeNode(circleOfRadius: 50.0)
            maze.fillColor = .blueColor()
            maze.position = CGPoint(x: (self.size.width * 0.2) + CGFloat(110 * i), y: (self.size.height * 0.7) - CGFloat(110 * i))
            mazes.append(maze)
            self.addChild(maze)
        }
        
    }
    
    func createLabels() {
        
        let topLabel = SKLabelNode(text: "Maze Select")
        topLabel.fontSize = 42.0
        topLabel.fontColor = .redColor()
        topLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.85)
        self.addChild(topLabel)
        
        homeButton.fontSize = 18.0
        homeButton.fontColor = .redColor()
        homeButton.position = CGPoint(x: self.size.width * 0.2, y: self.size.height * 0.9)
        self.addChild(homeButton)
    }
    
    func moveToSelectedMaze(level: Int) {
        
        let GameScene = Level1GameScene()
        GameScene.size = self.size
        GameScene.scaleMode = self.scaleMode
        let transition = SKTransition.doorwayWithDuration(2.0)
        self.scene!.view?.presentScene(GameScene, transition: transition)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch! {
            let location = touch.locationInNode(self)
            
            if mazes[index].containsPoint(location) {
                moveToSelectedMaze(level)
            }
            
            if homeButton.containsPoint(location) {
                
                let homeScene = MainMenuScene()
                homeScene.size = self.size
                homeScene.scaleMode = self.scaleMode
                let transition = SKTransition.crossFadeWithDuration(1.0)
                self.scene!.view?.presentScene(homeScene, transition: transition)
            }
        }
    }
}


















