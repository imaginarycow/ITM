//
//  GameViewController.swift
//  Into The Maze
//
//  Created by ramiro beltran on 1/20/16.
//  Copyright (c) 2016 Ramiro Beltran. All rights reserved.
//

import SpriteKit
import GoogleMobileAds
import AVFoundation

protocol AdmobInterstitialDelegate {
    func showInterstitial()
}


class GameViewController: UIViewController, UITextFieldDelegate, GADInterstitialDelegate, AdmobInterstitialDelegate {
    
    let interstitial = GADInterstitial(adUnitID: "ca-app-pub-6450694282232724/6482008496")
    var scene:SKScene!
    
    //background music and sounds for game
    var bgMusic: AVAudioPlayer?
    var buttonClick: AVAudioPlayer?
    var buttonPress: AVAudioPlayer?
    var gunShot: AVAudioPlayer?
    var tokenGrab: AVAudioPlayer?
    var abilityUse: AVAudioPlayer?
    var alarmSound: AVAudioPlayer?
    var redeemSound: AVAudioPlayer?
    var shiftSound: AVAudioPlayer?
    var gameSound: AVAudioPlayer?
    var explosionSound: AVAudioPlayer?
    var freezeSound: AVAudioPlayer?
    var spawnSound: AVAudioPlayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdMob.sharedInstance.setup(viewController: self, interID: "ca-app-pub-6450694282232724/6482008496")
  
        scene = MainMenuScene()
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.multipleTouchEnabled = true
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.showsPhysics = false
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        scene.physicsWorld.gravity = CGVector(dx: 0.0,dy: 0.0)
        scene.physicsBody?.affectedByGravity = false
        
        /* Set the scale mode to scale to fit the window */
        scene.size = skView.bounds.size
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
     
        loadRequest()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func playSoundEffect(sound: Sound) {
 
        switch sound {
        case .abilitySound:
            self.abilityUse = setupAudioPlayerWithFile("laser2", type: "wav")
            self.abilityUse?.play()
        case .alarmSound:
            self.alarmSound = setupAudioPlayerWithFile("alarm2", type: "wav")
            self.alarmSound?.volume = 0.25
            self.alarmSound?.play()
        case .buttonClick:
            self.buttonClick = setupAudioPlayerWithFile("click", type: "wav")
            self.buttonClick?.volume = 0.3
            self.buttonClick?.play()
        case .buttonPress:
            self.buttonPress = setupAudioPlayerWithFile("buttonPress", type: "wav")
            self.buttonPress?.volume = 0.3
            self.buttonPress?.play()
        case .gunSound:
            //self.gunShot = setupAudioPlayerWithFile("laserSound", type: "wav")
            self.gunShot = setupAudioPlayerWithFile("m4a1", type: "wav")
            self.gunShot?.volume = 0.4
            self.gunShot?.play()
        case .redeemSound:
            self.redeemSound = setupAudioPlayerWithFile("redeemSound", type: "m4a")
            self.redeemSound?.volume = 1.0
            self.redeemSound?.play()
        case .shiftSound:
            self.shiftSound = setupAudioPlayerWithFile("shiftSound", type: "wav")
            self.shiftSound?.volume = 0.6
            self.shiftSound?.play()
        case .gameSound:
            self.gameSound = setupAudioPlayerWithFile("background", type: "wav")
            self.gameSound?.numberOfLoops = 30
            self.gameSound?.volume = 0.2
            self.gameSound?.play()
        case .explosionSound:
            self.explosionSound = setupAudioPlayerWithFile("explosion", type: "wav")
            self.explosionSound?.play()
        case .freezeSound:
            self.freezeSound = setupAudioPlayerWithFile("freeze", type: "wav")
            self.freezeSound?.volume = 1.0
            self.freezeSound?.play()
        case .spawnSound:
            self.spawnSound = setupAudioPlayerWithFile("spawnSound", type: "wav")
            self.spawnSound?.volume = 0.2
            self.spawnSound?.play()
            
        default:
            self.abilityUse = setupAudioPlayerWithFile("laser2", type: "wav")
             self.abilityUse?.play()
        }
        
    }
    
    func playBGMusic() {
        
        if let bgMusic = setupAudioPlayerWithFile("menuBg", type: "mp3") {
            self.bgMusic = bgMusic
        }
        self.bgMusic?.numberOfLoops = 10
        self.bgMusic?.volume = 1.0
        self.bgMusic?.play()
    }
    func stopBGMusic() {
        
        self.bgMusic?.stop()
    }
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        //1
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        
        //2
        var audioPlayer:AVAudioPlayer?
        
        // 3
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        return audioPlayer
    }
    
    func loadRequest() {
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        interstitial.delegate = self
        interstitial.loadRequest(request)
    }

    func showInterstitial() {
        
        print("load ads button tapped")
        print("interstitial isReady: \(interstitial.isReady)")
        loadRequest()
        
        if interstitial.isReady && adsRemoved == false {
           
            print("rootViewController set")
            interstitial.presentFromRootViewController(self)
            
        }
    }
    
    
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        
        return .Landscape
        
    }
    
}
