//
//  FinalConclusion.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/10/24.
//

import SwiftUI

struct FinalConclusion: View {
    @State private var isAnimating = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                LottieView()
                    .frame(height: 200)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                
                Text("Congratulations!")
                    .withGradientTitle(size: 36)
                    .shadow(color: .blue.opacity(0.5), radius: 10)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                
                Text("You've experienced how vector fields shape particle motion.")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                
//                // Key learnings section
//                VStack(alignment: .leading, spacing: 25) {
//                    Text("The patterns you created are similar to:")
//                        .font(.headline)
//                        .foregroundStyle(.secondary)
//                    
//                    KeyLearningCard(
//                        title: "Natural Phenomena",
//                        items: [
//                            "Air flow patterns in atmospheric science",
//                            "Ocean currents in marine biology",
//                            "Magnetic fields in physics"
//                        ],
//                        iconName: "leaf.fill"
//                    )
//                    
//                    KeyLearningCard(
//                        title: "Applications",
//                        items: [
//                            "Computer graphics and animation",
//                            "Fluid dynamics simulation",
//                            "Weather pattern prediction",
//                            "Particle system design"
//                        ],
//                        iconName: "gear"
//                    )
//                }
//                .opacity(isAnimating ? 1 : 0)
//                .offset(y: isAnimating ? 0 : 20)
//                
                ReminderCard(
                    text: "Remember: Every point in a vector field has both magnitude (strength) and direction, working together to create the beautiful patterns you've explored today."
                )
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 20)
                
                NavigationLink(destination: BasicsView()) {
                    GradientButton(text: "Experiment again")
                }
            }
            .padding()
        }
        .withGradientBackground()
        .onAppear {
            withAnimation(.easeOut(duration: 1)) {
                isAnimating = true
            }
        }
    }
}

#Preview {
    FinalConclusion()
}
