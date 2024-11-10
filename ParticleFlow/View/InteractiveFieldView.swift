//
//  InteractiveFieldView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/9/24.
//

import SwiftUI
import SpriteKit

struct TouchPoint: Hashable {
    let x: CGFloat
    let y: CGFloat
    
    init(_ point: CGPoint) {
        self.x = point.x
        self.y = point.y
    }
    
    var cgPoint: CGPoint {
        CGPoint(x: x, y: y)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
    
    static func == (lhs: TouchPoint, rhs: TouchPoint) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

class InteractiveScene: ParticleScene {
    private var touchPoints: [TouchPoint: CGVector] = [:]
    private var touchOrder: [TouchPoint] = []  // Keep track of touch point order
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchPoint = TouchPoint(location)
        touchPoints[touchPoint] = .zero
        touchOrder.append(touchPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
        let vector = CGVector(
            dx: location.x - previousLocation.x,
            dy: location.y - previousLocation.y
        )
        let touchPoint = TouchPoint(location)
        touchPoints[touchPoint] = vector
        touchOrder.append(touchPoint)
        
        // Remove old points if we have too many
        while touchOrder.count > 10 {
            let oldestPoint = touchOrder.removeFirst()
            touchPoints.removeValue(forKey: oldestPoint)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchPoints.removeAll()
        touchOrder.removeAll()
    }
    
    override func calculateForce(at position: CGPoint) -> CGVector {
        var totalForce = CGVector.zero
        
        for (touchPoint, vector) in touchPoints {
            let distance = sqrt(
                pow(position.x - touchPoint.x, 2) +
                pow(position.y - touchPoint.y, 2)
            )
            
            if distance < 100 {
                let influence = (100 - distance) / 100
                totalForce += vector * influence
            }
        }
        
        return totalForce
    }
}

struct InteractiveFieldView: View {
    var scene: SKScene {
        let scene = InteractiveScene(size: CGSize(width: 400, height: 400))
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Interactive Vector Field")
                .withGradientTitle(size: 30)
            
            SpriteView(scene: scene)
                .frame(width: 400, height: 400)
                .cornerRadius(10)
                .border(Color.gray, width: 1)
            
            Text("Touch and drag to create vector fields. The particles will follow your touch movements!")
                .padding(.horizontal)
                .foregroundColor(.secondary)
            
            Text("Experiment with different patterns and see how the particles respond to your input.")
                .padding(.horizontal)
                .padding(.bottom)
                .foregroundColor(.secondary)
            
            NavigationLink(destination: FinalConclusion()) {
                GradientButton(text: "Next")
                    .frame(width: 150)
            }
        }
        .padding()
        .withGradientBackground()
//        .toolbar {
//            Button("Change particle color") {
//                scene.changeParticleColor(to:
//                    scene.particleColor == .white ? .blue : .white
//                )
//            }
//        }
    }
}

#Preview {
    InteractiveFieldView()
}
