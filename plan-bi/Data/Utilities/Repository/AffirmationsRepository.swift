//
//  AffirmationsRepository.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 24.09.24.
//

class ArticlesRepository {
    
  func fetchArticles(endpoint: String) async throws -> [Article] {
    guard let url = URL(string: "https://newsapi.org/v2/\(endpoint)&apiKey=5927f716366e4b679a7b03fe05519979") else { throw ArticlesRepositoryError.invalidURL }
    guard let (data, _) = try? await URLSession.shared.data(from: url) else { throw ArticlesRepositoryError.requestFailed }
    guard let result = try? JSONDecoder().decode(ArticleResponse.self, from: data) else { throw ArticlesRepositoryError.failedParsing }
    let news = result.articles
    return news
  }
}
