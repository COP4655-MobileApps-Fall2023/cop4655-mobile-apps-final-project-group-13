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
            recipeNameLabel.isEditable = false
        } else {
            print("Error: Recipe name is nil")
        }

        // Safely unwrap and set ingredients
        if let ingredients = meal?.formattedIngredients {
            ingredientsLabel.text = ingredients
            //disable scrolling within the text view
            ingredientsLabel.isScrollEnabled = false
            ingredientsLabel.isEditable = false
            
            ingredientsLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        } else {
            print("Error: Ingredients are nil")
        }

        // Set content compression resistance priority for cookingLabel (or preparationLabel, they are the same in your case)
       
        cookingLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        // Safely unwrap and set cooking instructions
        if let instructions = meal?.strInstructions {
            cookingLabel.text = instructions
            
            //disable scrolling
            cookingLabel.isScrollEnabled = false
            cookingLabel.isEditable = false
        } else {
            print("Error: Cooking instructions are nil")
        }
            

    }
    
    
}
