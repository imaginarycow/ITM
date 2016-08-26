//
//  GlobalGameData.swift
//  Into The Maze
//
//  Created by ramiro beltran on 1/20/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import SpriteKit

//screen height and width of user's device
var screenHeight:CGFloat = 0.0
var screenWidth:CGFloat = 0.0
var scale:CGFloat = 1.0

let labelFont = "KatalystinactiveBRK"
var level = 0

//let mazeColor: UIColor = UIColor(red: 0/255.0, green: 195/255.0, blue: 199/255.0, alpha: 1.0)
let mazeColor: UIColor = UIColor(red: 0/255.0, green: 152/255.0, blue: 153/255.0, alpha: 1.0)

//create arrays of locked and unlocked levels
var lockedLevels: [Int] = []
var unlockedLevels: [Int] = []

var gameHasRun = false
let gameData = NSUserDefaults.standardUserDefaults()


func loadInstallData() {
    
}

func checkForNewInstall() {

    gameHasRun = gameData.boolForKey("gameHasRun")
    if gameHasRun == false {
        abilityTokens = 1
        gameData.setInteger(abilityTokens, forKey: "abilityTokens")
    }

    if gameHasRun == true {
        abilityTokens = gameData.integerForKey("abilityTokens")
    }
}