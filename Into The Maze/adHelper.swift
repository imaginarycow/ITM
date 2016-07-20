//
//  adHelper.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/19/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import GoogleMobileAds


// bool to see if ad banner should load
var adsRemoved = false

extension GameViewController {
    
    func loadAds() {
        
        if adsRemoved != true {
            
            let request = GADRequest()
            request.testDevices = ["35fb94bbbfdb3b55c59a687311cce2db", kGADSimulatorID]
            
            adBanner = GADBannerView(frame: CGRect(x: self.scene.size.width/2, y: self.scene.size.height * 0.2, width: 320.0, height: 50.0))
            adBanner?.center = CGPoint(x: self.scene.size.width/2, y: self.scene.size.height * 0.2)
            adBanner!.delegate = self
            adBanner!.adUnitID = "ca-app-pub-6450694282232724/2859707690"
            adBanner!.rootViewController = self
            
            adBanner!.center = CGPoint(x: adBanner!.center.x, y: view.bounds.size.height - adBanner!.frame.size.height / 2)
            adBanner!.loadRequest(request)
            
        }
    }
    
    func removeAds() {
        print("removing ads")
        
        adBanner!.alpha = 0
        
    }
    
}





