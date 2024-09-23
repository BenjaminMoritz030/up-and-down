//
//  Activities.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 19.09.24.
//

import Foundation

struct ActivitiesResponse: Codable {
    
    var activities: [Activity]
}

struct Activity: Codable, Hashable {
    
    var title: String
    var details: String
    var mood: String
    var drive: String
}

enum Mood: Codable, CaseIterable {
    case very_good
    case good
    case medium
    case bad
    case very_bad
    
    var title: String {
        switch self {
        case .very_good: return "Sehr gut"
        case .good: return "Gut"
        case .medium: return "Neutral"
        case .bad: return "Schlecht"
        case .very_bad: return "Sehr schlecht"
        }
    }
}

enum Drive: Codable, CaseIterable {
    case very_high
    case high
    case medium
    case low
    case very_low
    
    var title: String {
        switch self {
        case .very_high: return "Sehr hoch"
        case .high: return "Hoch"
        case .medium: return "Neutral"
        case .low: return "Niedrig"
        case .very_low: return "Sehr niedrig"
        }
    }
}
