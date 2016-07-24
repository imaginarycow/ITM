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
    
    
    var mazeNumb:Int = 1
    var mazeNumLabel = SKLabelNode()
    let backButton = SKLabelNode(text: "Back")
    let leftArrow = SKSpriteNode(imageNamed: "arrow.png")
    let rightArrow = SKSpriteNode(imageNamed: "arrow.png")
    let goLabel = SKLabelNode(text: "Go")
    
    var selectedMaze:UIImage!
    let mazeImages:[UIImage] = [UIImage(named: "mazeLaunchScreen.png")!,UIImage(named: "timeFreeze.png")!,UIImage(named: "mazeLaunchScreen.png")!,UIImage(named: "mazeLaunchScreen.png")!,UIImage(named: "mazeLaunchScreen.png")!,UIImage(named: "mazeLaunchScreen.png")!,UIImage(named: "timeFreeze.png")!,UIImage(named: "mazeLaunchScreen.png")!,UIImage(named: "mazeLaunchScreen.png")!,UIImage(named: "timeFreeze.png")!,UIImage(named: "random.png")!]
    let mazeIcon = SKSpriteNode()
    var numberOfMazes = 1

    var index = 2
    
    override func didMoveToView(view: SKView) {
        
        numberOfMazes = mazeImages.count
        
        self.backgroundColor = backgroundColor
        createLabels()
        createMazePicker()
        
    }
    
    func createMazePicker() {
        
        mazeNumLabel.text = String(mazeNumb)
        mazeNumLabel.position = CGPoint(x: (self.scene?.size.width)!/2, y: (self.scene?.size.height)!/2)
        mazeNumLabel.zPosition = 101
        
        leftArrow.position = CGPoint(x: (self.scene?.size.width)! * 0.25, y: (self.scene?.size.height)!/2)
        leftArrow.zPosition = 100
        leftArrow.size = CGSize(width: 50.0 * scale, height: 65.0 * scale)
        rightArrow.zPosition = 100
        rightArrow.size = CGSize(width: 50.0 * scale, height: 65.0 * scale)
        rightArrow.zRotation = CGFloat(M_PI)
        rightArrow.position = CGPoint(x: (self.scene?.size.width)! * 0.75, y: (self.scene?.size.height)!/2)
        
        selectedMaze = mazeImages[mazeNumb - 1]
        mazeIcon.position = CGPoint(x: (self.scene?.size.width)!/2, y: (self.scene?.size.height)!/2)
        mazeIcon.zPosition = 100
        mazeIcon.texture = SKTexture(image: selectedMaze)
        mazeIcon.size = CGSize(width: 150.0 * scale, height: 150.0 * scale)

        
        self.addChild(leftArrow)
        self.addChild(rightArrow)
        self.addChild(mazeIcon)
        self.addChild(mazeNumLabel)
    }
    
    func createLabels() {
        
        let topLabel = SKLabelNode(text: "Maze Select")
        topLabel.fontName = labelFont
        topLabel.fontSize = 34.0 * scale
        topLabel.fontColor = .redColor()
        topLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.85)
        self.addChild(topLabel)
        
        goLabel.fontName = labelFont
        goLabel.fontColor = .whiteColor()
        goLabel.zPosition = 100
        goLabel.position = CGPoint(x: (self.scene?.size.width)!/2, y: (self.scene?.size.height)! * 0.1)
        self.addChild(goLabel)
        
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
            
            if leftArrow.containsPoint(location) {
                leftArrow.alpha = 0.3
                if mazeNumb == 1 {
                    mazeNumb = numberOfMazes
                }else {
                    mazeNumb -= 1
                }
                
            }
            if rightArrow.containsPoint(location) {
                rightArrow.alpha = 0.3
                if mazeNumb == numberOfMazes {
                    mazeNumb = 1
                }else {
                    mazeNumb += 1
                }
                
            }
            selectedMaze = mazeImages[mazeNumb - 1]
            mazeIcon.texture = SKTexture(image: selectedMaze)
            mazeNumLabel.text = String(mazeNumb)
            
            if goLabel.containsPoint(location) {
                
                if mazeNumb == numberOfMazes {
                    print("random maze selected")
                }
                level = mazeNumb
                moveToSelectedMaze(mazeNumb)
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
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        leftArrow.alpha = 1.0
        rightArrow.alpha = 1.0
    }
}


















