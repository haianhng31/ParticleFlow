//
//  Particle.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/9/24.
//

import SpriteKit

class Particle {
    var position: CGPoint
    var velocity: CGVector
    var acceleration: CGVector
    
    init(position: CGPoint) {
        self.position = position
        self.velocity = .zero
        self.acceleration = .zero
    }
}
