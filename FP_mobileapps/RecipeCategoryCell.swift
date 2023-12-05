//
//  RecipeCategoryCell.swift
//  FP_mobileapps
//
//  Created by Dayaan Mazhar on 11/21/23.
//

import UIKit
import Nuke

class RecipeCategoryCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Configures the cell's UI for the given recipe.
    func configure(with recipe: RecipeCategory) {
        // Check if strCategory is not empty
        guard !recipe.strCategory.isEmpty else {
            // Handle the case where strCategory is empty
            print("Error: Recipe category is empty")
            return
        }

        // Safely unwrap title
        if let unwrappedTitle = title {
            unwrappedTitle.text = recipe.strCategory
        } else {
            // Handle the case where title is nil
            print("Error: Title label is nil")
        }

        // Safely unwrap recipeImage
        if let unwrappedRecipeImage = recipeImage {
            // Convert recipe.id to String before concatenating
            let imageUrlString = "https://www.themealdb.com/images/category/" + recipe.strCategory + ".png"
            
            // Convert the URL string to URL
            if let imageUrl = URL(string: imageUrlString) {
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
