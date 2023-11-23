//
//  MealCell.swift
//  FP_mobileapps
//
//  Created by Richelle Plummer on 11/23/23.
//

import UIKit
import Nuke

class MealCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    func configure(with meal: Meal) {
           // Check if strMeal is not empty
           guard !meal.strMeal.isEmpty else {
               // Handle the case where strMeal is empty
               print("Error: Meal name is empty")
               return
           }

           // Safely unwrap title
           if let unwrappedTitle = title {
               unwrappedTitle.text = meal.strMeal
           } else {
               // Handle the case where title is nil
               print("Error: Title label is nil")
           }

           // Safely unwrap descriptionLabel
           if let unwrappedDescription = descriptionLabel {
               unwrappedDescription.text = meal.strCategory
           } else {
               // Handle the case where descriptionLabel is nil
               print("Error: Description label is nil")
           }

           // Safely unwrap recipeImage
           if let unwrappedRecipeImage = recipeImage {
               // Convert the URL string to URL
               if let imageUrl = URL(string: meal.strMealThumb) {
                   // Load image async via Nuke library image loading helper method
                   Nuke.loadImage(with: imageUrl, into: unwrappedRecipeImage)
               } else {
                   // Handle the case where the URL cannot be created
                   print("Error: Invalid URL")
               }
           } else {
               // Handle the case where recipeImage is nil
               print("Error: Recipe image view is nil")
           }
       }
    
    
}
