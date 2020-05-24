//
//  AgentNode.swift
//  LearnAgent
//
//  Created by yan on 2020/5/24.
//  Copyright © 2020 yan. All rights reserved.
//

import SpriteKit
import GameplayKit

class AgentNode: SKNode, GKAgentDelegate {
    
    let agent = GKAgent2D()
    
    private var triangleSharp: SKShapeNode!
    private var particles: SKEmitterNode!
    private var defaultParticleRate: CGFloat!
    
    init(scene: SKScene, radius: CGFloat, position: CGPoint) {
        super.init()
        self.position = position
        zPosition = 10
        scene.addChild(self)
        
        agent.radius = Float(radius)
        agent.position = vector_float2(x: Float(position.x), y: Float(position.y))
        agent.delegate = self
        agent.maxSpeed = 100
        agent.maxAcceleration = 50
        
        let circle = SKShapeNode(circleOfRadius: CGFloat(radius))
        circle.lineWidth = 2.5
        circle.fillColor = .gray
        circle.zPosition = 1
        addChild(circle)
        
        var points = Array<CGPoint>(repeating: .zero, count: 4)
        let triangleBackSideAngle = CGFloat((Double(135.0) / 360.0) * (2 * Double.pi))
        points[0] = CGPoint(x: radius, y: 0)
        points[1] = CGPoint(x: radius * cos(triangleBackSideAngle), y: radius * sin(triangleBackSideAngle))
        points[2] = CGPoint(x: radius * cos(triangleBackSideAngle), y: -radius * sin(triangleBackSideAngle))
        points[3] = CGPoint(x: radius, y: 0)
        triangleSharp = SKShapeNode(points: &points, count: 4)
        triangleSharp.lineWidth = 2.5
        triangleSharp.zPosition = 1
        addChild(triangleSharp)
        
        particles = SKEmitterNode(fileNamed: "Trail")
        defaultParticleRate = particles.particleBirthRate
        particles.position = CGPoint(x: -radius + 5, y: 0)
        particles.targetNode = scene
        particles.zPosition = 0
        addChild(particles)
    }
    
    var color: SKColor{
        get{
            return triangleSharp.strokeColor
        }
        set{
            triangleSharp.strokeColor = newValue
        }
    }
    
    var setDrawsTrail: Bool = false{
        didSet{
            if setDrawsTrail{
                particles.particleBirthRate = defaultParticleRate
            }else{
                particles.particleBirthRate = 0
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func agentDidUpdate(_ agent: GKAgent) {
        if let agent = agent as? GKAgent2D{
            position = CGPoint(x: CGFloat(agent.position.x), y: CGFloat(agent.position.y))
            zRotation = CGFloat(agent.rotation)
        }
    }
}
