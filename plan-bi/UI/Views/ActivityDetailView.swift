//
//  ActivityDetailView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 23.09.24.
//

import SwiftUI

struct ActivityDetailView: View {
    
    @StateObject var viewModel = ActivityViewModel()
    
    var activity: ActivityEntity
    
    @State private var showDatePicker = false
    @State private var selectedDate: Date = Date()
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            
            AnimatedMeshView()
            
            VStack {
                Text(activity.title ?? "No Title")
                    .font(.custom("Supreme Variable", size: 30))
                    .foregroundColor(.white)
                    .padding()
                
                Text(activity.details ?? "No Details")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    showDatePicker.toggle()
                }) {
                    HStack {
                        Text("Set Date")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        Text("\(selectedDate, formatter: dateFormatter)")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(10)
                }
                .sheet(isPresented: $showDatePicker) {
                    VStack {
                        DatePicker(
                            "Select Date",
                            selection: $selectedDate,
                            in: Date()...,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .accentColor(.purple)
                        
                        Button("Save Date") {
                            if Calendar.current.isDateInToday(selectedDate) {
                                alertMessage = "Your activity has been saved. Go to your calendar to see it."
                            } else {
                                alertMessage = "Your activity has been saved. Go to your calendar to see it."
                            }
                            viewModel.savePlannedActivity(date: selectedDate, activity: activity)
                            showDatePicker = false
                            showAlert = true
                        }
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .cornerRadius(20)
            .padding()
            .alert("Activity Saved", isPresented: $showAlert) {
                Button("Done") {
                    
                }
            } message: {
                Text(alertMessage)
                    .font(.system(size: 18))
                    .padding()
            }
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}

#Preview {
    ActivityDetailView(activity: ActivityEntity(context: PersistentStore.shared.context))
}
