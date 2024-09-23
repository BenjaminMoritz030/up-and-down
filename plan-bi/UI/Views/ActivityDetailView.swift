//
//  ActivityDetailView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 23.09.24.
//

import SwiftUI

struct ActivityDetailView: View {
    var activity: ActivityEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(activity.title ?? "Keine Aktivität")
                .font(.largeTitle)
                .padding(.bottom)
            
            Text("Beschreibung:")
                .font(.headline)
            Text(activity.details ?? "Keine Details vorhanden")
            
            Spacer()
        }
        .padding()
        .navigationTitle("Aktivitätsdetails")
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Erstellen Sie eine "Fake"-Instanz von ActivityEntity ohne Core Data
        let activity = ActivityEntityPreview(title: "Plan Your Week", details: "Take time to plan your upcoming week.", duration: "30 minutes")
        
        // Rückgabe der Detailansicht mit der Vorschau-Instanz
        return ActivityDetailViewPreview(activity: activity)
    }
}

// Dummy ActivityEntity Preview-Modell
struct ActivityEntityPreview {
    var title: String?
    var details: String?
    var duration: String?
}

// Vorschau-spezifische View ohne Core Data-Abhängigkeit
struct ActivityDetailViewPreview: View {
    var activity: ActivityEntityPreview
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(activity.title ?? "Keine Aktivität")
                .font(.largeTitle)
                .padding(.bottom)
            
            Text("Beschreibung:")
                .font(.headline)
            Text(activity.details ?? "Keine Details vorhanden")
            
            Text("Dauer: \(activity.duration ?? "Keine Dauer")")
            
            Spacer()
        }
        .padding()
        .navigationTitle("Aktivitätsdetails")
    }
}

