//
//  MainViewController.swift
//  FP_mobileapps
//
//  Created by Dayaan Mazhar on 11/21/23.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    // Added a recipes property
    var recipes: [RecipeCategory] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    // Added table view outlet
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Created a URL for the request
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!

        // Used the URL to instantiate a request
        let request = URLRequest(url: url)

        // Creating a URLSession using a shared instance and calling its dataTask method
        // The data task method attempts to retrieve the contents of a URL based on the specified URL.
        // When finished, it calls it's completion handler passing in optional values for data (the data we want to fetch), response (info about the response like status code) and error (if the request was unsuccessful)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            // Handle any errors
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }

            // Ensuring we have data
            guard let data = data else {
                print("❌ Data is nil")
                return
            }

            // The `JSONSerialization.jsonObject(with: data)` method is a "throwing" function (meaning it can throw an error) so we wrap it in a `do` `catch`
            // We cast the resultant returned object to a dictionary with a `String` key, `Any` value pair.
            do {
                // Created a JSON Decoder
                let decoder = JSONDecoder()

                // Used the JSON decoder to try and map the data to our custom model.
                // TrackResponse.self is a reference to the type itself, tells the decoder what to map to.
                let response = try decoder.decode(RecipesResponse.self, from: data)

                // Accessed the array of tracks from the `results` property
                let recipes = response.categories
                
                // Executed UI updates on the main thread when calling from a background callback
                DispatchQueue.main.async {

                    // Set the view controller's tracks property as this is the one the table view references
                    self?.recipes = recipes

                    // Made the table view reload now that we have new data
                    self?.tableView.reloadData()
                }
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }

        // Initiate the network request
        task.resume()
        
        tableView.dataSource = self
        searchBar.delegate = self
        
        // Setting row height to automatic
        // tableView.rowHeight = 155
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a cell with identifier, "RecipeCell"
        // the `dequeueReusableCell(withIdentifier:)` method just returns a generic UITableViewCell so it's necessary to cast it to our specific custom cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell

        // Get the recipe that corresponds to the table view row
        let recipe = recipes[indexPath.row]

        // Configure the cell with it's associated track
        cell.configure(with: recipe)

        // return the cell for display in the table view
        return cell
    }
/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Pt 1 - Pass the selected recipe to the stream view controller
        // Get the cell that triggered the segue
        if let cell = sender as? UITableViewCell,
           // Get the index path of the cell from the table view
           let indexPath = tableView.indexPath(for: cell),
           // Get the stream view controller
           let streamViewController = segue.destination as? StreamViewController {

            // Use the index path to get the associated track
            let recipe = recipes[indexPath.row]

            // Set the recipe on the stream view controller
            streamViewController.recipe = recipe
        }
    }
*/
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        if let searchText = searchBar.text, !searchText.isEmpty {
            if let searchViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
                searchViewController.searchQuery = searchText
                self.navigationController?.pushViewController(searchViewController, animated: true)
            }
        }
    }

    // Deselecting the row after a short delay
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get the index path for the current selected table view row (if exists)
        if let indexPath = tableView.indexPathForSelectedRow {

            // Deselected the row at the corresponding index path
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
   
}

    
    

