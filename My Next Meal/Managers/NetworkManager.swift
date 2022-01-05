//
//  NetworkManager.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import UIKit

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

    func getMeals(in category: String) async throws -> [Meal] {
        let endpoint = baseURL + "filter.php?c=" + category
        guard let url = URL(string: endpoint) else {
            throw NMError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NMError.invalidResponse
        }

        do {
            let decodedData = try decoder.decode(MealWrapper.self, from: data)
            return decodedData.meals
        } catch {
            throw NMError.invalidData
        }
    }

    func downloadImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            return image
        } catch {
            return nil
        }
    }
    
}
