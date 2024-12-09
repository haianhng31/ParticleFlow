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
    private var fieldType: FieldType = .none
    var particleCount: Int = 100
    var fieldStrength: CGFloat = 1.0
    var particleColor: UIColor = .white
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        initializeParticles() 
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
        }
        
        removeAllChildren()
        renderParticles()
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
    
    func calculateForce(at position: CGPoint) -> CGVector {
        return fieldType.calculateForce(at: position, strength: fieldStrength)
    }
    
    func setFieldType(_ type: FieldType) {
        fieldType = type
    }
    
    func changeParticleColor(to color: UIColor) {
        particleColor = color
    }
}
