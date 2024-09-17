//
//  ViewModel.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 08.08.24.
//

import Foundation
import CoreData

class ActivityViewModel: ObservableObject {

    @Published var activities: [Activity] = []

    let container = PersistentStore.shared.context

    func fetchActivity() {
        let request: NSFetchRequest<Activity> = Activity.fetchRequest()
        do {
            self.activities = try container.fetch(request)
        } catch {
            print("Failed fetching: \(error)")
        }
    }

    func addActivity(name: String) {
        let newActivity = Activity(context: container)
        newActivity.id = UUID()
        newActivity.name = name
        saveAndFetch()
    }

    func deleteActivity(activity: Activity) {
        container.delete(activity)
        saveAndFetch()
    }

    private func saveContext() {
        PersistentStore.shared.save()
    }
    
    private func saveAndFetch() {
        saveContext()
        fetchActivity()
    }
}
