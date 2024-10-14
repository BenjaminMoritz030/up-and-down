//
//  CalenderView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 23.09.24.
//

import SwiftUI

struct CalenderView: View {
    @ObservedObject var viewModel: ActivityViewModel
    
    @State private var showingSheet = false
    @Binding var selectedDate: Date
    @State private var selectedActivity: PlannedActivityEntity?
    
    var body: some View {
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
                Text("Your planned activities")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding()
                
                List {
                    if viewModel.plannedActivities.isEmpty {
                        Text("No planned activities available. You have to check in.")
                            .foregroundColor(.purple)
                            .padding()
                    } else {
                        ForEach(sortedActivitiesByDate, id: \.id) { activity in
                            HStack {
                                if let date = activity.date {
                                    Text("\(date, formatter: dateFormatter)")
                                        .onTapGesture {
                                            selectedDate = date
                                        }
                                } else {
                                    Text("No date")
                                }
                                
                                if let activityTitle = activity.activity?.title {
                                    Text("\(activityTitle)")
                                        .font(.system(size: 18, weight: .bold))
                                } else {
                                    Text("No activity")
                                        .foregroundColor(.red)
                                }
                                
                                Spacer()
                            }
                            .swipeActions(allowsFullSwipe: false) {
                                Button(action: {
                                    viewModel.deletePlannedActivity(activity: activity)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                                .tint(.red)
                                
                                Button(action: {
                                    selectedActivity = activity
                                    if let activityDate = activity.date {
                                        selectedDate = activityDate
                                    } else {
                                        selectedDate = Date()
                                    }
                                    showingSheet.toggle()
                                }) {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.blue)
                                }
                                .tint(.yellow)
                            }
                        }
                    }
                }
                .listStyle(SidebarListStyle())
            }
            .onAppear {
                viewModel.fetchPlannedActivity()
            }
            .sheet(isPresented: $showingSheet) {
                VStack {
                    DatePicker(
                        "Select Date",
                        selection: $selectedDate,
                        in: Date()...,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()

                    Button("Edit Date") {
                        if let selectedActivity = selectedActivity {
                            viewModel.updatePlannedActivity(activity: selectedActivity, newDate: selectedDate)
                            print("Saving date: \(selectedDate) for activity: \(selectedActivity.activity?.title ?? "No title")")
                            showingSheet = false
                        }
                    }
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
                }
                .padding()
            }
        }
    }
    
    private var sortedActivitiesByDate: [PlannedActivityEntity] {
        return viewModel.plannedActivities
            .sorted {
                ($0.date ?? Date()) < ($1.date ?? Date())
            }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

#Preview {
    CalenderView(viewModel: ActivityViewModel(), selectedDate: .constant(Date()))
}
