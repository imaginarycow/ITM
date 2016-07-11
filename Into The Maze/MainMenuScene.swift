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


class MainMenuScene: SKScene, UITextFieldDelegate {
    
    let mazeSelectLabel = SKLabelNode(text: "Into The Maze")
    
    //next three nodes built in function fadeInLabels()
    let removeAdsLabel = SKSpriteNode(imageNamed: "removeAds.png")
    let restorePurchasesLabel = SKSpriteNode(imageNamed: "restorePurchasesIcon.png")
    let goLabel = SKLabelNode(text: "Go")
    let userNameField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 30.0))
    
    
    let parent1 = SKSpriteNode()
    let parent2 = SKSpriteNode()
    let parent3 = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        
        scene?.backgroundColor = .yellowColor()

        //text field properties for user name input
        userNameField.center = CGPoint(x: (scene?.size.width)!/2, y: (scene?.size.height)! * 0.8)
        userNameField.borderStyle = UITextBorderStyle.RoundedRect
        userNameField.backgroundColor = mazeColor
        userNameField.font = UIFont(name: labelFont, size: 12.0)
        
        if gameData.valueForKey("playerName") != nil {
            userNameField.placeholder = String(gameData.valueForKey("playerName")!)
            playerName = String(gameData.valueForKey("playerName")!)
        }else {
            userNameField.placeholder = "They call me"
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
        
        
        let triangle1 = Triangle.createTriangle(self, scale: 1.0, buffer: 0.0, color: .redColor())
        let triangle2 = Triangle.createTriangle(self, scale: 0.7, buffer: -10.0, color: .redColor())
        let triangle3 = Triangle.createTriangle(self, scale: 0.4, buffer: -20.0, color: .redColor())
        parent1.addChild(triangle1)
        parent2.addChild(triangle2)
        parent3.addChild(triangle3)
        
        
        Triangle.beginningAnimation(parent1, tri2: parent2, tri3: parent3)
        fadeInLabels()

        
    }
    
    override func willMoveFromView(view: SKView) {
        
    }
    
    func moveToAbilitySelectScene() {
        
        let abilitySelectScene = AbilitySelectScene()
        abilitySelectScene.size = self.size
        abilitySelectScene.scaleMode = self.scaleMode
        let transition = SKTransition.fadeWithDuration(1.0)
        self.scene!.view?.presentScene(abilitySelectScene, transition: transition)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first as UITouch! {
            let location = touch.locationInNode(self)
            
            if goLabel.containsPoint(location) {
                print("Go label touched")
                userNameField.removeFromSuperview()
                moveToAbilitySelectScene()
            }
        }
    }
    
    func fadeInLabels() {
        // top label
        mazeSelectLabel.fontColor = mazeColor
        mazeSelectLabel.fontSize = 31.0
        mazeSelectLabel.fontName = labelFont
        mazeSelectLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.85)
        
        //properties for removeAdsLabel
        removeAdsLabel.position = CGPoint(x: (scene?.size.width)! * 0.06, y: (scene?.size.height)! * 0.7)
        removeAdsLabel.size = CGSize(width: 40.0, height: 40.0)
        
        //properties for restorePurchasesLabel
        restorePurchasesLabel.position = CGPoint(x: (scene?.size.width)! * 0.06, y: (scene?.size.height)! * 0.6)
        restorePurchasesLabel.size = CGSize(width: 40.0, height: 40.0)
        
        goLabel.position = CGPoint(x: scene!.size.width/2, y: (scene?.size.height)! * 0.41)
        goLabel.fontColor = .redColor()
        goLabel.fontName = labelFont
        goLabel.zPosition = 100

        //wait til maze animation stops
        delay(3.0) {
            
            self.addChild(self.mazeSelectLabel)
            self.addChild(self.removeAdsLabel)
            self.addChild(self.restorePurchasesLabel)
            self.view!.addSubview(self.userNameField)
            self.addChild(self.goLabel)
            
        }
        
    }
    
    func animateTextField(textField: UITextField, up: Bool) {
        let movementDistance:CGFloat = -140
        let movementDuration: Double = 0.3
        
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











