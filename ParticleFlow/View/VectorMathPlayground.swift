//
//  VectorMathPlayground.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 12/2/24.
//

import SwiftUI

struct VectorMathPlaygroundView: View {
    @State private var vector1X: Double = 0
    @State private var vector1Y: Double = 0
    @State private var vector2X: Double = 0
    @State private var vector2Y: Double = 0
    @State private var scalarValue: Double = 1.0
    
    var resultVector: (x: Double, y: Double) {
        // Vector addition
        let addedX = vector1X + vector2X
        let addedY = vector1Y + vector2Y
        
        return (addedX, addedY)
    }
    
    var scaledVector: (x: Double, y: Double) {
        // Vector scaling
        return (vector1X * scalarValue, vector1Y * scalarValue)
    }
    
    var dotProduct: Double {
        // Dot product calculation
        return vector1X * vector2X + vector1Y * vector2Y
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Vector Math Playground")
                    .withGradientTitle(size: 30)
                
                // Vector 1 Controls
                VStack(alignment: .leading) {
                    Text("Vector 1")
                        .font(.headline)
                    HStack {
                        Text("X: \(String(format: "%.1f", vector1X))")
                        Slider(value: $vector1X, in: -10...10, step: 0.1)
                    }
                    HStack {
                        Text("Y: \(String(format: "%.1f", vector1Y))")
                        Slider(value: $vector1Y, in: -10...10, step: 0.1)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Vector 2 Controls
                VStack(alignment: .leading) {
                    Text("Vector 2")
                        .font(.headline)
                    HStack {
                        Text("X: \(String(format: "%.1f", vector2X))")
                        Slider(value: $vector2X, in: -10...10, step: 0.1)
                    }
                    HStack {
                        Text("Y: \(String(format: "%.1f", vector2Y))")
                        Slider(value: $vector2Y, in: -10...10, step: 0.1)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Scalar Multiplication
                VStack(alignment: .leading) {
                    Text("Scalar Multiplication")
                        .font(.headline)
                    HStack {
                        Text("Scalar: \(String(format: "%.1f", scalarValue))")
                        Slider(value: $scalarValue, in: -5...5, step: 0.1)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Results Display
                VStack(spacing: 10) {
                    Text("Vector Operations")
                        .font(.title2)
                    
                    HStack {
                        VStack {
                            Text("Vector Addition")
                                .font(.headline)
                            Text("(\(String(format: "%.1f", resultVector.x)), \(String(format: "%.1f", resultVector.y)))")
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("Scaled Vector")
                                .font(.headline)
                            Text("(\(String(format: "%.1f", scaledVector.x)), \(String(format: "%.1f", scaledVector.y)))")
                        }
                    }
                    
                    Text("Dot Product: \(String(format: "%.1f", dotProduct))")
                        .font(.headline)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
                
                // Visual Vector Representation
                Canvas { context, size in
                    let center = CGPoint(x: size.width / 2, y: size.height / 2)
                    let scale: CGFloat = 20
                    
                    // Original Vectors
                    drawVector(context: context,
                               start: center,
                               end: CGPoint(x: center.x + CGFloat(vector1X) * scale,
                                            y: center.y - CGFloat(vector1Y) * scale),
                               color: .blue)
                    
                    drawVector(context: context,
                               start: center,
                               end: CGPoint(x: center.x + CGFloat(vector2X) * scale,
                                            y: center.y - CGFloat(vector2Y) * scale),
                               color: .green)
                    
                    // Result Vectors
                    drawVector(context: context,
                               start: center,
                               end: CGPoint(x: center.x + CGFloat(resultVector.x) * scale,
                                            y: center.y - CGFloat(resultVector.y) * scale),
                               color: .red)
                    
                    drawVector(context: context,
                               start: center,
                               end: CGPoint(x: center.x + CGFloat(scaledVector.x) * scale,
                                            y: center.y - CGFloat(scaledVector.y) * scale),
                               color: .purple)
                }
                .frame(width: 300, height: 300)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                
                Text("Explore vector operations by adjusting the sliders. See how changing vector components affects addition, scaling, and dot product.")
                    .padding()
                    .foregroundColor(.secondary)
                
                // Navigation button
                NavigationLink(destination: BasicsView()) {
                    GradientButton(text: "Next")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .withGradientBackground()
    }
    
    // Helper function to draw vector arrows
    func drawVector(context: GraphicsContext, start: CGPoint, end: CGPoint, color: Color) {
        // Draw main vector line
        context.stroke(
            Path { path in
                path.move(to: start)
                path.addLine(to: end)
            },
            with: .color(color),
            lineWidth: 2
        )
        
        // Draw arrowhead
        context.fill(
            Path { path in
                let arrowheadSize: CGFloat = 10
                let angle = atan2(end.y - start.y, end.x - start.x)
                
                path.move(to: end)
                path.addLine(to: CGPoint(
                    x: end.x - arrowheadSize * cos(angle + .pi / 6),
                    y: end.y - arrowheadSize * sin(angle + .pi / 6)
                ))
                path.addLine(to: CGPoint(
                    x: end.x - arrowheadSize * cos(angle - .pi / 6),
                    y: end.y - arrowheadSize * sin(angle - .pi / 6)
                ))
                path.closeSubpath()
            },
            with: .color(color)
        )
    }
}

#Preview {
    VectorMathPlaygroundView()
}
