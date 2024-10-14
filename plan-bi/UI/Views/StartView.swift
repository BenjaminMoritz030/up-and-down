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
    
    var body: some View {
        NavigationStack {
            ZStack {
                MeshGradient(
                    width: 3,
                    height: 3,
                    points: [
                        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                        [0.0, 0.2], [0.0, 0.0], [1.0, 0.0], [1.0, 0.5],
                        [0.0, 1.0], [1.0, 1.0], [1.0, 1.0]
                    ],
                    colors: [
                        .purple, .green, .purple,
                        .purple, .orange, .green,
                        .green, .yellow, .purple
                    ]
                )
                .edgesIgnoringSafeArea(.top)
                
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
                                    .stroke(Color.white, lineWidth: 2))
                            .foregroundColor(.white)
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
        }
        .onAppear {
            Task {
                try await viewModel.load()
            }
        }
    }
        
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d. MMMM yyyy"
        return formatter
    }()

#Preview {
    StartView()
}
