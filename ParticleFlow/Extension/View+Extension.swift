//
//  View+Extension.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/9/24.
//

import SwiftUI

struct ThemeBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                colors: [.blue.opacity(0.1), .purple.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            content
        }
    }
}

extension View {
    func withGradientBackground() -> some View {
        modifier(ThemeBackgroundModifier())
    }
    
    func withGradientTitle(size: CGFloat) -> some View {
        self
            .font(.system(size: size, weight: .bold, design: .rounded))
            .foregroundStyle(
                LinearGradient(
                    colors: [.blue, .purple],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .multilineTextAlignment(.center)
    }
}
