//
//  VectorFieldVisualizationView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 12/2/24.
//

import SwiftUI

struct VectorFieldVisualizationView: View {
    @State private var selectedFieldType: FieldType = .vortex
    @State private var fieldStrength: Double = 1.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Vector Field Visualization")
                    .withGradientTitle(size: 30)
                
                // Custom vector field visualization canvas
                GeometryReader { geometry in
                    Canvas { context, size in
                        let gridSize = 20
                        let cellWidth = size.width / CGFloat(gridSize)
                        let cellHeight = size.height / CGFloat(gridSize)
                        
                        for x in 0..<gridSize {
                            for y in 0..<gridSize {
                                let point = CGPoint(
                                    x: CGFloat(x) * cellWidth + cellWidth / 2,
                                    y: CGFloat(y) * cellHeight + cellHeight / 2
                                )
                                
                                // Calculate force for the current point
                                let force = selectedFieldType.calculateForce(
                                    at: point,
                                    strength: CGFloat(fieldStrength)
                                )
                                
                                // Draw vector arrow
                                drawVectorArrow(
                                    context: context,
                                    point: point,
                                    vector: force,
                                    cellWidth: cellWidth
                                )
                            }
                        }
                    }
                    .frame(height: geometry.size.width) // Make it square
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                }
                .aspectRatio(1, contentMode: .fit)
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Field Type:")
                        .font(.headline)
                    Picker("Field Type", selection: $selectedFieldType) {
                        Text("Vortex").tag(FieldType.vortex)
                        Text("Sink").tag(FieldType.sink)
                        Text("Source").tag(FieldType.source)
                        Text("Gravitational").tag(FieldType.gravitational)
                        Text("Wave").tag(FieldType.wave)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("Field Strength: \(String(format: "%.1f", fieldStrength))")
                        .font(.headline)
                    Slider(value: $fieldStrength, in: 0.1...5.0, step: 0.1)
                }
                .padding()
                
                Text("This visualization shows the direction and magnitude of forces in different vector fields. Arrows indicate the direction and length of force at each point.")
                    .padding(.horizontal)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .withGradientBackground()
    }
    
    // Helper function to draw vector arrows
    func drawVectorArrow(context: GraphicsContext, point: CGPoint, vector: CGVector, cellWidth: CGFloat) {
        let arrowLength = min(sqrt(vector.dx * vector.dx + vector.dy * vector.dy), cellWidth)
        let normalizedVector = vector.dx == 0 && vector.dy == 0 ? .zero :
            CGVector(dx: vector.dx / sqrt(vector.dx * vector.dx + vector.dy * vector.dy),
                     dy: vector.dy / sqrt(vector.dx * vector.dx + vector.dy * vector.dy))
        
        let endPoint = CGPoint(
            x: point.x + normalizedVector.dx * arrowLength,
            y: point.y + normalizedVector.dy * arrowLength
        )
        
        // Draw main vector line
        context.stroke(
            Path { path in
                path.move(to: point)
                path.addLine(to: endPoint)
            },
            with: .color(.blue),
            lineWidth: 1
        )
        
        // Draw arrowhead
        context.fill(
            Path { path in
                let arrowheadSize: CGFloat = 5
                let angle = atan2(endPoint.y - point.y, endPoint.x - point.x)
                
                path.move(to: endPoint)
                path.addLine(to: CGPoint(
                    x: endPoint.x - arrowheadSize * cos(angle + .pi / 6),
                    y: endPoint.y - arrowheadSize * sin(angle + .pi / 6)
                ))
                path.addLine(to: CGPoint(
                    x: endPoint.x - arrowheadSize * cos(angle - .pi / 6),
                    y: endPoint.y - arrowheadSize * sin(angle - .pi / 6)
                ))
                path.closeSubpath()
            },
            with: .color(.blue)
        )
    }
}

#Preview {
    VectorFieldVisualizationView()
}
