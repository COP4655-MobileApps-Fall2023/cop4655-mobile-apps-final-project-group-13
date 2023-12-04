//
//  SearchViewController.swift
//  FP_mobileapps
//
//  Created by Richelle Plummer on 11/22/23.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    // Array to store search results
    var searchResults: [Meal] = []
    var searchQuery: String?
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set data source and delegate for the table view
        tableView.dataSource = self
        tableView.delegate = self
        
        //set delegate for the search text field
        searchTextField.delegate = self
        
        if let query = searchQuery, !query.isEmpty{
            performSearch(query: query)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        //return the number of rows in the table view
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealCell

            let meal = searchResults[indexPath.row]

            cell.configure(with: meal)

            return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //dismiss the keyboard when return key is pressed
            textField.resignFirstResponder()

            if let searchText = textField.text, !searchText.isEmpty {
                performSearch(query: searchText)
            }

            return true
        }

    func performSearch(query: String) {
        // Convert the query to lowercase
        let lowercaseQuery = query.lowercased()

        // Search URL with the lowercase query
        let searchURL = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(lowercaseQuery)"

        guard let url = URL(string: searchURL) else {
            print("Error: Invalid URL")
            return
        }

        fetchData(from: url)
    }
    
    func fetchData(from url: URL) {
        //perform data fetching using URLSession
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

                //print(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")
                
                do {
                    //print to show data pulled
                    //print("JSON Data: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")")

                    //decode jsondata
                    let decoder = JSONDecoder()
                    let meals = try decoder.decode(MealsResponse.self, from: data)
                    
                   // print("Decoded Meals: \(meals)")

                    DispatchQueue.main.async {
                        self?.searchResults = meals.meals
                        self?.tableView.reloadData()
                        print("Search successful! Found \(meals.meals.count) recipes.")
                    }
                } catch let decodingError {
                    print("❌ Error decoding JSON: \(decodingError)")
                    DispatchQueue.main.async {
                            self?.showNoResultsAlert()
                        }
                } catch {
                    print("❌ Unknown error: \(error)")
                 //   self?.showNoResultsAlert()
                }
            }

            task.resume()
        }

    func showNoResultsAlert(){
        let alert = UIAlertController(title: "No Results", message: "No Results shown for given search", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeal = searchResults[indexPath.row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchDetails" {
            if let indexPath = tableView.indexPathForSelectedRow,
               let detailViewController = segue.destination as? RecipeDetailsController {
                let selectedMeal = searchResults[indexPath.row]
                detailViewController.meal = selectedMeal
            }
        }
    }
    
}
