//
//  StartView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 01.08.24.
//

import SwiftUI
import Combine

struct StartView: View {
    
    @StateObject var viewModel = ActivityViewModel()
    
     @State private var animated = false
    @State private var changeColors = false
    
    // Aktuelles Datum generieren
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d. MMMM yyyy"
        return formatter
    }()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                MeshGradient(
                    width: 3,
                    height: 3,
                    points: [
                        [0.0, 0.0], [0.5, animated ? 0.0 : 0.0], [1.0, 0.0],
                        [0.0, animated ? 0.0 : 0.5], [0.0, 0.3], [1.0, animated ? 0.7 : 0.5],
                        [0.0, 1.0], [1.0, animated ? 1.0 : 1.0], [1.0, 1.0]
                    ],
                    colors: [
                        .purple, .green, .purple,
                        .purple, .orange, .green,
                        .green, .yellow, .purple
                    ]
                )
                .ignoresSafeArea(edges: .top)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 10).repeatForever(autoreverses: false)) {
                        animated.toggle()
                    }
                }
                
//                LinearGradient(
//                    gradient: Gradient(colors: changeColors ? [Color.green, Color.orange] : [Color.orange, Color.green]),
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
//                .edgesIgnoringSafeArea(.top)
//                .onAppear {
//                    withAnimation(Animation.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
//                        changeColors.toggle()
//                    }
//                }
                
                VStack {
                    
                    Image("pb-logo-neu-fff")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                    
                    Text(dateFormatter.string(from: Date()))
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                    
                    
                    Text("Take a deep breath, no need to worry. Let's plan your day together.")
                        .font(.custom("Supreme Variable", size: 30))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                        .padding(.horizontal, 40)
                    
                    Divider()
                        .frame(height: 2)
                        .background(Color.white)
                        .padding(.horizontal, 20)
                        .padding()
                    
                    ForEach(viewModel.affirmations, id: \.self) { affirmation in
                        Text(affirmation.quote)
                            .font(.system(size: 20, weight: .medium))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.purple, lineWidth: 2))
                            .foregroundColor(.purple)
                            .padding()
                    }
                    
                    Text("Don't hesitate, go to the waiting room and check in.")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                    
                    
                    
                }
            }
            .onAppear {
                Task {
                    try await viewModel.load()
                }
            }
        }
    }
}

#Preview {
    StartView()
}
