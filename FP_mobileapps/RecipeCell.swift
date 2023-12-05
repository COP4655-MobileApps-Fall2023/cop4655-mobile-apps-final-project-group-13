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
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Configures the cell's UI for the given recipe.
    func configure(with recipes: Recipes) {
        // Check if strMeal is not empty
        guard !recipes.strMeal.isEmpty else {
            // Handle the case where strMeal is empty
            print("Error: Recipe name is empty")
            return
        }

        // Safely unwrap title
        if let unwrapTitle = recipeName {
            unwrapTitle.text = recipes.strMeal

            // Apply text shadow
            unwrapTitle.layer.shadowColor = UIColor.black.cgColor
            unwrapTitle.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            unwrapTitle.layer.shadowOpacity = 0.5
            unwrapTitle.layer.shadowRadius = 1.0
        } else {
            // Handle the case where title is nil
            print("Error: Title label is nil")
        }

        // Safely unwrap recipesImage
        if let unwrapRecipeImage = recipesImage {
            // Convert strMealThumb to String before concatenating
            let imageUrlStr = recipes.strMealThumb
            
            // Convert the URL string to URL
            if let imageUrl = URL(string: imageUrlStr) {
                // Load image asynchronously using Nuke library's image loading helper method
                Nuke.loadImage(with: imageUrl, into: unwrapRecipeImage)
            } else {
                // Handle the case where the URL cannot be created
                print("Error: Invalid URL")
            }
        } else {
            // Handle the case where recipesImage is nil
            print("Error: Recipe image view is nil")
        }
    }
    
    // Set up the UI for the cell
    private func setupUI() {
        // Round corners of the entire cell
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true

        // Add gradient overlay to darken the image
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.8, 1.0] // Adjust the gradient stops as needed
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = contentView.bounds

        contentView.layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Add spacing at the bottom
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0))
    }
}
