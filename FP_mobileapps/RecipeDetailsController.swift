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
    
    struct MealDetailResponse: Decodable {
        var meals: [Meal]
    }
    
    var meal: Meal!
    var idMeal: String?

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
        
        if meal == nil, let idMeal = idMeal {
                    fetchMealDetails(idMeal: idMeal)
                }

            

    }
    func fetchMealDetails(idMeal: String) {
        let detailsURLString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)"
        guard let url = URL(string: detailsURLString) else {
            print("Error: Invalid URL")
            return
        }

        fetchData(from: url)
    }
    
    func fetchData(from url: URL) {
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("❌ Data is nil")
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MealDetailResponse.self, from: data)

                DispatchQueue.main.async {
                    if let mealDetails = response.meals.first {
                        self?.updateUIWithMealDetails(mealDetails)
                    } else {
                        print("Error: No meal details found")
                    }
                }
            } catch {
                print("❌ Error decoding JSON: \(error)")
            }
        }

        task.resume()
    }
    
    func updateUIWithMealDetails(_ mealDetails: Meal) {
        // Update the recipe name
        print("Ingredients to display: \(mealDetails.formattedIngredients)")
        recipeNameLabel.text = mealDetails.strMeal
        recipeNameLabel.isEditable = false

        // Update the ingredients
        ingredientsLabel.text = mealDetails.formattedIngredients
        ingredientsLabel.isScrollEnabled = false
        ingredientsLabel.isEditable = false
        ingredientsLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)

        // Update the cooking instructions
        cookingLabel.text = mealDetails.strInstructions
        cookingLabel.isScrollEnabled = false
        cookingLabel.isEditable = false

        // Load and display the image
        if let imageUrl = URL(string: mealDetails.strMealThumb) {
            Nuke.loadImage(with: imageUrl, into: recipeImageView)
        }
    }
    
    
}
