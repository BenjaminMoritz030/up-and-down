//
//  ViewModel.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 08.08.24.
//

import Foundation
import CoreData

class ActivityViewModel: ObservableObject {

    @Published var activities: [ActivityEntity] = []

    let container = PersistentStore.shared.context
    
    init() {
        checkAndLoadActivities()
//            clearCoreData()
    }
    
    func checkAndLoadActivities() {
        let fetchRequest: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
        do {
            let savedActivities = try container.fetch(fetchRequest)
            if  savedActivities.isEmpty {
                getActivitiesFromData(filePath: "Activities")
            } else {
                fetchActivity()
            }
        } catch {
            print("Fehler beim Laden der Aktivitäten \(error.localizedDescription)")
        }
    }
    
    func clearCoreData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ActivityEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try container.execute(deleteRequest)
            try container.save()
        } catch {
            print("Fehler beim Löschen der Aktivitäten \(error.localizedDescription)")
        }
    }
    
    // Lade JSON-Daten und speichere sie in Core Data
    func getActivitiesFromData(filePath: String) {
        // Lade die Aktivitäten aus der JSON-Datei
        guard let response: ActivitiesResponse = FileManager.loadJSON(with: filePath) else {
            print("Fehler beim Laden der JSON-Datei")
            return
        }
        
        // Konvertiere jede Aktivität aus JSON zu einem ActivityEntity und speichere es
        for activity in response.activities {
            let newActivity = ActivityEntity(context: container)
            newActivity.id = UUID()
            newActivity.title = activity.title
            newActivity.details = activity.details
            newActivity.mood = activity.mood
            newActivity.drive = activity.drive
        }
        
        // Speichere den Core Data-Kontext
        saveContext()
    }
    
    func fetchActivity() {
        let request: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
        do {
            self.activities = try container.fetch(request)
        } catch {
            print("Failed fetching: \(error)")
        }
    }
    
    func suggestActivities(for mood: String, and drive: String) -> [ActivityEntity] {
        
        let allActivities = activities
        
        
        // Filtere die Aktivitäten basierend auf Stimmung (mood) und Antrieb (drive)
        let filteredActivities = allActivities.filter { activity in
            activity.mood?.lowercased() == mood.lowercased() && activity.drive?.lowercased() == drive.lowercased()
        }
        
        return filteredActivities
    }

    private func saveContext() {
        PersistentStore.shared.save()
    }
   
    private func saveAndFetch() {
        saveContext()
        fetchActivity()
    }
}
