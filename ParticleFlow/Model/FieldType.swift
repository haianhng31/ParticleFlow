//
//  FieldType.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/9/24.
//

import SpriteKit

enum FieldType: Hashable {
    case none
    case vortex
    case sink
    case source
    case gravitational
    case wave
    case custom(dx: String, dy: String)
    
    func calculateForce(at point: CGPoint, strength: CGFloat) -> CGVector {
        let center = CGPoint(x: point.x - 200, y: point.y - 200)
        let distance = sqrt(center.x * center.x + center.y * center.y)
        
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
            return CGVector(
                dx: -center.x / distance,
                dy: -center.y / distance
            ) * strength
            
        case .source:
            return CGVector(
                dx: center.x / distance,
                dy: center.y / distance
            ) * strength
            
        case .gravitational:
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
        
        case .custom(let dx, let dy):
            let calculatedDx = evaluateFormula(dx, center: center, distance: distance)
            let calculatedDy = evaluateFormula(dy, center: center, distance: distance)
            
            return CGVector(dx: calculatedDx * strength, dy: calculatedDy * strength)
        }
    }
    
    func evaluateFormula(_ formula: String, center: CGPoint, distance: CGFloat) -> CGFloat {
        // Create a dictionary of available variables
        let variables: [String: CGFloat] = [
            "center.x": center.x,
            "center.y": center.y,
            "distance": distance,
            "pi": CGFloat.pi
        ]
        
        // Replace any custom functions or variables
        let processedFormula = formula
            .replacingOccurrences(of: "sin", with: "FUNCTION(center.x, 'sin:')")
            .replacingOccurrences(of: "cos", with: "FUNCTION(center.x, 'cos:')")
            .replacingOccurrences(of: "abs", with: "FUNCTION(center.x, 'abs:')")
        
        // Create an expression with the formula
        let expression = NSExpression(format: processedFormula)
        
        // Create a context with variables
        let context = NSMutableDictionary()
        variables.forEach { context[$0.key] = $0.value }
        
        // Evaluate the expression
        if let result = expression.expressionValue(with: context, context: nil) as? CGFloat {
            return result
        }
       
        // Fallback to a default value if evaluation fails
        return 0
    }
}
