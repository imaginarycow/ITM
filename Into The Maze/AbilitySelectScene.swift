//
//  AbilitySelectScene.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/6/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

class AbilitySelectScene: SKScene {
    
    let backButton = SKLabelNode(text: "Back")
    var iconArray = [SKShapeNode]()
  
    override func didMoveToView(view: SKView) {
        
    
        scene?.backgroundColor = backgroundColor
        
        createLabels()
        createAbilityIcons()
        
    }
    
    func createAbilityIcons() {
        
        for i in 0...2 {
            
            let icon = SKShapeNode(circleOfRadius: 30.0)
            icon.fillColor = SKColor.whiteColor()
            icon.strokeColor = .clearColor()
            
            let iconTitle = SKLabelNode()
            iconTitle.fontColor = mazeColor
            iconTitle.fontSize = 16.0
            
            if i == 0 {
                icon.position = CGPoint(x: self.size.width * 0.2 , y: self.size.height * 0.7)
                icon.name = "Brick Breaker"
                icon.fillTexture = SKTexture(imageNamed: "brickBreaker.png")
                iconTitle.text = "Brick Breaker"
                iconTitle.position = CGPoint(x: self.size.width * 0.5 , y: self.size.height * 0.7)
            }
            if i == 1 {
                icon.position = CGPoint(x: self.size.width * 0.2 , y: self.size.height * 0.5)
                icon.name = "InstaKill"
                icon.fillTexture = SKTexture(imageNamed: "instakill.png")
                iconTitle.text = "InstaKill"
                iconTitle.position = CGPoint(x: self.size.width * 0.5 , y: self.size.height * 0.5)
            }
            if i == 2 {
                icon.position = CGPoint(x: self.size.width * 0.2 , y: self.size.height * 0.3)
                icon.name = "Time Freeze"
                icon.fillTexture = SKTexture(imageNamed: "timeFreeze.png")
                iconTitle.text = "Time Freeze"
                iconTitle.position = CGPoint(x: self.size.width * 0.5 , y: self.size.height * 0.3)
            }

            iconArray.append(icon)
            self.addChild(icon)
            self.addChild(iconTitle)
        }
        
    }
    
    func createLabels() {
        
        let abilitySceneLabel = SKLabelNode(text: "Choose Your Ability")
        abilitySceneLabel.position = CGPoint(x: (scene?.size.width)!/2, y: (scene?.size.height)! * 0.90)
        abilitySceneLabel.fontName = labelFont
        abilitySceneLabel.fontColor = mazeColor
        abilitySceneLabel.fontSize = 31.0
        self.addChild(abilitySceneLabel)
        
        let playerNameLabel = SKLabelNode(text: "\(playerName.uppercaseString)")
        playerNameLabel.position = CGPoint(x: (scene?.size.width)!/2, y: (scene?.size.height)! * 0.80)
        playerNameLabel.fontName = labelFont
        playerNameLabel.fontColor = mazeColor
        playerNameLabel.fontSize = 31.0
        self.addChild(playerNameLabel)
        
        backButton.fontSize = 14.0
        backButton.fontColor = .redColor()
        backButton.fontName = labelFont
        backButton.position = CGPoint(x: self.size.width * 0.06, y: self.size.height * 0.92)
        self.addChild(backButton)
        
        let infoLabel = SKLabelNode()
        infoLabel.zPosition = 100
        infoLabel.fontColor = mazeColor
        infoLabel.fontName = labelFont
        infoLabel.fontSize = 12.0
        infoLabel.position = CGPoint(x: ((self.scene?.size.width)!/2), y: (self.scene?.size.height)! * 0.06)
        infoLabel.text = "Earn your ability in the game by whooping bad guys and grabbing tokens"
        self.addChild(infoLabel)
        
    }
    
    func moveToMazeSelectScene() {
        
        let mazeSelectScene = MazeSelectScene()
        mazeSelectScene.size = self.size
        mazeSelectScene.scaleMode = self.scaleMode
        let transition = SKTransition.fadeWithDuration(1.0)
        self.scene!.view?.presentScene(mazeSelectScene, transition: transition)
    }
    
    func moveToMainMenuScene() {
        
        let mainMenuScene = MainMenuScene()
        mainMenuScene.size = self.size
        mainMenuScene.scaleMode = self.scaleMode
        let transition = SKTransition.fadeWithDuration(1.0)
        self.scene!.view?.presentScene(mainMenuScene, transition: transition)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch! {
            
            let location = touch.locationInNode(self)
            
            for icon in iconArray {
                if icon.containsPoint(location) {
                    if icon == iconArray[0] {
                        abilitySelected = .brickBreaker
                    }else if icon == iconArray[1] {
                        abilitySelected = .instaKill
                    }else {
                        abilitySelected = .timeFreeze
                    }
                    moveToMazeSelectScene()
                }
                
            }
            print("Player selected \(abilitySelected)")
            
            if backButton.containsPoint(location) {
                print("Back button tapped")
                moveToMainMenuScene()
            }
        }
    }
    
} //End: Ability Select Scene
