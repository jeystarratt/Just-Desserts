//
//  MealDB.swift
//  JustDesserts
//
//  Created by Jey Starratt on 9/1/24.
//

import Foundation
import Observation

/// To fetch meal-related information from TheMealDB.
@Observable
class MealDB {
    /// An internal type for decoding a typical TheMealDB response.
    private struct MealResponse: Codable {
        let meals: [Meal]
    }

    /// The base of any given TheMealDB endpoint.
    private let baseURL = "https://themealdb.com/api/json/v1/1/"

    /// The URLSession instance to be used (most likely will be shared).
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session

        // Set shared cache instance.
        URLCache.shared = URLCache()
    }

    private let decoder = JSONDecoder()

    private func fetch(path: String, cached: Bool) async throws -> [Meal] {
        guard let url = URL(string: baseURL + path) else { throw MealDBError.badURL }
        let request = URLRequest(url: url, cachePolicy: cached ? .returnCacheDataElseLoad : .reloadIgnoringCacheData)
        let (data, _) = try await session.data(for: request)
        return try decoder.decode(MealResponse.self, from: data).meals
    }

    func desserts(cached: Bool) async throws -> [Meal] {
        try await fetch(path: "filter.php?c=Dessert", cached: cached)
    }

    func mealDetails(for mealID: String, cached: Bool) async throws -> Meal {
        guard let meal = try await fetch(path: "lookup.php?i=\(mealID)", cached: cached).first else { throw MealDBError.badResponse }
        return meal
    }
}
