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
    var ingredients: [Ingredient] = []
}

extension MealDetail {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let ingredientContainer = try decoder.container(keyedBy: CodingKeys.IngredientCodingKeys.self)
        let measurementContainer = try decoder.container(keyedBy: CodingKeys.MeasurementCodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imageURLString = try container.decode(String.self, forKey: .imageURLString)
        instructions = try container.decode(String.self, forKey: .instructions)

        let ingredientKeys = CodingKeys.IngredientCodingKeys.allCases
        let measurementKeys = CodingKeys.MeasurementCodingKeys.allCases

        let endRange = ingredientKeys.count

        for idx in 0..<endRange {
            let ingredientName = try ingredientContainer.decodeIfPresent(String.self, forKey: ingredientKeys[idx])
            let measurement = try measurementContainer.decodeIfPresent(String.self, forKey: measurementKeys[idx])

            if let name = ingredientName, let measurement = measurement,
               !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
                !measurement.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                let ingredient = Ingredient(name: name, measurement: measurement)
                ingredients.append(ingredient)
            }

        }
    }
}

extension MealDetail {
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageURLString = "strMealThumb"
        case instructions = "strInstructions"

        enum IngredientCodingKeys: String, CodingKey, CaseIterable {
            case strIngredient1
            case strIngredient2
            case strIngredient3
            case strIngredient4
            case strIngredient5
            case strIngredient6
            case strIngredient7
            case strIngredient8
            case strIngredient9
            case strIngredient10
        }

        enum MeasurementCodingKeys: String, CodingKey, CaseIterable {
            case strMeasure1
            case strMeasure2
            case strMeasure3
            case strMeasure4
            case strMeasure5
            case strMeasure6
            case strMeasure7
            case strMeasure8
            case strMeasure9
            case strMeasure10
        }
    }
}
