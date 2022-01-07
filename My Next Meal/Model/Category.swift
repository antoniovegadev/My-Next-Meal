//
//  Category.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

import Foundation

struct CategoryAPIResponse: Decodable {
    let categories: [Category]
}

struct Category: Decodable {
    let id: String
    let category: String
    let imageURLString: String
    let description: String
}

extension Category {
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case category = "strCategory"
        case imageURLString = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}
