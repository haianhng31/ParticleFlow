//
//  VRParticleFlowView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 12/2/24.
//

import SwiftUI
import ARKit
import RealityKit
import Combine

class VRParticleManager: ObservableObject {
    private var particles: [Entity] = []
    private var handTrackingSubscription: AnyCancellable?
    private var rootEntity: RealityKit.Entity?
    
    func setupParticleSystem(in worldScene: RealityKit.Scene) {
        // Create root entity for particle system
        let rootEntity = RealityKit.Entity()
        worldScene.addEntity(rootEntity)
        self.rootEntity = rootEntity
        
        // Create 100 particles
        for _ in 0..<100 {
            let particleEntity = createParticle()
            rootEntity.addChild(particleEntity)
            particles.append(particleEntity)
        }
    }
    
    func updateWithHandTransform(_ handTransform: simd_float4x4) {
        guard let rootEntity = rootEntity else { return }
        
        // Use the hand transform as the reference point
        let handPosition = handTransform.columns.3
        
        for particle in particles {
            // Calculate force based on hand position
            let particlePosition = particle.position(relativeTo: rootEntity)
            let distance = length(particlePosition - handPosition)
            
            // Simple force calculation similar to vector field
            let maxInfluenceDistance: Float = 0.2
            let normalizedDistance = min(distance / maxInfluenceDistance, 1.0)
            
            // Create a force vector that pulls particles towards or around the hand
            var force = normalize(handPosition - particlePosition)
            
            // Modify force based on distance
            force *= (1 - normalizedDistance)
            
            // Apply rotation to create a more interesting flow
            let rotationMatrix = float3x3(
                SIMD3(0, -1, 0),
                SIMD3(1, 0, 0),
                SIMD3(0, 0, 1)
            )
            force = rotationMatrix * force
            
            // Update particle position
            particle.position(relativeTo: rootEntity) += force * 0.01
            
            // Wrap around if particle goes too far
            if length(particle.position(relativeTo: rootEntity)) > 0.3 {
                particle.position(relativeTo: rootEntity) = SIMD3(
                    x: Float.random(in: -0.1...0.1),
                    y: Float.random(in: -0.1...0.1),
                    z: Float.random(in: -0.1...0.1)
                )
            }
        }
    }
    
    private func createParticle() -> RealityKit.ModelEntity {
        let mesh = MeshResource.generateSphere(radius: 0.005)
        let material = SimpleMaterial(color: .white, isMetallic: false)
        let particleEntity = ModelEntity(mesh: mesh, materials: [material])
        
        // Randomly distribute particles in a small volume
        particleEntity.position = SIMD3(
            x: Float.random(in: -0.1...0.1),
            y: Float.random(in: -0.1...0.1),
            z: Float.random(in: -0.1...0.1)
        )
        
        return particleEntity
    }
}

struct VRParticleFlowView: View {
    @StateObject private var particleManager = VRParticleManager()
    
    var body: some View {
        ZStack {
            RealityKitView(particleManager: particleManager)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("VR Particle Flow")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text("Move your hand to interact with particles")
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}

struct RealityKitView: UIViewRepresentable {
    let particleManager: VRParticleManager
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Setup scene
        let scene = RealityKit.Scene()
        arView.scene = scene
        
        // Setup particles
        particleManager.setupParticleSystem(in: scene)
        
        // Start AR session with hand tracking
        let configuration = ARWorldTrackingConfiguration()
        configuration.frameSemantics = .bodyDetection // Alternative to hand tracking
        arView.session.delegate = context.coordinator
        arView.session.run(configuration)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(particleManager: particleManager)
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        let particleManager: VRParticleManager
        
        init(particleManager: VRParticleManager) {
            self.particleManager = particleManager
        }
        
        func session(_ session: ARSession, didUpdate frame: ARFrame) {
            // Extract hand or body transforms
            // Note: This is a simplified example and may not work exactly as expected
            if let transform = frame.worldMappingStatus == .mapped ? frame.camera.transform : nil {
                DispatchQueue.main.async {
                    self.particleManager.updateWithHandTransform(transform)
                }
            }
        }
    }
}

#Preview {
    VRParticleFlowView()
}
