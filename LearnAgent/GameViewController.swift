//
//  GameViewController.swift
//  LearnAgent
//
//  Created by yan on 2020/5/24.
//  Copyright © 2020 yan. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var sceneType: SceneType = .seek

    @IBAction func goToNextScene(_ sender: UIBarButtonItem) {
        if sceneType.rawValue + 1 >= SceneType.allCases.count{
            sceneType = SceneType(rawValue: 0)!
        }else{
            sceneType = SceneType(rawValue: sceneType.rawValue + 1)!
        }
        select(type: sceneType)
    }
    @IBAction func goToPreviousScene(_ sender: UIBarButtonItem) {
        if sceneType.rawValue - 1 < 0{
            sceneType = SceneType(rawValue: SceneType.allCases.count - 1)!
        }else{
            sceneType = SceneType(rawValue: sceneType.rawValue - 1)!
        }
        select(type: sceneType)
    }
    
    private func select(type: SceneType){
        let scene = GameScene.loadSceen(type: type, size: CGSize(width: 800, height: 600))
        scene.scaleMode = .aspectFit
        if let view = self.view as! SKView? {
            view.ignoresSiblingOrder = true
            view.presentScene(scene)
            self.navigationItem.title = scene.sceneName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        select(type: sceneType)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
