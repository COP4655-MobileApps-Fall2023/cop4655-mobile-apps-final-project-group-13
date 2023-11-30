//
//  RecipeDetailsController.swift
//  FP_mobileapps
//
//  Created by Christian on 11/30/23.
//

import Foundation
import Nuke
import UIKit

class RecipeDetailsController: UIViewController {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UITextView!
    @IBOutlet weak var ingredientsLabel: UITextView!
    @IBOutlet weak var cookingLabel: UITextView!
    
    
    var meal: Meal!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Safely unwrap and display image
        if let meal = meal, let imageUrl = URL(string: meal.strMealThumb) {
            Nuke.loadImage(with: imageUrl, into: recipeImageView)
        } else {
            print("Meal object or URL string is nil")
        }

        // Safely unwrap and set recipe name
        if let recipeName = meal?.strMeal {
            recipeNameLabel.text = recipeName
        } else {
            print("Error: Recipe name is nil")
        }

        // Safely unwrap and set ingredients
        if let ingredients = meal?.formattedIngredients {
            ingredientsLabel.text = ingredients
        } else {
            print("Error: Ingredients are nil")
        }

        // Safely unwrap and set cooking instructions
        if let instructions = meal?.strInstructions {
            cookingLabel.text = instructions
        } else {
            print("Error: Cooking instructions are nil")
        }
            

    }
    
    
}
