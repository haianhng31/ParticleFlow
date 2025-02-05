//
//  FieldAnomaliesObstaclesView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 2/5/25.
//

import SwiftUI
import SpriteKit

struct FieldAnomaliesObstaclesView: View {
    @State private var obstaclePosition: CGPoint = CGPoint(x: 200, y: 200)
    @State private var anomalyStrength: Double = 1.0
    @StateObject private var sceneWrapper = SceneWrapper()
    
    func updateScene() {
        sceneWrapper.scene.anomalyStrength = anomalyStrength
        sceneWrapper.scene.initializeParticles()
        sceneWrapper.scene.initializeObstacle()
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Field Anomalies and Obstacles")
                    .withGradientTitle(size: 30)
                
                SpriteView(scene: sceneWrapper.scene)
                    .frame(width: 400, height: 400)
                    .cornerRadius(10)
                    .border(Color.gray, width: 1)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let location = value.location
                                let sceneLocation = CGPoint(
                                    x: location.x,
                                    y: 400 - location.y // Flip y-axis for SpriteKit
                                )
                                obstaclePosition = sceneLocation
                                sceneWrapper.scene.obstaclePosition = obstaclePosition
                            }
                    )
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Anomaly Strength: \(String(format: "%.1f", anomalyStrength))")
                        .font(.headline)
                    Slider(value: $anomalyStrength, in: 0.1...5.0, step: 0.1)
                }
                .padding()
                
                Text("Drag to place an obstacle and adjust the anomaly strength to see how particles navigate around it.")
                    .padding(.horizontal)
                    .foregroundColor(.secondary)
                
//                NavigationLink(destination: FinalConclusion()) {
//                    GradientButton(text: "Next")
//                        .frame(width: 150)
//                }
            }
            .onChange(of: anomalyStrength, updateScene)
            .onAppear {
                updateScene()
                sceneWrapper.scene.isHavingObstacle = true
            }
            .onDisappear {
                sceneWrapper.scene.isHavingObstacle = false
            }
            .padding()
        }
        .withGradientBackground()
    }
}

#Preview {
    FieldAnomaliesObstaclesView()
}
