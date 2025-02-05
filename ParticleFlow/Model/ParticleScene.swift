//
//  ParticleScene.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/9/24.
//

import SpriteKit
import SwiftUI

class ParticleScene: SKScene {
    var particles: [Particle] = []
    var particleCount: Int = 100
    var fieldStrength: CGFloat = 0.1
    private(set) var particleColor: UIColor = .white
    private var fieldType: FieldType = .none
    
    // Properties for divergence and curl
    var divergence: Double = 0.0
    var curl: Double = 0.0
    
    // Properties for field superposition
    var isFieldSuperposition = false
    var field1Strength: CGFloat = 1.0
    var field2Strength: CGFloat = 1.0
    var field1Type: FieldType = .vortex
    var field2Type: FieldType = .sink
    
    // Properties for anomalies and obstacles
    var isHavingObstacle = false
    var obstaclePosition: CGPoint = CGPoint(x: 200, y: 200) {
        didSet {
            updateObstacleNodePosition()
        }
    }
    private var obstacleNode: SKShapeNode!
    var anomalyStrength: CGFloat = 1.0
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        initializeParticles() 
        if isHavingObstacle {
            initializeObstacle()
        }
    }
    
    func initializeParticles() {
        particles.removeAll()
        removeAllChildren()
        
        for _ in 0..<particleCount {
            let randomPosition = CGPoint(
                x: CGFloat.random(in: 0...size.width),
                y: CGFloat.random(in: 0...size.height)
            )
            particles.append(Particle(position: randomPosition))
        }
        
//        // Re-add the obstacle node after removing all children
//        if (obstacleNode == nil) {
//            initializeObstacle()
//        } else {
//            addChild(obstacleNode)
//        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        for particle in particles {
            let force = calculateForce(at: particle.position)
            particle.acceleration = force
            particle.velocity += particle.acceleration
            particle.velocity *= 0.99
            particle.position += particle.velocity
            
            // Wrap around edges
            if particle.position.x < 0 { particle.position.x = size.width }
            if particle.position.x > size.width { particle.position.x = 0 }
            if particle.position.y < 0 { particle.position.y = size.height }
            if particle.position.y > size.height { particle.position.y = 0 }
            
            // Check for collision with the obstacle
            if isHavingObstacle {
                let distanceToObstacle = sqrt(pow(particle.position.x - obstaclePosition.x, 2) + pow(particle.position.y - obstaclePosition.y, 2))
                let obstacleRadius: CGFloat = 50 // Radius of the obstacle

                if distanceToObstacle < obstacleRadius {
                // Handle collision: Bounce the particle off the obstacle
                let normal = CGVector(dx: particle.position.x - obstaclePosition.x, dy: particle.position.y - obstaclePosition.y).normalized()
                let reflection = reflect(vector: particle.velocity, across: normal)
                particle.velocity = reflection * 0.8 // Add some damping to the bounce
                }
            }
        }
        
        removeAllChildren()
        renderParticles()
        addChild(obstacleNode) 
    }
    
    func renderParticles() {
        for particle in particles {
            let node = SKShapeNode(circleOfRadius: 2)
            node.position = particle.position
            node.fillColor = particleColor
            node.strokeColor = .clear
            addChild(node)
        }
    }
    
    func initializeObstacle() {
        // Create the obstacle node
        obstacleNode = SKShapeNode(circleOfRadius: 30)
        obstacleNode.fillColor = .red
        obstacleNode.position = obstaclePosition
        addChild(obstacleNode)
    }
    
    func updateObstacleNodePosition() {
        obstacleNode.position = obstaclePosition
    }
    
    func calculateForce(at position: CGPoint) -> CGVector {
        if isFieldSuperposition {
            let field1Force = field1Type.calculateForce(at: position, strength: field1Strength)
            let field2Force = field2Type.calculateForce(at: position, strength: field2Strength)
            return field1Force + field2Force
        }
        
        let fieldForce = fieldType.calculateForce(at: position, strength: fieldStrength)
        
        if isHavingObstacle {
            let distanceToObstacle = sqrt(pow(position.x - obstaclePosition.x, 2) + pow(position.y - obstaclePosition.y, 2))
            if distanceToObstacle < 50 {
                let anomalyForce = CGVector(
                    dx: (position.x - obstaclePosition.x) * anomalyStrength,
                    dy: (position.y - obstaclePosition.y) * anomalyStrength
                )
                return fieldForce + anomalyForce
            }
        }
        
        // Divergence effect: Particles move outward or inward based on divergence
        let divergenceForce = CGVector(dx: position.x * divergence, dy: position.y * divergence)
        
        // Curl effect: Particles rotate around the center based on curl
        let curlForce = CGVector(dx: -position.y * curl, dy: position.x * curl)

        return fieldForce + divergenceForce + curlForce
        
    }
    
    // Helper function to reflect a vector across a normal
    func reflect(vector: CGVector, across normal: CGVector) -> CGVector {
        let dotProduct = vector.dx * normal.dx + vector.dy * normal.dy
        return CGVector(
            dx: vector.dx - 2 * dotProduct * normal.dx,
            dy: vector.dy - 2 * dotProduct * normal.dy
        )
    }
    
    func setFieldType(_ type: FieldType) {
        fieldType = type
    }
    
    func changeParticleColor(to color: UIColor) {
        particleColor = color
    }
}

extension CGVector {
    func normalized() -> CGVector {
        let length = sqrt(dx * dx + dy * dy)
        guard length > 0 else { return .zero } // Avoid division by zero
        return CGVector(dx: dx / length, dy: dy / length)
    }
}
