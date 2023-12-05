//
//  Recipes.swift
//  FP_mobileapps
//
//  Created by Dayaan Mazhar on 12/2/23.
//

import Foundation

// Created a RecipesResponse model
struct RecipeResponse: Decodable {
    let meals: [Recipes]
}

struct Recipes: Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}
