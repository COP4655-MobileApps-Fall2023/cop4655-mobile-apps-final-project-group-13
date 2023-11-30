//
//  Meal.swift
//  FP_mobileapps
//
//  Created by Richelle Plummer on 11/23/23.
//

import Foundation

struct MealsResponse: Decodable{
    let meals: [Meal]
}

struct Meal: Decodable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strArea: String
    let strInstructions: String?
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    var formattedIngredients: String {
        var ingredientsList: [String] = []

        // Directly check each ingredient
        if let ingredient1 = strIngredient1, !ingredient1.isEmpty { ingredientsList.append(ingredient1) }
        if let ingredient2 = strIngredient2, !ingredient2.isEmpty { ingredientsList.append(ingredient2) }
        if let ingredient3 = strIngredient3, !ingredient3.isEmpty { ingredientsList.append(ingredient3) }
        if let ingredient4 = strIngredient4, !ingredient4.isEmpty { ingredientsList.append(ingredient4) }
        if let ingredient5 = strIngredient5, !ingredient5.isEmpty { ingredientsList.append(ingredient5) }
        if let ingredient6 = strIngredient6, !ingredient6.isEmpty { ingredientsList.append(ingredient6) }
        if let ingredient7 = strIngredient7, !ingredient7.isEmpty { ingredientsList.append(ingredient7) }
        if let ingredient8 = strIngredient8, !ingredient8.isEmpty { ingredientsList.append(ingredient8) }
        if let ingredient9 = strIngredient9, !ingredient9.isEmpty { ingredientsList.append(ingredient9) }
        if let ingredient10 = strIngredient10, !ingredient10.isEmpty { ingredientsList.append(ingredient10) }
        if let ingredient11 = strIngredient11, !ingredient11.isEmpty { ingredientsList.append(ingredient11) }
        if let ingredient12 = strIngredient12, !ingredient12.isEmpty { ingredientsList.append(ingredient12) }
        if let ingredient13 = strIngredient13, !ingredient13.isEmpty { ingredientsList.append(ingredient13) }
        if let ingredient14 = strIngredient14, !ingredient14.isEmpty { ingredientsList.append(ingredient14) }
        if let ingredient15 = strIngredient15, !ingredient15.isEmpty { ingredientsList.append(ingredient15) }
        if let ingredient16 = strIngredient16, !ingredient16.isEmpty { ingredientsList.append(ingredient16) }
        if let ingredient17 = strIngredient17, !ingredient17.isEmpty { ingredientsList.append(ingredient17) }
        if let ingredient18 = strIngredient18, !ingredient18.isEmpty { ingredientsList.append(ingredient18) }
        if let ingredient19 = strIngredient19, !ingredient19.isEmpty { ingredientsList.append(ingredient19) }
        if let ingredient20 = strIngredient20, !ingredient20.isEmpty { ingredientsList.append(ingredient20) }
        

            // Format as a bulleted list
            let bulletPoint = "\u{2022}"
            return ingredientsList.map { "\(bulletPoint) \($0)" }.joined(separator: "\n")
        }
}

