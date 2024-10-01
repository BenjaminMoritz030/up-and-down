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
    
    @State private var changeColors = false
    // Aktuelles Datum generieren
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d. MMMM yyyy"
        return formatter
    }()
    
    private let timer = Timer.publish(every: 6, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                LinearGradient(
                    gradient: Gradient(colors: changeColors ? [ Color.green, Color.orange] : [Color.purple, Color.yellow]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .onReceive(timer) { _ in
                    withAnimation(.easeInOut(duration: 3)) {
                        changeColors.toggle()
                    }
                }
                .edgesIgnoringSafeArea(.top)
                
                
                VStack {
                    
                    Image("pb-logo-neu-fff")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                    
                    //                    Divider()
                    //                        .frame(height: 2)
                    //                        .background(Color.white)
                    //                        .padding(.horizontal, 20)
                    
                    Text(dateFormatter.string(from: Date()))
                    // Aktuelles Datum anzeigen
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
