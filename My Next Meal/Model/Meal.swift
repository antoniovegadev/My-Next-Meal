//
//  Meal.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import Foundation

struct MealAPIResponse: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable {
    let id: String
    let name: String
    let imageURLString: String
}

extension Meal {
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageURLString = "strMealThumb"
    }
}
