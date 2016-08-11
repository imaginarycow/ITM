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
    let mazeImages:[UIImage] = [UIImage(named: "maze1.png")!,UIImage(named: "timeFreeze.png")!,UIImage(named: "mazeLaunchScreen.png")!,UIImage(named: "mazeLaunchScreen.png")!,UIImage(named: "mazeLaunchScreen.png")!,UIImage(named: "mazeLaunchScreen.png")!,UIImage(named: "timeFreeze.png")!,UIImage(named: "mazeLaunchScreen.png")!,UIImage(named: "mazeLaunchScreen.png")!,UIImage(named: "timeFreeze.png")!,UIImage(named: "random.png")!]
    let mazeIcon = SKSpriteNode()
    var numberOfMazes = 1

    var index = 2
    
    
    override func didMoveToView(view: SKView) {
        
        if musicIsPlaying == false {
            musicIsPlaying = true
            print("bg music was nil, starting background music")
            vc.playBGMusic()
        }
        
        numberOfMazes = mazeImages.count
        
        self.backgroundColor = backgroundColor
        createLabels()
        createMazePicker()
        setEnemyTexture()
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
        
        vc.stopBGMusic()
        musicIsPlaying = false
        
        var gameScene = Maze1GameScene()
        
        switch level {
        case 1:
            gameScene = Maze1GameScene()
        case 2:
            gameScene = Maze1GameScene()
        case 3:
            gameScene = Maze1GameScene()
        case 4:
            gameScene = Maze1GameScene()
        case 5:
            gameScene = Maze1GameScene()
        case 6:
            gameScene = Maze1GameScene()
        case 7:
            gameScene = Maze1GameScene()
        case 8:
            gameScene = Maze1GameScene()
        case 9:
            gameScene = Maze1GameScene()
        case 10:
            gameScene = Maze1GameScene()
        case 11:
            gameScene = Maze1GameScene()
        default:
            gameScene = Maze1GameScene()
        }
        
        gameScene.size = self.size
        gameScene.scaleMode = self.scaleMode
        
        let transition = SKTransition.doorwayWithDuration(2.0)
        self.scene!.view?.presentScene(gameScene, transition: transition)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch! {
            let location = touch.locationInNode(self)
            
            if leftArrow.containsPoint(location) {
                vc.playSoundEffect(.buttonClick)
                leftArrow.alpha = 0.3
                if mazeNumb == 1 {
                    mazeNumb = numberOfMazes
                }else {
                    mazeNumb -= 1
                }
                
            }
            if rightArrow.containsPoint(location) {
                vc.playSoundEffect(.buttonClick)
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
                vc.playSoundEffect(.buttonPress)
                
                if mazeNumb == numberOfMazes {
                    print("random maze selected")
                }
                level = mazeNumb
                moveToSelectedMaze(mazeNumb)
            }
            
            
            if backButton.containsPoint(location) {
                vc.playSoundEffect(.buttonPress)
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


















