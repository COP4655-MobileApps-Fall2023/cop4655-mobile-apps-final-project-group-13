//
//  StreamViewController.swift
//  FP_mobileapps
//
//  Created by Dayaan Mazhar on 12/2/23.
//

import Foundation
import UIKit

class StreamViewController: UIViewController, UITableViewDataSource {

    var selectedCategory: String?
    var recipes: [Recipes] = []

    
    @IBOutlet weak var recipesTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedCategory = selectedCategory {
            // Debug: Print selected category
            print("Selected Category: \(selectedCategory)")
            
            // Assigning recipesTitle to the selectedCategory
            recipesTitle.text = "\(selectedCategory) Recipes"
            
            // Construct URL for API request
            let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(selectedCategory)"
            
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)

                let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                    // Handle errors and parse JSON
                    if let error = error {
                        print("❌ Network error: \(error.localizedDescription)")
                    }

                    // Unwrap the optional Data and convert it to String
                    if let data = data, let jsonString = String(data: data, encoding: .utf8) {
                        print(jsonString)
                    } else {
                        print("❌ Data is nil or could not be converted to String")
                    }

                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(RecipeResponse.self, from: data!)

                        // Update self?.recipes and reload the table view on the main thread
                        DispatchQueue.main.async {
                            self?.recipes = response.meals // Update to use "meals" key
                            self?.tableView.reloadData()
                        }
                    } catch {
                        print("❌ Error parsing JSON: \(error.localizedDescription)")
                    }
                }

                task.resume()
            }
        } else {
            // Debug: Handle the case where selectedCategory is nil
            print("Error: selectedCategory is nil")
        }

        // Set up the data source for the table view
        tableView.dataSource = self
        // Set up other configurations for your table view
    }

    // MARK: - UITableViewDataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        let recipe = recipes[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }
}
