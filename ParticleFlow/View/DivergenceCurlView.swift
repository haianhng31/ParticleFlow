//
//  DivergenceCurlView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 2/5/25.
//

import SwiftUI
import SpriteKit

struct DivergenceCurlView: View {
    @State private var divergence: Double = 0.0
    @State private var curl: Double = 0.0
    @StateObject private var sceneWrapper = SceneWrapper()
    
    func updateScene() {
        sceneWrapper.scene.divergence = divergence
        sceneWrapper.scene.curl = curl
        sceneWrapper.scene.initializeParticles()
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Divergence and Curl Visualization")
                    .withGradientTitle(size: 30)
                
                SpriteView(scene: sceneWrapper.scene)
                    .frame(width: 400, height: 400)
                    .cornerRadius(10)
                    .border(Color.gray, width: 1)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Divergence: \(String(format: "%.3f", divergence))")
                        .font(.headline)
                    Slider(value: $divergence, in: -0.01...0.01, step: 0.001)
                    
                    Text("Curl: \(String(format: "%.3f", curl))")
                        .font(.headline)
                    Slider(value: $curl, in: -0.01...0.01, step: 0.001)
                }
                .padding()
    
                Text("Adjust the divergence and curl values to see how the vector field changes. Divergence affects how much the field spreads out, while curl affects the rotation.")
                    .padding(.horizontal)
                    .foregroundColor(.secondary)
                
                NavigationLink(destination: PresetFieldsView()) {
                    GradientButton(text: "Next")
                        .frame(width: 150)
                }
            }
            .onChange(of: divergence, updateScene)
            .onChange(of: curl, updateScene)
            .onAppear{
                updateScene()
            }
            .padding()
        }
        .withGradientBackground()
    }
}

#Preview {
    DivergenceCurlView()
}
