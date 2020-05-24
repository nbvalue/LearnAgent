//
//  SeekScene.swift
//  LearnAgent
//
//  Created by yan on 2020/5/24.
//  Copyright © 2020 yan. All rights reserved.
//

import GameplayKit
import SpriteKit

class SeekScene: GameScene {
    
    var player: AgentNode!
    var seekGoal: GKGoal!
    
    override var sceneName: String{
        "SEEKING"
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        player = AgentNode(scene: self, radius: 40, position: CGPoint(x: frame.midX, y: frame.midY))
        player.agent.behavior = GKBehavior()
        agentSystem.addComponent(player.agent)
        seekGoal = GKGoal(toSeekAgent: trackingAgent)
    }
    
    override var seeking: Bool{
        didSet{
            super.seeking = seeking
            if seeking{
                player.agent.behavior?.setWeight(1, for: seekGoal)
                player.agent.behavior?.setWeight(0, for: stopGoal)
            }else{
                player.agent.behavior?.setWeight(1, for: stopGoal)
                player.agent.behavior?.setWeight(0, for: seekGoal)
            }
        }
    }
}
