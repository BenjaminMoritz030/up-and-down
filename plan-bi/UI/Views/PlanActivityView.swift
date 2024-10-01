//
//  PlanActivityView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 23.09.24.
//

import SwiftUI

struct PlanActivityView: View {
    
    var activity: ActivityEntity
    
    @Binding var selectedDate: Date
    @State private var activitySaved = false

    var body: some View {
        VStack {
            Text("When will You do Your \(activity.title ?? "Aktivität")")
                .font(.headline)
                .padding(.top)

            
            DatePicker("", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(WheelDatePickerStyle())
                .padding()

            Button(action: {
                saveActivityWithDate()
                activitySaved = true
            }) {
                Text("Save Your Activity")
                    .font(.headline)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            if activitySaved {
                Text("Aktivität wurde gespeichert!")
                    .foregroundColor(.green)
                    .padding(.top)
            }

            Spacer()
        }
        .padding()
    }
    
    // Funktion zum Speichern der Aktivität mit Datum (Dummy-Funktion)
    func saveActivityWithDate() {
        // Hier fügen Sie die Logik zum Speichern hinzu, z.B. in Core Data
        print("Aktivität: \(activity.title ?? "Aktivität") wurde für \(selectedDate) gespeichert.")
    }
}


#Preview {
    PlanActivityView(activity: ActivityEntity(context: PersistentStore.shared.context), selectedDate: .constant(Date()))
}
