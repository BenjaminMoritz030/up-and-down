//
//  CalenderView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 23.09.24.
//

import SwiftUI

struct CalenderView: View {
    @ObservedObject var viewModel: ActivityViewModel
    
    @Binding var selectedDate: Date
    @State private var showingSheet = false
    @State private var selectedActivity: PlannedActivityEntity?
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.purple, Color.blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Your planned activities")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding()
                
//                if viewModel.plannedActivities.isEmpty {
//                    Text("No planned activities available.")
//                        .foregroundColor(.white)
//                        .padding()
//                } else {
                    
                    List {
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
                                        .foregroundColor(.gray)
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
                            }
                        }
                    }
                    .listStyle(SidebarListStyle())
                }
                    .onAppear {
                        viewModel.fetchPlannedActivity()
                    }
                    .sheet(isPresented: $showingSheet) {
                        if let selectedActivity = selectedActivity {
                            VStack {
                                DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .padding()
                                
                                Button("Edit Date") {
                                    viewModel.updatePlannedActivity(activity: selectedActivity, newDate: selectedDate)
                                    print("Saving date: \(selectedDate)")
                                    showingSheet = false
                                }
                                .padding()
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }
                            .padding()
                        } else {
                            Text("No activity selected")
                        }
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
    
