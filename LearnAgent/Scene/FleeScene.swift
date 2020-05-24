//
//  FleeScene.swift
//  LearnAgent
//
//  Created by yan on 2020/5/24.
//  Copyright © 2020 yan. All rights reserved.
//

import SpriteKit
import GameplayKit

class FleeScene: GameScene {
    private var player: AgentNode!
    private var enemy: AgentNode!
    private var seekGoal: GKGoal!
    private var fleeGoal: GKGoal!
    
    override var sceneName: String{
        "FLEEING"
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        player = AgentNode(scene: self, radius: 40, position: CGPoint(x: frame.midX - 150, y: frame.midY))
        player.agent.behavior = GKBehavior()
        agentSystem.addComponent(player.agent)
        
        enemy = AgentNode(scene: self, radius: 40, position: CGPoint(x: frame.midX + 150, y: frame.midY))
        enemy.color = .red
        enemy.agent.behavior = GKBehavior()
        agentSystem.addComponent(enemy.agent)
        
        seekGoal = GKGoal(toSeekAgent: trackingAgent)
        fleeGoal = GKGoal(toFleeAgent: player.agent)
    }
    
    override var seeking: Bool{
        didSet{
            super.seeking = seeking
            if seeking{
                player.agent.behavior?.setWeight(1, for: seekGoal)
                player.agent.behavior?.setWeight(0, for: stopGoal)
            }else{
                player.agent.behavior?.setWeight(0, for: seekGoal)
                player.agent.behavior?.setWeight(1, for: stopGoal)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        let distance = hypot(player.agent.position.x - enemy.agent.position.x, player.agent.position.y - enemy.agent.position.y)
        if distance > 200{
            enemy.agent.behavior?.setWeight(0, for: fleeGoal)
            enemy.agent.behavior?.setWeight(1, for: stopGoal)
        }else{
            enemy.agent.behavior?.setWeight(1, for: fleeGoal)
            enemy.agent.behavior?.setWeight(0, for: stopGoal)
        }
        super.update(currentTime)
    }
}
