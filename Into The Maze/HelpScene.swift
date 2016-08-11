//
//  HelpScene.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/20/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

class HelpScene: SKScene{
    
    let backButton = SKLabelNode(text: "Back")
    
    override func didMoveToView(view: SKView) {
        
        buildScene()
        setText()
    }
    
    override func willMoveFromView(view: SKView) {
        self.removeAllChildren()
    }
    
    func buildScene() {
        
        self.backgroundColor = SKColor.darkGrayColor()
        
        let title = SKLabelNode(text: "How TO Play")
        title.fontName = labelFont
        title.fontSize = 31.0 * scale
        title.color = mazeColor
        title.position = CGPoint(x: (self.scene?.size.width)!/2, y: (scene?.size.height)! * 0.9)
        addChild(title)
        
        backButton.fontName = labelFont
        backButton.fontSize = 12.0 * scale
        backButton.color = .redColor()
        backButton.position = CGPoint(x: (scene?.size.width)! * 0.1, y: (scene?.size.height)! * 0.85)
        addChild(backButton)
    }
    
    func setText() {
        
        let text1 = SKLabelNode(text: "")
        text1.color = mazeColor
        text1.fontSize = 16.0 * scale
        text1.fontName = "TimesNewRomanPS-BoldMT"
        text1.text = "1. Pick an ability to use in the maze"
        text1.position = CGPoint(x: (self.scene?.size.width)!/2, y: (scene?.size.height)! * 0.7)
        
        let text2 = SKLabelNode(text: "")
        text2.color = mazeColor
        text2.fontSize = 16.0 * scale
        text2.fontName = "TimesNewRomanPS-BoldMT"
        text2.text = "2. Pick a maze"
        text2.position = CGPoint(x: (self.scene?.size.width)!/2, y: (scene?.size.height)! * 0.6)
        
        let text3 = SKLabelNode(text: "")
        text3.color = mazeColor
        text3.fontSize = 16.0 * scale
        text3.fontName = "TimesNewRomanPS-BoldMT"
        text3.text = "3. Blast bad guys, get the loot"
        text3.position = CGPoint(x: (self.scene?.size.width)!/2, y: (scene?.size.height)! * 0.5)
        
        let text4 = SKLabelNode(text: "")
        text4.color = mazeColor
        text4.fontSize = 16.0 * scale
        text4.fontName = "TimesNewRomanPS-BoldMT"
        text4.text = "4. Earn your ability, and use it"
        text4.position = CGPoint(x: (self.scene?.size.width)!/2, y: (scene?.size.height)! * 0.4)
        
        let text5 = SKLabelNode(text: "")
        text5.color = mazeColor
        text5.fontSize = 16.0 * scale
        text5.fontName = "TimesNewRomanPS-BoldMT"
        text5.text = "5. Get out alive!"
        text5.position = CGPoint(x: (self.scene?.size.width)!/2, y: (scene?.size.height)! * 0.3)
        
        let text6 = SKLabelNode(text: "")
        text6.color = mazeColor
        text6.fontSize = 16.0 * scale
        text6.fontName = "TimesNewRomanPS-BoldMT"
        text6.text = "6. Rate this app!"
        text6.position = CGPoint(x: (self.scene?.size.width)!/2, y: (scene?.size.height)! * 0.2)
        
        addChild(text1)
        addChild(text2)
        addChild(text3)
        addChild(text4)
        addChild(text5)
        addChild(text6)
    }
    
    func goToMainMenuScene() {
        
        let mainScene = MainMenuScene()
        mainScene.size = self.size
        mainScene.scaleMode = self.scaleMode
        let transition = SKTransition.fadeWithDuration(1.0)
        self.scene!.view?.presentScene(mainScene, transition: transition)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch! {
            let location = touch.locationInNode(self)
            
            if backButton.containsPoint(location) {
                vc.playSoundEffect(.buttonPress)
                goToMainMenuScene()
            }
        }
    }
} // Mark: End HelpScene






