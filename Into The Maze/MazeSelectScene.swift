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
    
    let backButton = SKLabelNode(text: "Back")
    
    var mazes = [SKShapeNode]()
    var index = 2
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = backgroundColor
        createLabels()
        createMazeIcons()
        
    }
    //create icons that will be filled with maze images that player will choose from
    func createMazeIcons() {
        
        var j = 0
        var k = 0
        
        for i in 0...11 {
            
            let maze = SKShapeNode(circleOfRadius: 30.0 * scale)
            maze.fillColor = mazeColor
            maze.zPosition = 10
            
            let mazeNum = SKLabelNode()
            mazeNum.fontColor = .whiteColor()
            mazeNum.fontSize = 20.0
            mazeNum.zPosition = 100
            mazeNum.text = String(i + 1)
            
            if i < 4 {
                maze.position = CGPoint(x: (self.size.width * 0.25) + CGFloat(110 * i), y: (self.size.height * 0.7))
                mazeNum.position = CGPoint(x: (self.size.width * 0.25) + CGFloat(110 * i), y: (self.size.height * 0.7))
                
            }else if i < 8 {
                
                maze.position = CGPoint(x: (self.size.width * 0.25) + CGFloat(110 * j), y: (self.size.height * 0.48))
                mazeNum.position = CGPoint(x: (self.size.width * 0.25) + CGFloat(110 * j), y: (self.size.height * 0.48))
                j += 1
            }else {
                
                maze.position = CGPoint(x: (self.size.width * 0.25) + CGFloat(110 * k), y: (self.size.height * 0.26))
                mazeNum.position = CGPoint(x: (self.size.width * 0.25) + CGFloat(110 * k), y: (self.size.height * 0.26))
                k += 1
            }
            mazes.append(maze)
            self.addChild(maze)
            self.addChild(mazeNum)
        }
        
    }
    
    func createLabels() {
        
        let topLabel = SKLabelNode(text: "Maze Select")
        topLabel.fontName = labelFont
        topLabel.fontSize = 34.0
        topLabel.fontColor = .redColor()
        topLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.85)
        self.addChild(topLabel)
        
        backButton.fontSize = 14.0
        backButton.fontName = labelFont
        backButton.fontColor = .redColor()
        backButton.position = CGPoint(x: self.size.width * 0.07, y: self.size.height * 0.92)
        self.addChild(backButton)
    }
    
    func moveToSelectedMaze(level: Int) {
        
        var GameScene = Level1GameScene()
        
        switch level {
        case 1:
            GameScene = Level1GameScene()
        case 2:
            GameScene = Level1GameScene()
        case 3:
            GameScene = Level1GameScene()
        case 4:
            GameScene = Level1GameScene()
        case 5:
            GameScene = Level1GameScene()
        case 6:
            GameScene = Level1GameScene()
        case 7:
            GameScene = Level1GameScene()
        case 8:
            GameScene = Level1GameScene()
        case 9:
            GameScene = Level1GameScene()
        case 10:
            GameScene = Level1GameScene()
        case 11:
            GameScene = Level1GameScene()
        case 12:
            GameScene = Level1GameScene()
        default:
            GameScene = Level1GameScene()
        }
        
        
        GameScene.size = self.size
        GameScene.scaleMode = self.scaleMode
        let transition = SKTransition.doorwayWithDuration(2.0)
        self.scene!.view?.presentScene(GameScene, transition: transition)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch! {
            let location = touch.locationInNode(self)
            
            var i = 1
            
            for maze in mazes {
                
                let mazeNum:Int = i
                level = mazeNum
                i += 1
                
                if maze.containsPoint(location) {

                    moveToSelectedMaze(mazeNum)
                }

            }
            
            
            
            if backButton.containsPoint(location) {
                
                let abilityScene = AbilitySelectScene()
                abilityScene.size = self.size
                abilityScene.scaleMode = self.scaleMode
                let transition = SKTransition.fadeWithDuration(1.0)
                self.scene!.view?.presentScene(abilityScene, transition: transition)
            }
        }
    }
}


















