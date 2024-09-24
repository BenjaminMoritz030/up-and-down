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
    
    @State private var showMoodPicker = false
    @State private var showDrivePicker = false
    
    let moods = ["Very Good", "Bad", "Medium", "Good", "Very Bad"]
    let drives = ["Very Low", "Low", "Medium", "High", "Very High"]
    
    var body: some View {
        NavigationStack {
            Text("How do you feel today?")
                .font(.system(size: 30, weight: .bold))
                .padding()
                
            VStack(alignment: .leading, spacing: 20) {
                Section(header: Text("HOW IS YOUR MOOD?")) {
                    Button(action: {
                        showMoodPicker.toggle()
                    }) {
                        HStack {
                            Text("Mood:")
                            Spacer()
                            Text(mood)
                                .foregroundColor(.gray)
                        }
                    }
                    .sheet(isPresented: $showMoodPicker) {
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
                
                Section(header: Text("HOW IS YOUR DRIVE?")) {
                    Button(action: {
                        showDrivePicker.toggle()
                    }) {
                        HStack {
                            Text("Drive:")
                            Spacer()
                            Text(drive)
                                .foregroundColor(.gray)
                        }
                    }
                    .sheet(isPresented: $showDrivePicker) {
                        
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
            .padding(.top, 50)
        }
        .navigationTitle("Check In")
        .padding()
    }
}


#Preview {
    CheckInView()
}
