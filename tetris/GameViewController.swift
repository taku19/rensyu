//
//  GameViewController.swift
//  tetris
//
//  Created by taku on 2018/08/08.
//  Copyright (c) 2018年 alche. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var scene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        // Create and configyre the scene.
        scene = GameScene(size : skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        // Present the Scene.
        skView.presentScene(scene)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
