//
//  AffirmationsRepository.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 24.09.24.
//

import Foundation

class AffirmationsRepository {
  private let apiKey = "JXUgOmYgvM5s3LztoGV7Og==YKUk0n2qMZdql16o"
  func fetchAffirmations() async throws -> [Affirmations] {
    guard let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category=happiness") else {
      throw HTTPError.invalidURL
    }
    var request = URLRequest(url: url)
    request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
    let (data, response) = try await URLSession.shared.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw HTTPError.requestFailed
    }
    let result = try JSONDecoder().decode([Affirmations].self, from: data)
    return result
  }
  enum HTTPError: Error {
    case invalidURL
    case requestFailed
  }
}
