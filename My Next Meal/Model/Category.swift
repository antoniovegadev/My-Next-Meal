//
//  Category.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

struct CategoryAPIResponse: Decodable {
    let categories: [Category]
}

struct Category: Decodable, Hashable {
    let id: String
    let name: String
    let imageURLString: String
    let description: String
}

extension Category {
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case imageURLString = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}
