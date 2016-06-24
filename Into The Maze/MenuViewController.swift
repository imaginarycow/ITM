//
//  MenuViewController.swift
//  Into The Maze
//
//  Created by ramiro beltran on 1/20/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import UIKit
import SpriteKit

class MenuViewController: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadInstallData()
        checkForNewInstall()
        
    }

    @IBAction func ToMazeSelect(sender: AnyObject) {
        
        self.performSegueWithIdentifier("toMazeSelect", sender: self)
        
    }
    
    @IBAction func rateButtonTapped(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/app/id1077037294")!)
        
    }

    
}