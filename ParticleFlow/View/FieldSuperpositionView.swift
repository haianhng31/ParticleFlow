//
//  FieldSuperpositionView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 2/5/25.
//

import SwiftUI
import SpriteKit

struct FieldSuperpositionView: View {
    @State private var field1Strength: Double = 1.0
    @State private var field2Strength: Double = 1.0
    @StateObject private var sceneWrapper = SceneWrapper()
    
    func updateScene() {
        sceneWrapper.scene.field1Strength = field1Strength
        sceneWrapper.scene.field2Strength = field2Strength
        sceneWrapper.scene.initializeParticles()
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Field Superposition")
                    .withGradientTitle(size: 30)
                
                SpriteView(scene: sceneWrapper.scene)
                    .frame(width: 400, height: 400)
                    .cornerRadius(10)
                    .border(Color.gray, width: 1)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Field 1 (Vortex) Strength: \(String(format: "%.1f", field1Strength))")
                        .font(.headline)
                    Slider(value: $field1Strength, in: 0.1...5.0, step: 0.1)
                    
                    Text("Field 2 (Sink) Strength: \(String(format: "%.1f", field2Strength))")
                        .font(.headline)
                    Slider(value: $field2Strength, in: 0.1...5.0, step: 0.1)
                }
                .padding()
                
                Text("Adjust the strength of each field to see how they combine. The resulting field is the sum of the individual fields.")
                    .padding(.horizontal)
                    .foregroundColor(.secondary)
                
//                NavigationLink(destination: FieldAnomaliesObstaclesView()) {
//                    GradientButton(text: "Next")
//                        .frame(width: 150)
//                }
            }
            .onChange(of: field1Strength, updateScene)
            .onChange(of: field2Strength, updateScene)
            .onAppear {
                sceneWrapper.scene.isFieldSuperposition = true
                updateScene()
            }
            .onDisappear {
                sceneWrapper.scene.isFieldSuperposition = false
            }
            .padding()
        }
        .withGradientBackground()
    }
}

#Preview {
    FieldSuperpositionView()
}
