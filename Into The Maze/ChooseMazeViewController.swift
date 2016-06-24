//
//  ChooseViewController.swift
//  Into The Maze
//
//  Created by ramiro beltran on 1/20/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import UIKit

class ChooseViewController : UIViewController {
    
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocks()

    }
    
    @IBAction func maze1Selected(sender: AnyObject) {
        level = 1
        self.performSegueWithIdentifier("toGame", sender: self)

    }
    
    @IBAction func maze2Selected(sender: AnyObject) {
        level = 2
        self.performSegueWithIdentifier("toGame", sender: self)
    }
    
    @IBAction func maze3Selected(sender: AnyObject) {
        level = 3
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
    
    
    
}
