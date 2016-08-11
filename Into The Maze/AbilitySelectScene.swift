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
    
    //rate me variables
    var iMinSessions = 4
    var iTryAgainSessions = 8
    let app_ID = "1052643535" //TODO: Change app_id to proper id
    
    let backButton = SKLabelNode(text: "Back")
    var iconArray = [SKShapeNode]()
    var tokenCount = SKLabelNode(text: "You currently have \(abilityTokens) ability token(s)")
  
    override func didMoveToView(view: SKView) {
    
        scene?.backgroundColor = backgroundColor
        gameHasRun = true
        gameData.setBool(gameHasRun, forKey: "gameHasRun")
        createLabels()
        createAbilityIcons()
        
        rateMe()
        
    }
    
    //launch Alert for rate me
    func showRateMe() {
        let alert = UIAlertController(title: "Rate Into The Maze", message: "and get 1 ability token!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Give me that token 😄", style: UIAlertActionStyle.Default, handler: { alertAction in
            //UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/app/id\(self.app_ID)")!)
            vc.playSoundEffect(.redeemSound)
            abilityTokens += 1
            gameData.setInteger(abilityTokens, forKey: "abilityTokens")
            gameData.synchronize()
            self.tokenCount.text = "You currently have \(abilityTokens) ability tokens"
            UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/app/viewContentsUserReviews?id=\(self.app_ID)")!)
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Maybe Later 👌🏼", style: UIAlertActionStyle.Default, handler: { alertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No Thanks 😡", style: UIAlertActionStyle.Default, handler: { alertAction in
            gameData.setBool(true, forKey: "neverRate")
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    //Check to see if we should present rate me View to user
    func rateMe() {
        var neverRate = gameData.boolForKey("neverRate")
        print(neverRate)
        var numLaunches = gameData.integerForKey("numLaunches") + 1
        print(numLaunches)
        
        if (!neverRate && (numLaunches == iMinSessions || numLaunches >= (iMinSessions + iTryAgainSessions + 1)))
        {
            showRateMe()
            numLaunches = iMinSessions + 1
        }
        gameData.setInteger(numLaunches, forKey: "numLaunches")
        gameData.synchronize()
    }
    
    func createAbilityIcons() {
        
        for i in 0...2 {
            
            let icon = SKShapeNode(circleOfRadius: 30.0)
            icon.fillColor = SKColor.whiteColor()
            icon.strokeColor = .clearColor()
            
            let iconTitle = SKLabelNode()
            iconTitle.fontColor = mazeColor
            iconTitle.fontName = "TimesNewRomanPS-BoldMT"
            iconTitle.fontSize = 16.0
            
            if i == 0 {
                icon.position = CGPoint(x: self.size.width * 0.2 , y: self.size.height * 0.7)
                icon.name = "Brick Breaker"
                icon.fillTexture = SKTexture(imageNamed: "brickBreaker.png")
                iconTitle.text = "Brick Breaker - face a wall, and blast it!"
                iconTitle.position = CGPoint(x: self.size.width * 0.6 , y: self.size.height * 0.7)
            }
            if i == 1 {
                icon.position = CGPoint(x: self.size.width * 0.2 , y: self.size.height * 0.5)
                icon.name = "InstaKill"
                icon.fillTexture = SKTexture(imageNamed: "instakill.png")
                iconTitle.text = "InstaKill - instantly kill all enemies!"
                iconTitle.position = CGPoint(x: self.size.width * 0.6 , y: self.size.height * 0.5)
            }
            if i == 2 {
                icon.position = CGPoint(x: self.size.width * 0.2 , y: self.size.height * 0.3)
                icon.name = "Time Freeze"
                icon.fillTexture = SKTexture(imageNamed: "timeFreeze.png")
                iconTitle.text = "Time Freeze - stop the maze shift for 10 seconds!"
                iconTitle.position = CGPoint(x: self.size.width * 0.6 , y: self.size.height * 0.3)
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
        
        
        tokenCount.fontName = labelFont
        tokenCount.zPosition = 100
        tokenCount.fontColor = mazeColor
        tokenCount.fontSize = 12.0 * scale
        tokenCount.position = CGPoint(x: ((self.scene?.size.width)!/2), y: (self.scene?.size.height)! * 0.1)
        self.addChild(tokenCount)
        
        let infoLabel = SKLabelNode()
        infoLabel.zPosition = 100
        infoLabel.fontColor = mazeColor
        infoLabel.fontName = labelFont
        infoLabel.fontSize = 12.0 * scale
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
                    vc.playSoundEffect(.buttonPress)
                    moveToMazeSelectScene()
                }
                
            }
            print("Player selected \(abilitySelected)")
            
            if backButton.containsPoint(location) {
                print("Back button tapped")
                vc.playSoundEffect(.buttonPress)
                moveToMainMenuScene()
            }
        }
    }
    
} //End: Ability Select Scene
