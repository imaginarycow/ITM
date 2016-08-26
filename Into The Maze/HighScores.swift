//
//  HighScores.swift
//  Into The Maze
//
//  Created by ramiro beltran on 8/24/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import SpriteKit

var numbMazes = 5
//high scores
var highScores: [String:Int] = [:]

var maze1HS = gameData.integerForKey("maze1HS")
var maze2HS = gameData.integerForKey("maze2HS")
var maze3HS = gameData.integerForKey("maze3HS")
var maze4HS = gameData.integerForKey("maze4HS")
var maze5HS = gameData.integerForKey("maze5HS")

func getHighScores() {
    
    for i in 1...numbMazes {
        let hS = gameData.integerForKey("maze\(i)HS")
        highScores["maze\(i)"] = hS
    }
}

func setHighScore(level: Int) {
    
    let previousHS = gameData.integerForKey("maze\(level)HS")
   
    if levelScore > previousHS {
        gameData.setInteger(levelScore, forKey: "maze\(level)HS")
        gameData.synchronize()
    }
    
}