//
//  NetworkManager.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import UIKit

struct NetworkManager {

    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    private let decoder = JSONDecoder()

    private init() {}

    func getRequest<T: Decodable>(endpoint: MealDBEndpoint) async throws -> T {
        guard let url = endpoint.url else {
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
