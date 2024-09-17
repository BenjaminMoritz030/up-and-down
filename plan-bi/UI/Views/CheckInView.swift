//
//  CheckInView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 11.09.24.
//

import SwiftUI

struct CheckInView: View {
    @StateObject var viewModel = ActivityViewModel()
    
    @State private var mood: String = "Neutral"
    @State private var drive: String = "Mittel"
    
    let moods = ["Sehr schlecht", "Schlecht", "Neutral", "Gut", "Sehr gut"]
    let drives = ["Sehr niedrig", "Niedrig", "Mittel", "Hoch", "Sehr hoch"]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Wie fühlst du dich?")
                    .font(.title)
                    .padding()
                
                Picker("Stimmung", selection: $mood) {
                    ForEach(moods, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding()
                
                Picker("Antrieb", selection: $drive) {
                    ForEach(drives, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding()
                
                NavigationLink(destination: ActivitySuggestionView(mood: mood, drive: drive)) {
                    Text("Vorschläge anzeigen")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Check-In")
        }
    }
}

#Preview {
    CheckInView()
}
