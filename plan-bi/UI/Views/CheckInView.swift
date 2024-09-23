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
    
    let moods = ["Very Good", "Bad", "Medium", "Good", "Very Bad"]
    let drives = ["Very Low", "Low", "Medium", "High", "Very High"]
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Text("How do you feel today?")
                        .font(.title)
                    
                    Section(header: Text("How is your mood?")) {
                        Picker("Stimmung", selection: $mood) {
                            ForEach(moods, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    //                    .padding()
                    
                    Section(header: Text("How is your drive?")) {
                        Picker("Antrieb", selection: $drive) {
                            ForEach(drives, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    
                } // End Form
                .navigationTitle("Check-In")
                NavigationLink(destination: ActivityListView(activities: viewModel.suggestActivities(for: mood, and: drive))) {
                    Text("Suggest Activities")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    CheckInView()
}
