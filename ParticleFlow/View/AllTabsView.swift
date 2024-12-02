//
//  AllTabsView.swift
//  ParticleFlow
//
//  Created by Hải Anh Nguyễn on 11/9/24.
//

import SwiftUI

struct AllTabsView: View {
    @State private var selectedTab = 0
    @State private var scene: ParticleScene?
    
    @State private var currentColorIndex = 0
    let colors: [UIColor] = [.blue, .red, .green, .yellow, .purple]
     
    var body: some View {
        TabView(selection: $selectedTab) {
            VectorMathPlaygroundView()
                .tabItem {
                    Label("Vector", systemImage: "1.circle")
                }
                .tag(0)
            
            BasicsView()
                .tabItem {
                    Label("Basics", systemImage: "2.circle")
                }
                .tag(1)
            
            PresetFieldsView()
                .tabItem {
                    Label("Presets", systemImage: "3.circle")
                }
                .tag(2)
            
            AddNewFieldView()
                .tabItem {
                    Label("New Field", systemImage: "4.circle")
                }
                .tag(3)
            
            InteractiveFieldView()
                .tabItem {
                    Label("Interactive", systemImage: "5.circle")
                }
                .tag(5)
        }
    }
}

#Preview {
    AllTabsView()
}
