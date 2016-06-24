//
//  GameViewController.swift
//  Into The Maze
//
//  Created by ramiro beltran on 1/20/16.
//  Copyright (c) 2016 Ramiro Beltran. All rights reserved.
//

import SpriteKit

class GameViewController: UIViewController {
    

    var scene:SKScene!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scene = MainMenuScene()
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        scene.physicsWorld.gravity = CGVector(dx: 0.0,dy: 0.0)
        scene.physicsBody?.affectedByGravity = false
        
        /* Set the scale mode to scale to fit the window */
        scene.size = skView.bounds.size
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)

    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
}
