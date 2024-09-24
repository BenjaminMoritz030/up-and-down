//
//  AffirmationsRepository.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 24.09.24.
//

import Foundation

class AffirmationsRepository {
    
    func fetchAffirmations(endpoint: String) async throws -> [Affirmations] {
        // Eine URL ist immer optional, deswegen muss diese in ein guard gepackt werden
        guard let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category=happiness\(endpoint)&apiKey=JXUgOmYgvM5s3LztoGV7Og==YKUk0n2qMZdql16o") else {
            throw HTTPError.invalidURL
        }

        // Die Funktion zum Abruf der URL wird als 'await' markiert, da auf das Ergebnis von der API gewartet wird
        let (data, _) = try await URLSession.shared.data(from: url)

        // 'JSONDecoder' wird genutzt, da wir wissen, dass ein JSON von der API zurück kommt
        let result = try JSONDecoder().decode(AffirmationsResults.self, from: data)
        return result.results
    }
    
    enum HTTPError: Error {
        case invalidURL
        case requestFailed
    }
}
