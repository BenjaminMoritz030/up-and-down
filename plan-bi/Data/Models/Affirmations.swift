//
//  Affirmations.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 24.09.24.
//

import Foundation

struct AffirmationsResults: Codable {
    let results: [Affirmations]
}

struct Affirmations: Codable {
    
    let quote: String
    let author: String
}
