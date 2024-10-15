//
//  MeshGradient.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 14.10.24.
//

//import SwiftUI
//
//struct MeshView: View {
//    @State var t: Float = 0.0
//    @State var timer: Timer?
//    
//    var body: some View {
//        MeshGradient(width: 3, height: 3, points: [
//
//            .init(0, 0), .init(0.5, 0), .init(1, 0),
//            [sinInRange(-0.8...0.2, offset: 0.439, timeScale: 0.342, t: t)],
//            [sinInRange(0.3...0.7, offset: 3.42, timeScale: 0.984, t: t)],
//            [sinInRange(-0.6...0.6, offset: 0.239, timeScale: 0.084, t: t)],
//            [sinInRange(0.8...0.8, offset: 5.21, timeScale: 0.242, t: t)],
//            [sinInRange(-1.2...1.2, offset: 0.939, timeScale: 0.772, t: t)],
//            [sinInRange(1.3...1.7, offset: 0.47, timeScale: 0.342, t: t)]
//        ], colors: [
//            .red, .purple, .indigo,
//            .orange, .white, .blue,
//            .yellow, .black, .mint
//        ])
//        .onAppear {
//            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {
//                _ in t += 0.02
//            }
//        }
//        .background(.black)
//        .ignoresSafeArea(.top)
//    }
//    
//    func sinInRange(_ range: ClosedRange<Float>, offset: Float, timeScale: Float, t: Float) -> Float {
//        let amplitude = (range.upperBound - range.lowerBound) / 2
//        let midPoint = (range.upperBound + range.lowerBound) / 2
//        return midPoint + amplitude * sin(timeScale * t + offset)
//    }
//}
//
//struct MeshView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeshView()
//    }
//}

