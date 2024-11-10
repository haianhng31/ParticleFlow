//
//  IntroView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/10/24.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                // Card view for main explanation
                ExplanationCard(
                    title: "What are Vector Fields?",
                    content: "Vector fields are fundamental patterns of force and motion that surround us everywhere. Imagine standing in a flowing river - at each point, the water moves with a specific speed and direction.",
                    iconName: "arrow.up.and.down.and.arrow.left.and.right"
                )
                
                // Interactive features preview
                FeaturesGrid()
                
                // Navigation button
                NavigationLink(destination: BasicsView()) {
                    GradientButton(text: "Start Exploring")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .withGradientBackground()
    }
}

struct FeaturesGrid: View {
    let features = [
        ("Field Strength", "gauge.with.dots.needle.50percent", "Observe how particles respond to different field strengths"),
        ("Experiments", "arrow.triangle.2.circlepath", "Try different field types found in nature"),
        ("Interactive", "hand.tap", "Create your own fields through touch")
    ]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
            ForEach(features, id: \.0) { feature in
                VStack(spacing: 10) {
                    Image(systemName: feature.1)
                        .font(.title)
                        .foregroundColor(.blue)
                    Text(feature.0)
                        .font(.headline)
                    Text(feature.2)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
    }
}

#Preview {
    IntroView()
}
