//
//  ParticlesView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/10/24.
//

import SwiftUI

struct ParticlesView: View {
    @State private var phase: CGFloat = 0
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let particleCount = 50
                let timeDate = timeline.date.timeIntervalSinceReferenceDate
                phase = timeDate.remainder(dividingBy: 2)
                
                for i in 0..<particleCount {
                    let position = CGPoint(
                        x: size.width * (0.2 + 0.6 * sin(Double(i) / Double(particleCount) * 2 * .pi + timeDate)),
                        y: size.height * (0.2 + 0.6 * cos(Double(i) / Double(particleCount) * 2 * .pi + timeDate))
                    )
                    
                    context.fill(
                        Circle().path(in: CGRect(x: position.x - 2, y: position.y - 2, width: 4, height: 4)),
                        with: .color(.blue.opacity(0.5))
                    )
                }
            }
        }
    }
}

#Preview {
    ParticlesView()
}
