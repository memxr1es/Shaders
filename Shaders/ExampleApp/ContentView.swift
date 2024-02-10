//
//  ContentView.swift
//  ExampleApp
//
//  Created by Никита Котов on 13.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var screenSize: CGSize = .zero
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            title
            HStack(spacing: 30) {
                ForEach(cards) { card in
                    CardView(card: card, screenSize: $screenSize)
                        .scrollTransition { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1 : 0.8)
                                .rotationEffect(Angle(degrees: phase.isIdentity ? 0 : -30))
                                .rotation3DEffect(Angle(degrees: phase.isIdentity ? 0 : 60), axis: (x: -1, y: 1, z: 0))
                                .blur(radius: phase.isIdentity ? 0 : 60)
                                .offset(x: phase.isIdentity ? 0 : -200)
                    }
                }
            }
//            .scrollTargetLayout()
            .padding(.bottom, 100)
        }
//        .scrollTargetBehavior(.viewAligned)
        .overlay(geometryReader)
    }
    
    var geometryReader: some View {
        GeometryReader { proxy in
            Color.clear
                .onAppear {
                    screenSize = proxy.size
                }
                .onChange(of: proxy.size) { oldValue, newValue in
                    screenSize = newValue
                }
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    private var title: some View {
        VStack(alignment: .leading) {
            Text("Explore")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("\(Date().formatted(date: .complete, time: .omitted))")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
    }
}

