//
//  GameViewController.swift
//  Into The Maze
//
//  Created by ramiro beltran on 1/20/16.
//  Copyright (c) 2016 Ramiro Beltran. All rights reserved.
//

import UIKit
import SpriteKit
import iAd

class GameViewController: UIViewController, ADBannerViewDelegate {
    

    var scene:SKScene!
    var adBanner: ADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scene = level1GameScene(size: CGSize(width: 768, height: 1024))
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = false
        scene.physicsWorld.gravity = CGVector(dx: 0.0,dy: 0.0)
        scene.physicsBody?.affectedByGravity = false
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        scene.removeAllChildren()
        skView.presentScene(scene)
        loadAdBanner()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
        
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
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        scene!.removeAllChildren()
        self.performSegueWithIdentifier("toChooseMaze", sender: self)
    }

    //loads adbanner only if remove ads upgrade not purchased
    func loadAdBanner() {
        
        if removeAdsPurchased == false {
            
            adBanner = ADBannerView(frame: CGRect.zero)
            adBanner.center = CGPoint(x: adBanner.center.x, y: view.bounds.size.height - adBanner.frame.size.height / 2)
            adBanner.delegate = self
            adBanner.hidden = true
            view.addSubview(adBanner)
            
        }
        
    }
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        adBanner.hidden = false
    }
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        adBanner.hidden = false
    }
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return true
    }

}
