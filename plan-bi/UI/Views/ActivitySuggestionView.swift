//
//  ActivitySuggestionView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 11.09.24.
//

import SwiftUI


struct ActivitySuggestionView: View {
    var mood: String
    var drive: String
    
    var body: some View {
        let activities = suggestActivities(for: mood, and: drive)
        
        VStack {
            Text("Basierend auf deiner Stimmung und deinem Antrieb:")
                .font(.headline)
                .padding()
            
            List(activities, id: \.self) { activity in
                Text(activity)
            }
        }
        .navigationTitle("Aktivitäten")
    }
    
    func suggestActivities(for mood: String, and drive: String) -> [String] {
        switch (mood, drive) {
        case ("Sehr schlecht", "Sehr niedrig"):
            return ["Meditation", "Leichte Dehnübungen", "Ruhepause"]
        case ("Sehr gut", "Sehr hoch"):
            return ["Intensives Training", "Neue Fähigkeiten lernen", "Freunde treffen"]

        default:
            return ["Spazieren gehen", "Lesen", "Musik hören"]
        }
    }
}

struct ActivitySuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySuggestionView(mood: "Neutral", drive: "Mittel")
    }
}
