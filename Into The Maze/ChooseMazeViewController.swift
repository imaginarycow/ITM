//
//  ChooseViewController.swift
//  Into The Maze
//
//  Created by ramiro beltran on 1/20/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import UIKit
import iAd

class ChooseViewController : UIViewController, ADBannerViewDelegate {
    
    
    @IBOutlet weak var lock1: UIImageView!
    @IBOutlet weak var lock2: UIImageView!
    @IBOutlet weak var lock3: UIImageView!
    @IBOutlet weak var lock4: UIImageView!
    @IBOutlet weak var lock5: UIImageView!
    @IBOutlet weak var lock6: UIImageView!
    @IBOutlet weak var lock7: UIImageView!
    @IBOutlet weak var lock8: UIImageView!
    @IBOutlet weak var lock9: UIImageView!
    @IBOutlet weak var lock10: UIImageView!
    @IBOutlet weak var lock11: UIImageView!
    
    @IBOutlet weak var maze2: UIButton!
    @IBOutlet weak var maze3: UIButton!
    @IBOutlet weak var maze4: UIButton!
    @IBOutlet weak var maze5: UIButton!
    @IBOutlet weak var maze6: UIButton!
    @IBOutlet weak var maze7: UIButton!
    @IBOutlet weak var maze8: UIButton!
    @IBOutlet weak var maze9: UIButton!
    @IBOutlet weak var maze10: UIButton!
    @IBOutlet weak var maze11: UIButton!
    @IBOutlet weak var maze12: UIButton!
    
    
    var adBanner : ADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocks()
        loadAdBanner()
    }
    
    @IBAction func maze1Selected(sender: AnyObject) {
        self.performSegueWithIdentifier("toGame", sender: self)
    }
    
    @IBAction func maze2Selected(sender: AnyObject) {
        self.performSegueWithIdentifier("toGame", sender: self)
    }
    
    @IBAction func maze3Selected(sender: AnyObject) {
        self.performSegueWithIdentifier("toGame", sender: self)
    }
    
    @IBAction func maze4Selected(sender: AnyObject) {
        self.performSegueWithIdentifier("toGame", sender: self)
    }
    
    @IBAction func maze5Selected(sender: AnyObject) {
        self.performSegueWithIdentifier("toGame", sender: self)
    }
    
    @IBAction func maze6Selected(sender: AnyObject) {
        self.performSegueWithIdentifier("toGame", sender: self)
    }
    
    @IBAction func maze7Selected(sender: AnyObject) {
        self.performSegueWithIdentifier("toGame", sender: self)
    }
    
    @IBAction func maze8Selected(sender: AnyObject) {
        self.performSegueWithIdentifier("toGame", sender: self)
    }
    
    @IBAction func maze9Selected(sender: AnyObject) {
        self.performSegueWithIdentifier("toGame", sender: self)
    }
    
    @IBAction func maze10Selected(sender: AnyObject) {
        self.performSegueWithIdentifier("toGame", sender: self)
    }
    
    @IBAction func maze11Selected(sender: AnyObject) {
        self.performSegueWithIdentifier("toGame", sender: self)
    }
    
    @IBAction func maze12Selected(sender: AnyObject) {
        self.performSegueWithIdentifier("toGame", sender: self)
    }
    
    @IBAction func toMenuButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("toMenu", sender: self)
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
