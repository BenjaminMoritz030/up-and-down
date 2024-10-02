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
                
                List {
                    ForEach(viewModel.plannedActivities, id: \.id) { activity in
                        HStack {
                            
                            Spacer()
                            
                                                       
                            //  if viewModel.plannedActivities.isEmpty {
                            //                                                Text("No planned activities found yet. Please go to Check In.")
//                                    .font(.headline)
//                                    .foregroundColor(.white)
//                                    .padding()
                            //   } else
                            
                            if let date = activity.date {
                                Text("\(date, formatter: dateFormatter)")
                                    .onTapGesture {
                                        selectedDate = date
                                    }
                            } else {
                                Text("No date")
                            }
                            
                            // DatePicker zum Aktualisieren des Datums
                            DatePicker(
                                "Edit date",
                                selection: Binding(
                                    get: {
                                        activity.date ?? Date()
                                    },
                                    set: { newDate in
                                        viewModel.updatePlannedActivity(activity: activity, newDate: newDate)
                                    }
                                ),
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(CompactDatePickerStyle())
                            .padding(.vertical)
                            
                            if let activityTitle = activity.activity?.title {
                                Text("\(activityTitle)")
                                    .foregroundColor(.gray)
                            } else {
                                Text("No activity")
                                    .foregroundColor(.red)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.deletePlannedActivity(activity: activity)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchPlannedActivity()
            }
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
