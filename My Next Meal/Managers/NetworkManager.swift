//
//  NetworkManager.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import UIKit

struct NetworkManager {

    enum MealDBRequest: String {
        case getCategories = "categories.php"
        case getMealsByCategory = "filter.php?c="
        case getMealDetails = "lookup.php?i="
    }

    static let shared = NetworkManager()
    private let baseURL = "https://www.themealdb.com/api/json/v1/1/"
    private let cache = NSCache<NSString, UIImage>()
    private let decoder = JSONDecoder()

    private init() {}

    func getRequest<T: Decodable>(_ request: MealDBRequest, parameter: String = "") async throws -> T {
        let endpoint = baseURL + request.rawValue + parameter
        guard let url = URL(string: endpoint) else {
            throw NMError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NMError.invalidResponse
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NMError.invalidData
        }
    }

    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: urlString) else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            self.cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
    
}
