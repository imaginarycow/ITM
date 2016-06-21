//
//  MazeSelectExtension.swift
//  Into The Maze
//
//  Created by Ramiro Beltran on 1/21/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import UIKit

extension ChooseViewController {
    
    
    func setLocks() {
        
        //loop through unlocked levels and place locks and
        //disable the level buttons
        for level in lockedLevels {
            print(level)
            var maze:UIButton!
            var lock:UIImageView!
            
            switch level {
            case 2:
                maze = maze2
                lock = lock1
            case 3:
                maze = maze3
                lock = lock2
            case 4:
                maze = maze4
                lock = lock3
            case 5:
                maze = maze5
                lock = lock4
            case 6:
                maze = maze6
                lock = lock5
            case 7:
                maze = maze7
                lock = lock6
            case 8:
                maze = maze8
                lock = lock7
            case 9:
                maze = maze9
                lock = lock8
            case 10:
                maze = maze10
                lock = lock9
            case 11:
                maze = maze11
                lock = lock10
            case 12:
                maze = maze12
                lock = lock11
            default:
                break
            }
            maze.enabled = false
            lock.hidden = false
            
        }
        //loop through unlocked levels and remove locks and
        //enable the level buttons
        for level in unlockedLevels {
            print(level)
            var maze:UIButton = UIButton()
            var lock:UIImageView = UIImageView()
            
            switch level {
            case 2:
                maze = maze2
                lock = lock1
            case 3:
                maze = maze3
                lock = lock2
            case 4:
                maze = maze4
                lock = lock3
            case 5:
                maze = maze5
                lock = lock4
            case 6:
                maze = maze6
                lock = lock5
            case 7:
                maze = maze7
                lock = lock6
            case 8:
                maze = maze8
                lock = lock7
            case 9:
                maze = maze9
                lock = lock8
            case 10:
                maze = maze10
                lock = lock9
            case 11:
                maze = maze11
                lock = lock10
            case 12:
                maze = maze12
                lock = lock11
            default:
                break
            }
            maze.enabled = true
            lock.hidden = true
            
        }


    }
    
    
}
