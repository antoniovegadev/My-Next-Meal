//
//  MealDetail.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/5/22.
//

import Foundation

struct MealDetailWrapper: Decodable {
    let meals: [MealDetail]
}

struct MealDetail: Decodable {
    let id: String
    let name: String
    let imageURLString: String
    let instructions: String
}

extension MealDetail {
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageURLString = "strMealThumb"
        case instructions = "strInstructions"
    }
}
