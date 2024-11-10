//
//  CardsView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/10/24.
//

import SwiftUI

struct ExplanationCard: View {
    let title: String
    let content: String
    let iconName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: iconName)
                    .font(.title)
                    .foregroundColor(.blue)
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            Text(content)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5)
    }
}

struct KeyLearningCard: View {
    let title: String
    let items: [String]
    let iconName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: iconName)
                    .font(.title2)
                    .foregroundColor(.blue)
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            
            ForEach(items, id: \.self) { item in
                HStack(alignment: .top) {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8))
                        .foregroundColor(.blue)
                        .padding(.top, 6)
                    Text(item)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5)
    }
}

struct ReminderCard: View {
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: "lightbulb.fill")
                .font(.title2)
                .foregroundColor(.yellow)
                .padding(.trailing, 5)
            
            Text(text)
                .font(.system(size: 18, weight: .light))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5)
    }
}
