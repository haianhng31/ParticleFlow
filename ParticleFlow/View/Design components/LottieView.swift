//
//  LottieView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/10/24.
//

import SwiftUI

struct LottieView: View {
    @State private var scale: CGFloat = 1
    
    var body: some View {
        ZStack {
            ForEach(0..<3) { i in
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 2
                    )
                    .scaleEffect(scale)
                    .opacity(2 - scale)
                    .animation(
                        .easeInOut(duration: 2)
                        .repeatForever(autoreverses: false)
                        .delay(Double(i) * 0.5),
                        value: scale
                    )
            }
            
            Image(systemName: "star.fill")
                .font(.system(size: 50))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
        .onAppear {
            scale = 2
        }
    }
}

#Preview {
    LottieView()
}
