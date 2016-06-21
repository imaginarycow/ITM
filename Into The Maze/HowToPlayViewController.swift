//
//  HowToPlayViewController.swift
//  Into The Maze
//
//  Created by ramiro beltran on 1/20/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import UIKit
import iAd

class HowToPlayViewController : UIViewController, ADBannerViewDelegate {
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var scroller: UIScrollView!
    var adBanner : ADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTextView()
        scroller.contentInset = UIEdgeInsetsMake(0, 0, 800, 0)
        loadAdBanner()
    }
    
    func loadTextView() {
        textView.text = "About the maze:\n\n\t--it will shift\n\t--hazards will arise\n\nTo play:\n\n1. Choose an ability.\n\n\tThink of these abilities as special powers that you may use when they have been earned.  You can change this ability anytime you return to the menu.  Each ability is different and may be more beneficial than another based on how you play, and which maze it is.\n\n Speed Burst:\n\tMove at 2X speed for 5 seconds\n\nBrick Breaker:\n\tFace a wall and break through it\n\nTime Freeze:\n\tMaze will not shift for 10 sec.\n\n2. Choose an unlocked maze.\n\n\tchoose a starting point\n\n\tget to the center\n\n\tplay again and again\n\n\traise your score\n\n3. Beat all 12 mazes\n\n\tbrag on facebook and twitter\n\n\tinvite friends to play\n\n\twait for part 2"
        
    }
    
    @IBAction func backToMenuButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.scroller.frame = self.view.bounds
        self.scroller.contentSize.height = 400
        self.scroller.contentSize.width = 0
    }
    
    
}