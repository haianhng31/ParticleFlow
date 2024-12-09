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
            let frequency: CGFloat = 0.1  // wave length
            //            let speed: CGFloat = 0.5      // wave speed
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
        let variables: [String: CGFloat] = [
            "centerX": center.x,
            "centerY": center.y,
            "distance": distance,
            "pi": CGFloat.pi
        ]

        // Substitute variables into the formula
        var processedFormula = formula
        variables.forEach { key, value in
            processedFormula = processedFormula.replacingOccurrences(of: key, with: "\(value)")
        }

        // Replace supported functions with their computed values
        let patterns: [String: (CGFloat) -> CGFloat] = [
            "sin": { sin($0) },
            "cos": { cos($0) },
            "abs": { abs($0) }
        ]

        for (functionName, function) in patterns {
            let regex = try! NSRegularExpression(pattern: "\(functionName)\\(([^\\)]+)\\)")
            let matches = regex.matches(in: processedFormula, options: [], range: NSRange(processedFormula.startIndex..., in: processedFormula))
            
            for match in matches {
                // Extract the argument (value inside parentheses)
                if let range = Range(match.range(at: 1), in: processedFormula) {
                    let argument = processedFormula[range]
                    if let argumentValue = Double(argument) {
                        let result = function(CGFloat(argumentValue))
                        
                        // Replace the function call with the result
                        let fullMatchRange = match.range
                        if let fullRange = Range(fullMatchRange, in: processedFormula) {
                            processedFormula.replaceSubrange(fullRange, with: "\(result)")
                        }
                    } else {
                        fatalError("Invalid formula argument for \(functionName): \(argument)")
                    }
                }
            }
        }
        
        print("Processed formula: \(processedFormula)")

        // Evaluate the processed formula without any functions
        let expression = NSExpression(format: processedFormula)
        if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber {
            return CGFloat(result.doubleValue)
        }
       
       // Fallback to a default value if evaluation fails
       return 0
    }
}


