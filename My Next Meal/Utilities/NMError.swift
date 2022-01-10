//
//  NMError.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/4/22.
//

enum NMError: String, Error {
    case invalidURL = "Invalid URL. Could not create URL"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data recieved from the server was invalid"
}
