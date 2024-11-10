//
//  FieldType.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/9/24.
//

import SpriteKit

enum FieldType {
    case none
    case vortex
    case sink
    case source
    case gravitational
    case wave
    
    func calculateForce(at point: CGPoint, strength: CGFloat) -> CGVector {
        switch self {
        case .none:
            return .zero
            
        case .vortex:
            let center = CGPoint(x: point.x - 200, y: point.y - 200)
            let distance = sqrt(center.x * center.x + center.y * center.y)
            return CGVector(
                dx: -center.y / distance,
                dy: center.x / distance
            ) * strength
            
        case .sink:
            let center = CGPoint(x: point.x - 200, y: point.y - 200)
            let distance = sqrt(center.x * center.x + center.y * center.y)
            return CGVector(
                dx: -center.x / distance,
                dy: -center.y / distance
            ) * strength
            
        case .source:
            let center = CGPoint(x: point.x - 200, y: point.y - 200)
            let distance = sqrt(center.x * center.x + center.y * center.y)
            return CGVector(
                dx: center.x / distance,
                dy: center.y / distance
            ) * strength
            
        case .gravitational:
            let center = CGPoint(x: point.x - 200, y: point.y - 200)
            let distance = sqrt(center.x * center.x + center.y * center.y)
            let force = strength / (distance * distance + 1)
            return CGVector(
                dx: -center.x * force,
                dy: -center.y * force
            )
            
        case .wave:
            // This creates a sinusoidal wave pattern moving left to right
            let frequency: CGFloat = 0.1  // Adjust for desired wave length
//            let speed: CGFloat = 0.5      // Adjust for wave speed
            let time = CGFloat(Date().timeIntervalSince1970)
            
            return CGVector(
                dx: strength,  // Constant rightward motion
                dy: strength * sin(frequency * point.x + strength * time)  // Up and down motion
            )
        }
    }
}
