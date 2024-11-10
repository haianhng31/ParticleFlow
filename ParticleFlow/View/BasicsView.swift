//
//  BasicsView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/9/24.
//

import SwiftUI
import SpriteKit

struct BasicsView: View {
    @State private var particleCount: Double = 100
    @State private var fieldStrength: Double = 1.0
    @StateObject private var sceneWrapper = SceneWrapper()
    
    func updateScene() {
        sceneWrapper.scene.particleCount = Int(particleCount)
        sceneWrapper.scene.fieldStrength = fieldStrength
        sceneWrapper.scene.initializeParticles() // Reinitialize particles w/ new settings
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Vector Field Basics")
                    .withGradientTitle(size: 30)
                
                SpriteView(scene: sceneWrapper.scene, options: [.allowsTransparency])
                    .frame(width: 400, height: 400)
                    .cornerRadius(10)
                    .border(Color.gray, width: 1)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Particle Count: \(Int(particleCount))")
                        .font(.headline)
                    Slider(value: $particleCount, in: 10...500, step: 10)
                    
                    Text("Field Strength: \(String(format: "%.1f", fieldStrength))")
                        .font(.headline)
                    Slider(value: $fieldStrength, in: 0.1...5.0, step: 0.1)
                }
                .padding()
                
                Text("This demonstrates a basic vortex field where particles move in circular patterns. The strength affects how quickly they rotate, while the particle count shows how the field affects multiple points simultaneously.")
                    .padding(.horizontal)
                    .foregroundColor(.secondary)
                
                NavigationLink(destination: PresetFieldsView()) {
                    GradientButton(text: "Next")
                        .frame(width: 150)
                }
                .padding(.vertical)
            }
            .onChange(of: particleCount, updateScene)
            .onChange(of: fieldStrength, updateScene)
            .padding()
            .onAppear {
                updateScene()
            }
        }
        .withGradientBackground()
        .toolbar {
            Button("Change particle color") {
                sceneWrapper.scene.changeParticleColor(to:
                    sceneWrapper.scene.particleColor == .white ? .blue : .white
                )
            }
        }
    }
}

#Preview {
    BasicsView()
}
