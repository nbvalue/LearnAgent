//
//  WanderScene.swift
//  LearnAgent
//
//  Created by yan on 2020/5/24.
//  Copyright © 2020 yan. All rights reserved.
//

import SpriteKit
import GameplayKit

class WanderScene: GameScene {
    override var sceneName: String{
        "WANDERING"
    }
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        let wanderer = AgentNode(scene: self, radius: 40, position: CGPoint(x: frame.midX, y: frame.midY))
        wanderer.color = .cyan
        wanderer.agent.behavior = GKBehavior(goal: GKGoal(toWander: 10), weight: 100)
        agentSystem.addComponent(wanderer.agent)
    }
}
