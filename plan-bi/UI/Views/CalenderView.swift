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
        VStack {
            Text("Geplante Aktivitäten")
                .font(.largeTitle)
                .padding()
            
            List {
                ForEach(viewModel.plannedActivities, id: \.id) { activity in
                    HStack {
//                        Text("Datum:")
                        Spacer()
                        if let date = activity.date {
                            Text("\(date, formatter: dateFormatter)")
                                .onTapGesture {
                                    selectedDate = date
                                }
                        } else {
                            Text("Kein Datum")
                        }
                        
                        // DatePicker zum Aktualisieren des Datums
                                                DatePicker(
                                                    "Neues Datum",
                                                    selection: Binding(
                                                        get: {
                                                            activity.date ?? Date()
                                                        },
                                                        set: { newDate in
                                                            // Aufruf der Update-Funktion aus dem ViewModel
                                                            viewModel.updatePlannedActivity(activity: activity, newDate: newDate)
                                                        }
                                                    ),
                                                    displayedComponents: [.date]
                                                )
                                                .datePickerStyle(CompactDatePickerStyle())
                                                .padding(.vertical)
                        
                        // Anzeige der zugehörigen Aktivität
                                                if let activityTitle = activity.activity?.title {
                                                    Text("\(activityTitle)")
                                                        .foregroundColor(.gray)
                                                } else {
                                                    Text("Keine Aktivität")
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

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

#Preview {
    CalenderView(viewModel: ActivityViewModel(), selectedDate: .constant(Date()))
}



