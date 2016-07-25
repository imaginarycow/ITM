//
//  GameViewController.swift
//  Into The Maze
//
//  Created by ramiro beltran on 1/20/16.
//  Copyright (c) 2016 Ramiro Beltran. All rights reserved.
//

import SpriteKit
import GoogleMobileAds

protocol AdmobInterstitialDelegate {
    func showInterstitial()
}


class GameViewController: UIViewController, UITextFieldDelegate, GADInterstitialDelegate, AdmobInterstitialDelegate {
    
    let interstitial = GADInterstitial(adUnitID: "ca-app-pub-6450694282232724/6482008496")
    var presentingController : UIViewController!
    
    var scene:SKScene!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdMob.sharedInstance.setup(viewController: self, interID: "ca-app-pub-6450694282232724/6482008496")
        
        scene = MainMenuScene()
        
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.multipleTouchEnabled = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = false
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        scene.physicsWorld.gravity = CGVector(dx: 0.0,dy: 0.0)
        scene.physicsBody?.affectedByGravity = false
        
        /* Set the scale mode to scale to fit the window */
        scene.size = skView.bounds.size
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
     
        loadRequest()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    
    
    func setViewController() {
        presentingController = self
        print(presentingController)
        print("view controller set")
    }
    
    func loadRequest() {
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        interstitial.delegate = self
        interstitial.loadRequest(request)
    }

    func showInterstitial() {
        
        print("load ads button tapped")
        print("interstitial isReady: \(interstitial.isReady)")
        loadRequest()
        
        if interstitial.isReady {
           
            print("rootViewController set")
            interstitial.presentFromRootViewController(self)
            
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
}
