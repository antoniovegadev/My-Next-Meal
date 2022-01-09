//
//  MealDetail.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/5/22.
//

import Foundation

struct MealDetailAPIResponse: Decodable {
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
        let ingredientContainer = try decoder.container(keyedBy: IngredientCodingKeys.self)
        let measurementContainer = try decoder.container(keyedBy: MeasurementCodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imageURLString = try container.decode(String.self, forKey: .imageURLString)
        instructions = try container.decode(String.self, forKey: .instructions)

        let ingredientKeys = IngredientCodingKeys.allCases
        let measurementKeys = MeasurementCodingKeys.allCases

        for (ingredientKey, measurementKey) in zip(ingredientKeys, measurementKeys) {
            let name = try ingredientContainer.decodeIfPresent(String.self, forKey: ingredientKey)
            let measurement = try measurementContainer.decodeIfPresent(String.self, forKey: measurementKey)

            if let name = name, let measurement = measurement,
               !name.isEmtpyWithBraces() && !measurement.isEmtpyWithBraces() {
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
    }

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
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
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
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
    }
}
