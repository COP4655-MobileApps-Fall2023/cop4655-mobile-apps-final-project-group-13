//
//  RecipeCategory.swift
//  FP_mobileapps
//
//  Created by Dayaan Mazhar on 11/21/23.
//

import Foundation

// Created a RecipesResponse model
struct RecipesResponse: Decodable {
    let categories: [RecipeCategory]
}

struct RecipeCategory: Decodable {
    let strCategory: String
    let strCategoryThumb: String
}
