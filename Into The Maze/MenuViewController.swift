//
//  MenuViewController.swift
//  Into The Maze
//
//  Created by ramiro beltran on 1/20/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import UIKit
import iAd
import GameKit
import SpriteKit

class MenuViewController: UIViewController, ADBannerViewDelegate, GKGameCenterControllerDelegate {
    
    
    var adBanner : ADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadInstallData()
        checkForNewInstall()
        authenticateLocalPlayer()
        loadAdBanner()
    }

    @IBAction func ToMazeSelect(sender: AnyObject) {
        
        self.performSegueWithIdentifier("toMazeSelect", sender: self)
        
    }
    
    @IBAction func rateButtonTapped(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/app/id1077037294")!)
        
    }
    
    @IBAction func gameCenterButtonTapped(sender: AnyObject) {
        
        showLeader()
    }
    //initiate gamecenter
    func authenticateLocalPlayer(){
        
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            
            if (viewController != nil) {
                self.presentViewController(viewController!, animated: true, completion: nil)
            }
                
            else {
                print((GKLocalPlayer.localPlayer().authenticated))
            }
        }
    }
    //shows leaderboard screen
    func showLeader() {
        //var vc = self.view?.window?.rootViewController
        let gc = GKGameCenterViewController()
        gc.gameCenterDelegate = self
        
        presentViewController(gc, animated: true, completion: nil)
    }
    
    //hides leaderboard screen
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController)
    {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
        
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