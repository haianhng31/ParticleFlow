//
//  GradientButton.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/10/24.
//

import SwiftUI

struct GradientButton: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.headline)
            Image(systemName: "arrow.right.circle.fill")
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(
            LinearGradient(
                colors: [.blue, .purple],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(radius: 10)
    }
}

#Preview {
    GradientButton(text: "Preview Button")
}
