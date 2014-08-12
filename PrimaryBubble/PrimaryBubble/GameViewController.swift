//
//  GameViewController.swift
//  PrimaryBubble
//
//  Created by Thiago Amanajas on 8/7/14.
//  Copyright (c) 2014 Thiago Amanajas. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    private var audioManager:AudioManager = AudioManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillLayoutSubviews() {
        
        // Setting the view configuration.
        var skView:SKView = self.view as SKView
        skView.ignoresSiblingOrder = true
        
        // Creating the game scene.
        var scene:SKScene = GameScene.sceneWithSize(skView.bounds.size)
        scene.scaleMode = SKSceneScaleMode.AspectFill
        skView.presentScene(scene)
        
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
