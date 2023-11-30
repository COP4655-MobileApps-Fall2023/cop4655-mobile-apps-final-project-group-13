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

        // Load the image located at the `artworkUrl100` URL and set it on the image view.
        if let imageUrl = URL(string: meal.strMealThumb) {
            Nuke.loadImage(with: imageUrl, into: recipeImageView)
        } else {
            print("Invalid URL string: \(meal.strMealThumb)")
        }

        // Set labels with the associated track values.
        recipeNameLabel.text = meal.strMeal
        ingredientsLabel.text = meal.formattedIngredients
        cookingLabel.text = meal.strInstructions
        
            

    }
    
    
}
