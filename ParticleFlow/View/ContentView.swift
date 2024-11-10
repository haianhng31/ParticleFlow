//
//  ContentView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ParticlesView()
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    Text("Discover the Hidden Forces")
                        .withGradientTitle(size: 36)
                        .shadow(color: .blue.opacity(0.5), radius: 10)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : 20)
                    
                    Text("Shaping Our World")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(.secondary)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : 20)
                    
                    Spacer()
                    
                    Text("Ready to explore the fascinating world of vector fields?")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .opacity(isAnimating ? 1 : 0)
                    
                    Spacer()
                    
                    NavigationLink(destination: IntroView()) {
                        GradientButton(text: "Begin Journey")
                            .frame(width: 200, height: 50)
                    }
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    
                    Spacer()
                }
                .padding()
            }
            .withGradientBackground()
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1)) {
                isAnimating = true
            }
        }
    }
}

#Preview {
    ContentView()
}
