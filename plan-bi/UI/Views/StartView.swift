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
                VStack {

                    Image("pb-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)

                    
                    Text("Up and Down")
                        .font(.system(size: 30, weight: .bold))
                    
                    Text(dateFormatter.string(from: Date()))
                    // Aktuelles Datum anzeigen
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.gray)
                        .padding()
                    
                    NavigationLink(destination: CheckInView()) {
                        Text("Check In")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 250)
            }
        }
    }
}

#Preview {
    StartView()
}
