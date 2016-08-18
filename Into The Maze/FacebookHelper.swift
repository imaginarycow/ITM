//
//  FacebookHelper.swift
//  Into The Maze
//
//  Created by ramiro beltran on 8/17/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import SpriteKit
import Social

extension GameScene {
    
    func postToFacebook() {
        
        let shareToFacebook : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        self.view?.window?.rootViewController?.presentViewController(shareToFacebook, animated: true, completion: nil)
        
        shareToFacebook.setInitialText("Playing Into The Maze!")
        

        //shareToFacebook.addImage(UIImage(named: "wordBombLogo2.png"))
        print("post to facebook")
    }
    
}
