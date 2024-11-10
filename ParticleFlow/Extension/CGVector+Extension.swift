//
//  CGVector+Extension.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/9/24.
//

import SpriteKit

extension CGVector {
    static func + (left: CGVector, right: CGVector) -> CGVector {
        return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
    }
    
    static func += (left: inout CGVector, right: CGVector) {
        left = left + right
    }
    
    static func * (vector: CGVector, scalar: CGFloat) -> CGVector {
        return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
    }
    
    static func *= (left: inout CGVector, scalar: CGFloat) {
        left = CGVector(dx: left.dx * scalar, dy: left.dy * scalar)
    }
}
