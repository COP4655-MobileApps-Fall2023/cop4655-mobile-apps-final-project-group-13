//
//  RecipeCell.swift
//  FP_mobileapps
//
//  Created by Dayaan Mazhar on 12/2/23.
//

import UIKit
import Nuke

class RecipeCell: UITableViewCell {
    
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipesImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Configures the cell's UI for the given recipe.
    func configure(with recipes: Recipes) {
        // Check if strCategory is not empty
        guard !recipes.strMeal.isEmpty else {
            // Handle the case where strCategory is empty
            print("Error: Recipe category is empty")
            return
        }

        // Safely unwrap title
        if let unwrapTitle = recipeName {
            unwrapTitle.text = recipes.strMeal
        } else {
            // Handle the case where title is nil
            print("Error: Title label is nil")
        }

        // Safely unwrap recipeImage
        if let unwrapRecipeImage = recipesImage {
            // Convert recipe.id to String before concatenating
            let imageUrlStr = recipes.strMealThumb
            
            // Convert the URL string to URL
            if let imageUrl = URL(string: imageUrlStr) {
                // Load image async via Nuke library image loading helper method
                Nuke.loadImage(with: imageUrl, into: unwrapRecipeImage)
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
