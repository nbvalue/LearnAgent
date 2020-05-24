//
//  GameScene.swift
//  LearnAgent
//
//  Created by yan on 2020/5/24.
//  Copyright © 2020 yan. All rights reserved.
//

import SpriteKit
import GameplayKit


enum SceneType: Int, CaseIterable{
    case seek = 0
    case wander
    case flee
    case avoid
    case seperate
    case align
    case flock
    case path
}

class GameScene: SKScene {
    
    class func loadSceen(type: SceneType, size: CGSize)->GameScene{
        switch type {
        case .seek:
            return SeekScene(size: size)
        case .align:
            return AlignScene(size: size)
        case .wander:
            return WanderScene(size: size)
        case .flee:
            return FleeScene(size: size)
        case .avoid:
            return AvoidScene(size: size)
        case .seperate:
            return SeparateScene(size: size)
        case .flock:
            return FlockScene(size: size)
        case .path:
            return PathScene(size: size)
        }
    }
    
    var sceneName: String{
        "Deafault"
    }
    
    var agentSystem: GKComponentSystem<GKAgent2D>!
    
    var trackingAgent: GKAgent2D!
    
    var lastUpdateTime: TimeInterval = 0.0
    
    var seeking: Bool = false
    
    let stopGoal = GKGoal(toReachTargetSpeed: 0)
    
    override func didMove(to view: SKView) {
        let label = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 65).fontName)
        label.text = sceneName
        label.fontSize = 65
        label.horizontalAlignmentMode = .left
        label.verticalAlignmentMode = .top
        label.position = CGPoint(x: frame.minX + 10, y: frame.maxX - 46)
        addChild(label)
        agentSystem = GKComponentSystem(componentClass: GKAgent2D.self)
        trackingAgent = GKAgent2D()
        trackingAgent.position = vector_float2(x: Float(frame.midX), y: Float(frame.midY))
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0{
            lastUpdateTime = currentTime
        }
        let delta = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        agentSystem.update(deltaTime: delta)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        seeking = true
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        seeking = false
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        seeking = false
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let p = touches.first?.location(in: self){
            trackingAgent.position = vector_float2(x: Float(p.x), y: Float(p.y))
        }
    }
}


