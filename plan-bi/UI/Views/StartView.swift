//
//  StartView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 01.08.24.
//

import SwiftUI

struct StartView: View {
    // Aktuelles Datum generieren
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d. MMMM yyyy"
        return formatter
    }()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                RadialGradient(gradient: Gradient(colors: [Color.yellow, Color.purple]), center: .center, startRadius: 20, endRadius: 800)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Image("pb-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                    
                    Text(dateFormatter.string(from: Date()))
                    // Aktuelles Datum anzeigen
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                    
                    
                    Text("Take a deep breath, no need to worry. Let's plan your day together.")
                        .font(.system(size: 30, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.bottom, 50)
                        .padding(.horizontal, 40)
                    
                    Text("Affirmation here ...")
                        .font(.system(size: 20, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.cyan, lineWidth: 2))
                        .padding(.horizontal, 40)
                        .foregroundColor(.cyan)
                    
                    
                    
                    VStack{
                        
                        NavigationLink(destination: CheckInView()) {
                            Text("Check In")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.cyan)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 280)
                }
            }
        }
    }
}

#Preview {
    StartView()
}
