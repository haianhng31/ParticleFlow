//
//  SceneWrapper.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/9/24.
//

import Foundation

class SceneWrapper: ObservableObject {
    let scene: ParticleScene
    
    init() {
        scene = ParticleScene(size: CGSize(width: 400, height: 400))
        scene.scaleMode = .fill
        scene.setFieldType(.vortex)
    }
}
