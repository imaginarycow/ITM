//
//  GlobalGameData.swift
//  Into The Maze
//
//  Created by ramiro beltran on 1/20/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import UIKit

//screen height and width of user's device
var screenHeight:CGFloat = 0.0
var screenWidth:CGFloat = 0.0
var scale:CGFloat = 1.0

let labelFont = "Charcoal"
var level = 0


//let mazeColor: UIColor = UIColor(red: 0/255.0, green: 195/255.0, blue: 199/255.0, alpha: 1.0)
let mazeColor: UIColor = UIColor(red: 0/255.0, green: 152/255.0, blue: 153/255.0, alpha: 1.0)

//create arrays of locked and unlocked levels
var lockedLevels: [Int] = []
var unlockedLevels: [Int] = []

var gameHasRun = false
let gameData = NSUserDefaults.standardUserDefaults()


func updateScore() {
    
}
//remove level from lockedLevels array, and 
//move to unlockedLevels array
func unlockLevel(level: Int) {
    if let index = lockedLevels.indexOf(level) {
        lockedLevels.removeAtIndex(index)
        unlockedLevels.append(level)
        
        gameData.setObject(lockedLevels, forKey: "lockedLevels")
        gameData.setObject(unlockedLevels, forKey: "unlockedLevels")
        gameData.synchronize()
    }
}

func buildInitialLevelArrays() {
    lockedLevels = [2,3,4,5,6,7,8,9,10,11,12]
    unlockedLevels = [1]
    
    gameData.setBool(true, forKey: "gameHasRun")
    gameData.setObject(lockedLevels, forKey: "lockedLevels")
    gameData.setObject(unlockedLevels, forKey: "unlockedLevels")
    
    gameData.synchronize()
}

func loadInstallData() {
    
}

func checkForNewInstall() {

    gameHasRun = gameData.boolForKey("gameHasRun")
    if gameHasRun == false {
        buildInitialLevelArrays()
    }

    if gameHasRun == true {
        lockedLevels = gameData.objectForKey("lockedLevels") as! Array
        unlockedLevels = gameData.objectForKey("unlockedLevels") as! Array
    }
}