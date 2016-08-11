//
//  adHelper.swift
//  Into The Maze
//
//  Created by ramiro beltran on 7/19/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

// bool to see if ad banner should load
var adsRemoved = gameData.boolForKey("adsRemoved")

extension GameScene: AdMobDelegate {
    
    func adMobAdClosed() {
        print("ad closed")
        goBackToPreviousScene()
    }
    func adMobAdClicked() {
        print("ad clicked")
    }

}

