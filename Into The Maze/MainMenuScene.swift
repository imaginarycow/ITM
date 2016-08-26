//
//  MainMenuScene.swift
//  Into The Maze
//
//  Created by ramiro beltran on 6/23/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import AVFoundation
import GoogleMobileAds

var backGroundColor = SKColor.darkGrayColor()
var scaledWidth:CGFloat!
var scaledHeight:CGFloat!
var showAnimation = true

let vc = GameViewController()
var musicIsPlaying = false

class MainMenuScene: SKScene, UITextFieldDelegate, GADInterstitialDelegate {
    
    let mazeSelectLabel = SKLabelNode(text: "Into The Maze")
    
    //next three nodes built in function fadeInLabels()
    let removeAdsLabel = SKSpriteNode(imageNamed: "removeAds.png")
    let restorePurchasesLabel = SKSpriteNode(imageNamed: "restorePurchasesIcon.png")
    let goLabel = SKLabelNode(text: "Go")
    let userNameField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 30.0))
    let helpLabel = SKSpriteNode(imageNamed: "helpIcon.png")
    
    let parent1 = SKSpriteNode()
    let parent2 = SKSpriteNode()
    let parent3 = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        
        checkForNewInstall()
        checkIfIapsEnabled()
        
        
        for family: String in UIFont.familyNames()
        {
            print("\(family)")
            for names: String in UIFont.fontNamesForFamilyName(family)
            {
                print("== \(names)")
            }
        }

        if musicIsPlaying == false {
            vc.playBGMusic()
            musicIsPlaying = true
            print("bg music was nil, starting background music")
        }
        
        setScale()
        
        scene?.backgroundColor = backgroundColor

        //text field properties for user name input
        userNameField.center = CGPoint(x: (scene?.size.width)!/2, y: (scene?.size.height)! * 0.8)
        userNameField.borderStyle = UITextBorderStyle.RoundedRect
        userNameField.backgroundColor = mazeColor
        userNameField.font = UIFont(name: labelFont, size: 12.0)
        
        if gameData.valueForKey("playerName") != nil {
            userNameField.placeholder = String(gameData.valueForKey("playerName")!)
            playerName = String(gameData.valueForKey("playerName")!)
        }else {
            userNameField.placeholder = "They call me..."
        }
        
        userNameField.textAlignment = .Center
        userNameField.textColor = .redColor()
        userNameField.delegate = self
        
        parent1.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        addChild(parent1)
        
        parent2.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        addChild(parent2)
        
        parent3.position = CGPoint(x: scene!.size.width/2, y: scene!.size.height/2)
        addChild(parent3)
        
        
        let triangle1 = Triangle.createTriangle(self, scale: 0.9, buffer: 0.0, color: .redColor())
        let triangle2 = Triangle.createTriangle(self, scale: 0.6, buffer: -10.0, color: .redColor())
        let triangle3 = Triangle.createTriangle(self, scale: 0.3, buffer: -20.0, color: .redColor())
        parent1.addChild(triangle1)
        parent2.addChild(triangle2)
        parent3.addChild(triangle3)
        
        //don't animate main menu when player is already in game
        if showAnimation {
            Triangle.beginningAnimation(parent1, tri2: parent2, tri3: parent3)
            fadeInLabels(3.0)
        }else {
            fadeInLabels(0.5)
        }
        
        if adsRemoved == false {
            vc.loadRequest()
        }
        
    } // End DidMoveToView
    
    
    override func willMoveFromView(view: SKView) {
        self.removeAllChildren()
    }
    
    
    
    //set scale of game based on screen size of player's device
    func setScale() {
        screenHeight = scene!.size.height
        screenWidth = scene!.size.width
        print(screenHeight)
        print(screenWidth)
        
        switch screenHeight {
        case 320:
            scale = 1.0
        case 375:
            scale = 1.25
        case 414:
            scale = 1.35
        case 768:
            scale = 1.75
        case 1024:
            scale = 2.0
        default:
            scale = 1.0
        }
        
        scaledWidth = 40.0 * scale
        scaledHeight = 40.0 * scale
        
    }
    
    func moveToAbilitySelectScene() {
        
        showAnimation = false
        userNameField.removeFromSuperview()

        
        let abilitySelectScene = AbilitySelectScene()
        abilitySelectScene.size = self.size
        abilitySelectScene.scaleMode = self.scaleMode
        let transition = SKTransition.fadeWithDuration(1.0)
        self.scene!.view?.presentScene(abilitySelectScene, transition: transition)

    }
    
    func moveToHelpScene() {
        
        showAnimation = false
        userNameField.removeFromSuperview()

        let helpScene = HelpScene()
        helpScene.size = self.size
        helpScene.scaleMode = self.scaleMode
        let transition = SKTransition.fadeWithDuration(1.0)
        self.scene!.view?.presentScene(helpScene, transition: transition)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first as UITouch! {
            let location = touch.locationInNode(self)
            
            if goLabel.containsPoint(location) {
                print("Go label touched")
                vc.playSoundEffect(.buttonPress)
                moveToAbilitySelectScene()
            }
            
            if removeAdsLabel.containsPoint(location) {
                print("Attempting to remove Ads")
                vc.playSoundEffect(.buttonPress)
                buyProduct("net.beliro.Maze.removeAds")
            }
            
            if restorePurchasesLabel.containsPoint(location) {
                vc.playSoundEffect(.buttonPress)
                //buyProduct("net.beliro.Maze.removeAds")
                restorePurchases()
            }
            
            if helpLabel.containsPoint(location) {
                vc.playSoundEffect(.buttonPress)
                moveToHelpScene()
            }
        }
    }

    
    func fadeInLabels(del: Double) {
        // top label
        mazeSelectLabel.fontColor = mazeColor
        mazeSelectLabel.fontSize = 31.0
        mazeSelectLabel.fontName = labelFont
        mazeSelectLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.85)
        
        //properties for removeAdsLabel
        removeAdsLabel.position = CGPoint(x: (scene?.size.width)! * 0.06, y: (scene?.size.height)! * 0.7)
        removeAdsLabel.size = CGSize(width: scaledWidth, height: scaledHeight)
        
        //properties for restorePurchasesLabel
        restorePurchasesLabel.position = CGPoint(x: (scene?.size.width)! * 0.06, y: (scene?.size.height)! * 0.5)
        restorePurchasesLabel.size = CGSize(width: scaledWidth, height: scaledHeight)
        
        if self.scene?.size.height >= 750 {
            goLabel.position = CGPoint(x: scene!.size.width/2, y: (scene?.size.height)! * 0.44)
        }else {
            goLabel.position = CGPoint(x: scene!.size.width/2, y: (scene?.size.height)! * 0.41)
        }
        
        goLabel.fontColor = .whiteColor()
        goLabel.fontName = labelFont
        goLabel.zPosition = 100
        
        helpLabel.position = CGPoint(x: (scene?.size.width)! * 0.06, y: (scene?.size.height)! * 0.3)
        helpLabel.size = CGSize(width: scaledWidth, height: scaledHeight)
        helpLabel.zPosition = 100

        //wait til maze animation stops
        delay(del) {
            
            self.addChild(self.mazeSelectLabel)
            self.addChild(self.removeAdsLabel)
            self.addChild(self.restorePurchasesLabel)
            self.view!.addSubview(self.userNameField)
            self.addChild(self.goLabel)
            self.addChild(self.helpLabel)
            
        }
        
    }
    
    func animateTextField(textField: UITextField, up: Bool) {
        var movementDistance:CGFloat = 0
        let movementDuration: Double = 0.3
        
        if scale > 1.45 {
            movementDistance = -260
        }else if scale > 1.35{
            movementDistance = -180
        }else {
            movementDistance = -140
        }
        
        var movement:CGFloat = 0
        if up {
            movement = movementDistance
        }
        else {
            movement = -movementDistance
        }
        SKView.beginAnimations("animateTextField", context: nil)
        SKView.setAnimationBeginsFromCurrentState(true)
        SKView.setAnimationDuration(movementDuration)
        self.view!.frame = CGRectOffset(self.view!.frame, 0, movement)
        SKView.commitAnimations()
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("player typing")
        self.animateTextField(textField, up:true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if userNameField.text != "" {
            playerName = userNameField.text!
            gameData.setValue(playerName, forKey: "playerName")
        }
        
        
        self.animateTextField(textField, up:false)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("player done typing")
        textField.resignFirstResponder()
        return true
    }

    
    
} //End: MainMenuScene











