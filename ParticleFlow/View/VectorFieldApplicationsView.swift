//
//  VectorFieldApplicationsView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 12/2/24.
//

import SwiftUI

struct VectorFieldApplicationsView: View {
    let applications = [
        Application(
            title: "Fluid Dynamics",
            description: "Vector fields describe fluid flow, helping predict water currents, air movements, and wind patterns.",
            icon: "wind",
            exampleScenario: "Predicting ocean currents or tracking hurricane paths"
        ),
        Application(
            title: "Electromagnetic Fields",
            description: "Electric and magnetic fields are represented as vector fields, crucial in understanding electromagnetic interactions.",
            icon: "bolt",
            exampleScenario: "Designing electrical circuits and understanding charge distribution"
        ),
        Application(
            title: "Gravitational Fields",
            description: "Gravitational force can be modeled as a vector field, showing how massive objects influence space around them.",
            icon: "circle.dashed",
            exampleScenario: "Calculating spacecraft trajectories and planetary orbits"
        ),
        Application(
            title: "Weather Modeling",
            description: "Meteorologists use vector fields to represent wind direction, temperature gradients, and pressure systems.",
            icon: "cloud",
            exampleScenario: "Predicting storm movements and atmospheric conditions"
        ),
        Application(
            title: "Computer Graphics",
            description: "Vector fields are used in particle systems, fluid simulations, and special effects in video games and movies.",
            icon: "desktopcomputer",
            exampleScenario: "Creating realistic smoke, fire, and water animations"
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Vector Fields in the Real World")
                    .withGradientTitle(size: 30)
                
                Text("Vector fields are not just mathematical abstractions—they're fundamental to understanding complex systems in various fields.")
                    .padding()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                
                ForEach(applications, id: \.title) { application in
                    ApplicationCard(application: application)
                }
                
                Spacer()
                
                NavigationLink(destination: FinalConclusion()) {
                    GradientButton(text: "Next")
                        .frame(width: 150)
                }
            }
            .padding()
        }
        .withGradientBackground()
    }
}

struct Application {
    let title: String
    let description: String
    let icon: String
    let exampleScenario: String
}

struct ApplicationCard: View {
    let application: Application
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: application.icon)
                    .foregroundColor(.blue)
                    .font(.system(size: 30))
                
                VStack(alignment: .leading) {
                    Text(application.title)
                        .font(.headline)
                    Text("Real-World Application")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(10)
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 10) {
                    Text(application.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.blue)
                        Text("Example Scenario:")
                            .font(.headline)
                    }
                    
                    Text(application.exampleScenario)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.white.opacity(0.05))
                .cornerRadius(10)
                .transition(.asymmetric(insertion: .scale.combined(with: .opacity),
                                        removal: .scale.combined(with: .opacity)))
            }
        }
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.05))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
        .padding(.vertical, 5)
    }
}

#Preview {
    VectorFieldApplicationsView()
}
