//
//  PresetFieldsView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/9/24.
//

import SwiftUI
import SpriteKit

struct PresetFieldsView: View {
    @State private var selectedField: FieldType = .vortex
    @State private var fieldStrength: Double = 1.0
    @StateObject private var sceneWrapper = SceneWrapper()
    
    func updateScene() {
        sceneWrapper.scene.fieldStrength = fieldStrength
        sceneWrapper.scene.setFieldType(selectedField)
        sceneWrapper.scene.initializeParticles() // Reinitialize particles w/ new settings
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Preset Vector Fields")
                    .withGradientTitle(size: 30)
                
                SpriteView(scene: sceneWrapper.scene)
                    .frame(width: 400, height: 400)
                    .cornerRadius(10)
                    .border(Color.gray, width: 1)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Field Type:")
                        .font(.headline)
                    Picker("Field Type", selection: $selectedField) {
                        Text("Vortex").tag(FieldType.vortex)
                        Text("Sink").tag(FieldType.sink)
                        Text("Source").tag(FieldType.source)
                        Text("Gravitational").tag(FieldType.gravitational)
//                        Text("Wave").tag(FieldType.wave)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("Field Strength: \(String(format: "%.1f", fieldStrength))")
                        .font(.headline)
                    Slider(value: $fieldStrength, in: 0.1...5.0, step: 0.1)
                }
                .padding()
                
                fieldDescription
                    .padding(.horizontal)
                    .foregroundColor(.secondary)
                
                NavigationLink(destination: InteractiveFieldView()) {
                    GradientButton(text: "Next")
                        .frame(width: 150)
                }
            }
            .onChange(of: fieldStrength, updateScene)
            .onChange(of: selectedField, updateScene)
            .onAppear {
                updateScene()
            }
            .padding()
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
    
    var fieldDescription: some View {
        switch selectedField {
        case .vortex:
            return Text("Vortex field creates a circular motion around the center point. Particles rotate around the center with speed proportional to their distance.")
        case .sink:
            return Text("Sink field pulls particles toward the center point. The force increases as particles get closer to the center.")
        case .source:
            return Text("Source field pushes particles away from the center point. The force decreases with distance from the center.")
        case .gravitational:
            return Text("Gravitational field simulates gravity-like attraction. The force follows an inverse square law, becoming stronger as particles get closer.")
        case .wave:
            return Text("To be updated.")
        case .none:
            return Text("")
        }
    }
}

#Preview {
    PresetFieldsView()
}
