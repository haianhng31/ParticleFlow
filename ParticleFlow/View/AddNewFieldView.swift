//
//  AddNewFieldView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 12/2/24.
//

import SwiftUI
import SpriteKit

struct AddNewFieldView: View {
    @State private var dxFormula: String = "center.x / distance"
    @State private var dyFormula: String = "center.y / distance"
    @State private var fieldStrength: Double = 1.0
    @State private var showCustomField: Bool = false
    @StateObject private var sceneWrapper = SceneWrapper()
    @State private var showInstructions: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Custom Vector Field")
                    .withGradientTitle(size: 30)
                
                if !showCustomField {
                    VStack(spacing: 15) {
                        Text("Create Your Own Vector Field")
                            .font(.headline)
                        
                        Text("Design a custom vector field by defining dx and dy formulas.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        
                        Button(action: { showInstructions.toggle() }) {
                            Label("View Instructions", systemImage: "info.circle")
                        }
                        .padding(.bottom)
                        
                        Button("Start Designing") {
                            withAnimation {
                                showCustomField = true
                            }
                        }
//                        .buttonStyle(GradientButtonStyle())
                    }
                    .padding()
                } else {
                    VStack(spacing: 15) {
                        SpriteView(scene: sceneWrapper.scene)
                            .frame(width: 400, height: 400)
                            .cornerRadius(10)
                            .border(Color.gray, width: 1)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("dx Formula:")
                            TextField("Enter dx formula", text: $dxFormula)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Text("dy Formula:")
                            TextField("Enter dy formula", text: $dyFormula)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Text("Field Strength: \(String(format: "%.1f", fieldStrength))")
                            Slider(value: $fieldStrength, in: 0.1...5.0, step: 0.1)
                        }
                        .padding()
                        
                        GradientButton(text: "Apply Custom Field")
                            .onTapGesture {
                                applyCustomField()
                            }
                    }
                    
                    NavigationLink(destination: InteractiveFieldView()) {
                        GradientButton(text: "Next")
                            .frame(width: 150)
                    }
                }
                
                if showInstructions {
                    instructionsView
                }
            }
            .padding()
        }
        .withGradientBackground()
        .navigationTitle("Custom Vector Field")
        .toolbar {
            Button("Reset") {
                showCustomField = false
                dxFormula = "center.x / distance"
                dyFormula = "center.y / distance"
                fieldStrength = 1.0
                showInstructions = false
            }
        }
    }
    
    var instructionsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Vector Field Formula Instructions")
                .font(.headline)
            
            Text("Create your vector field using these variables:")
            
            Group {
                Text("• `center.x`: Horizontal distance from center")
                Text("• `center.y`: Vertical distance from center")
                Text("• `distance`: Euclidean distance from center")
            }
            .foregroundColor(.secondary)
            
            Text("\nExample Formulas:")
                .font(.subheadline)
            
            Group {
                Text("• Radial Outward: dx = center.x / distance, dy = center.y / distance")
                Text("• Circular Motion: dx = -center.y / distance, dy = center.x / distance")
                Text("• Diagonal Sweep: dx = sin(center.x), dy = cos(center.y)")
            }
            .foregroundColor(.blue)
            
            Text("\nNotes:")
                .font(.subheadline)
            
            Group {
                Text("• Use basic math operations (+, -, *, /)")
                Text("• Trigonometric functions like sin(), cos() are supported")
                Text("• Field strength will scale the final vector")
            }
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
    
    func applyCustomField() {
        sceneWrapper.scene.setFieldType(.custom(dx: dxFormula, dy: dyFormula))
        sceneWrapper.scene.fieldStrength = fieldStrength
        sceneWrapper.scene.initializeParticles()
    }
}


#Preview {
    AddNewFieldView()
}
