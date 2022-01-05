//
//  NetworkManager.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://www.themealdb.com/api/json/v1/1/"
    private let decoder = JSONDecoder()

    private init() {}

    func getCategories() async throws -> [Category] {
        let endpoint = baseURL + "categories.php"
        guard let url = URL(string: endpoint) else {
            throw NMError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NMError.invalidResponse
        }

        do {
            let decodedData = try decoder.decode(CategoryWrapper.self, from: data)
            return decodedData.categories
        } catch {
            throw NMError.invalidData
        }
    }
}
