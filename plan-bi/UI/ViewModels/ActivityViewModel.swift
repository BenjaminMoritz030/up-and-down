//
//  ViewModel.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 08.08.24.
//

import Foundation
import CoreData

class ActivityViewModel: ObservableObject {
    
    @Published var plannedActivities: [PlannedActivityEntity] = []
    @Published var activities: [ActivityEntity] = []
    @Published var affirmations: [Affirmations] = []
    
    private let repository = AffirmationsRepository()
    
    @MainActor
    func load() async throws {
        // Für die Abfrage starten wir einen "Task", also eine "Hintergrund-Aufgabe",
        // die parallel zum restlichen Programm die Abfrage ausführt
        Task {
            // Da die Funktion 'fetchAlbums' als 'throws' deklariert ist, wird sie mit "do/try/catch" ausgeführt
            do {
                // Hier wird aus dem Hintergrund-Task heraus die UI aktualisiert.
                // Das ist nur erlaubt, wenn die aufrufende Methode als `@MainActor` markiert ist
                self.affirmations = try await self.repository.fetchAffirmations()
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }
    
    let container = PersistentStore.shared.context
    
    init() {
        checkAndLoadActivities()
        //      clearCoreData()
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
    
    func fetchPlannedActivity() {
        let request: NSFetchRequest<PlannedActivityEntity> = PlannedActivityEntity.fetchRequest()
        do {
            self.plannedActivities = try container.fetch(request)
        } catch {
            print("Failed fetching: \(error)")
        }
    }
    
    func savePlannedActivity(date: Date, activity: ActivityEntity) {
        // Erstelle eine neue Instanz von PlannedActivityEntity
        let newPlannedActivity = PlannedActivityEntity(context: container)
        newPlannedActivity.id = UUID()
        newPlannedActivity.date = date
        newPlannedActivity.activity = activity
        
        // Speichere den Kontext, um die neue Aktivität in Core Data zu persistieren
        saveContext()
        
        // Füge die neue Aktivität der geplanten Aktivitäten hinzu (um die UI sofort zu aktualisieren)
        plannedActivities.append(newPlannedActivity)
    }
    
    func suggestActivities(for mood: String, and drive: String) -> [ActivityEntity] {
        
        let allActivities = activities
        
        let filteredActivities = allActivities.filter { activity in
            activity.mood?.lowercased() == mood.lowercased() && activity.drive?.lowercased() == drive.lowercased()
        }
        
        return filteredActivities
    }
    
    private func saveContext() {
        PersistentStore.shared.save()
    }
    
    func updatePlannedActivity(activity: PlannedActivityEntity, newDate: Date) {
        activity.date = newDate
        
        do {
            try container.save()
            fetchPlannedActivity()
        } catch {
            print("Failed updating activity: \(error)")
        }
    }
    
    func deletePlannedActivity(activity: PlannedActivityEntity) {
        container.delete(activity)
        
        do {
            try container.save()
            if let index = plannedActivities.firstIndex(of: activity) {
                plannedActivities.remove(at: index)
            }
        } catch {
            print("Failed deleting: \(error)")
        }
    }
}
