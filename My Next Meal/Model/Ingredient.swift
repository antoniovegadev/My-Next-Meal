//
//  Ingredient.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/5/22.
//

struct Ingredient {
    let name: String
    let measurement: String

    var imageURLString: String {
        "https://www.themealdb.com/images/ingredients/\(name).png"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
