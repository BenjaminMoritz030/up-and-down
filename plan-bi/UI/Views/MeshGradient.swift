//
//  MeshGradient.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 14.10.24.
//

import SwiftUI

struct AnimatedMeshView: View {
    @State var t: Float = 0.0
    @State var timer: Timer?
    
    var body: some View {
        MeshGradient(width: 3, height: 3, points: [

            .init(0, 0), .init(0.5, 0), .init(1, 0),
            [sinInRange(-0.50...0.0, offset: 0.439, timeScale: 0.342, t: t),
            sinInRange(0.3...0.7, offset: 3.42, timeScale: 0.984, t: t)],
            [sinInRange(0.0...1.0, offset: 0.239, timeScale: 0.084, t: t),
            sinInRange(0.3...0.7, offset: 5.21, timeScale: 0.242, t: t)],
            [sinInRange(1.0...1.8, offset: 0.939, timeScale: 0.772, t: t),
            sinInRange(0.3...0.7, offset: 0.47, timeScale: 0.342, t: t)],
            [0, 1],
            [0.5, 1],
            [1, 1]
        ], colors: [
            .red, .purple, .indigo,
            .orange, .purple, .blue,
            .yellow, .pink, .mint
        ])
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) {
                _ in t += 0.02
            }
        }
        .ignoresSafeArea(edges: .top)
    }
    
    func sinInRange(_ range: ClosedRange<Float>, offset: Float, timeScale: Float, t: Float) -> Float {
        let amplitude = (range.upperBound - range.lowerBound) / 2
        let midPoint = (range.upperBound + range.lowerBound) / 2
        return midPoint + amplitude * sin(timeScale * t + offset)
    }
}

#Preview {
  AnimatedMeshView()
}
