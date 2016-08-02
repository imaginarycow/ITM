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
        backButton.fontSize = 12.0
        backButton.color = .redColor()
        backButton.position = CGPoint(x: (scene?.size.width)! * 0.1, y: (scene?.size.height)! * 0.85)
        addChild(backButton)
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






