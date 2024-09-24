//
//  CheckInView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 11.09.24.
//

import SwiftUI

struct CheckInView: View {
    
    @StateObject var viewModel = ActivityViewModel()
    
    @State private var mood: String = "Medium"
    @State private var drive: String = "Medium"
    
    @State private var showMoodPicker = false  // Steuert, ob das Mood Picker Sheet angezeigt wird
    @State private var showDrivePicker = false  // Steuert, ob das Drive Picker Sheet angezeigt wird
    
    let moods = ["Very Good", "Bad", "Medium", "Good", "Very Bad"]
    let drives = ["Very Low", "Low", "Medium", "High", "Very High"]
    
    var body: some View {
        NavigationStack {
            Text("How do you feel today?")
                .font(.title)
                
            VStack {
                // Kleiner Mood Picker (als Button dargestellt)
                Section(header: Text("HOW IS YOUR MOOD?")) {
                    Button(action: {
                        showMoodPicker.toggle()
                    }) {
                        HStack {
                            Text("Mood:")
                            Spacer()
                            Text(mood)  // Aktueller Mood-Wert
                                .foregroundColor(.gray)
                        }
                        .padding()
                    }
                    .sheet(isPresented: $showMoodPicker) {
                        // Vollbild Picker für Stimmung
                        VStack {
                            Text("Select your Mood")
                                .font(.headline)
                                .padding()
                            Picker("Mood", selection: $mood) {
                                ForEach(moods, id: \.self) {
                                    Text($0)
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(WheelPickerStyle())
                            Button("Done") {
                                showMoodPicker = false
                            }
                            .padding()
                        }
                    }
                }
                
                // Kleiner Drive Picker (als Button dargestellt)
                Section(header: Text("HOW IS YOUR DRIVE?")) {
                    Button(action: {
                        showDrivePicker.toggle()
                    }) {
                        HStack {
                            Text("Drive:")
                            Spacer()
                            Text(drive)  // Aktueller Drive-Wert
                                .foregroundColor(.gray)
                        }
                        .padding()
                    }
                    .sheet(isPresented: $showDrivePicker) {
                        // Vollbild Picker für Antrieb
                        VStack {
                            Text("Select your Drive")
                                .font(.headline)
                                .padding()
                            Picker("Drive", selection: $drive) {
                                ForEach(drives, id: \.self) {
                                    Text($0)
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(WheelPickerStyle())
                            Button("Done") {
                                showDrivePicker = false
                            }
                            .padding()
                        }
                    }
                }
            }
            
            
            NavigationLink(destination: ActivityListView(activities: viewModel.suggestActivities(for: mood, and: drive))) {
                Text("Suggest Activities")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Check In")
    }
}


#Preview {
    CheckInView()
}
