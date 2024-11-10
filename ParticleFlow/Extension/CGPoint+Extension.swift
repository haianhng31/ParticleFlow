//
//  CGPoint+Extension.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/9/24.
//

import SpriteKit

extension CGPoint {
    static func + (left: CGPoint, right: CGVector) -> CGPoint {
        return CGPoint(x: left.x + right.dx, y: left.y + right.dy)
    }
    
    static func += (left: inout CGPoint, right: CGVector) {
        left = left + right
    }
}

