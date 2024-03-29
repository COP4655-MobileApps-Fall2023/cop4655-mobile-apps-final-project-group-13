//
//  RecipeCreationController.swift
//  FP_mobileapps
//
//  Created by Christian on 12/5/23.
//

import Foundation
import UIKit
import PhotosUI
import ParseSwift

class RecipeCreationController: UIViewController {
    @IBOutlet weak var submitButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var preparationTextView: UITextView!
    @IBOutlet weak var previewImageView: UIImageView!
    
   // var descriptionCompletion: ((String) -> Void)?
    
    private var pickedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onPickedImageTapped(_ sender: UIButton) {
        // Create a configuration object
        var config = PHPickerConfiguration()
        
        // Set the filter to only show images as options (i.e. no videos, etc.).
        config.filter = .images
        
        // Request the original file format. Fastest method as it avoids transcoding.
        config.preferredAssetRepresentationMode = .current
        
        // Only allow 1 image to be selected at a time.
        config.selectionLimit = 1
        
        // Instantiate a picker, passing in the configuration.
        let picker = PHPickerViewController(configuration: config)
        
        // Set the picker delegate so we can receive whatever image the user picks.
        picker.delegate = self
        
        // Present the picker
        present(picker, animated: true)
        
    }
    
    
    
    @IBAction func onShareTapped(_ sender: Any) {

//        showDescriptionAlert { description in
//                // Save the description or pass it to the label on the profile screen
//            self.saveRecipeWithDescription(description)
//                // Call the completion closure to pass the description back to the presenting view controller
//            self.descriptionCompletion?(description)
//            }
        // Dismiss Keyboard
        view.endEditing(true)

        // TODO: Pt 1 - Create and save Post
        // Unwrap optional pickedImage
        guard let image = pickedImage,
              // Create and compress image data (jpeg) from UIImage
              let imageData = image.jpegData(compressionQuality: 0.1) else {
            return
        }

        // Create a Parse File by providing a name and passing in the image data
        let imageFile = ParseFile(name: "image.jpg", data: imageData)

        // Create Post object
        var post = Post()

        // Set properties
        post.imageFile = imageFile
        post.title = titleTextField.text
        post.ingredients = ingredientsTextView.text
        post.preparation = preparationTextView.text

        // Set the user as the current user
        post.user = User.current

        // Save object in background (async)
        post.save { [weak self] result in

            // Switch to the main thread for any UI updates
            DispatchQueue.main.async {
                switch result {
                case .success(let post):
                    print("✅ Post Saved! \(post)")
                    // Get the current user
                    if var currentUser = User.current {

                        // Update the `lastPostedDate` property on the user with the current date.
                        currentUser.lastPostedDate = Date()

                        // Save updates to the user (async)
                        currentUser.save { [weak self] result in
                            switch result {
                            case .success(let user):
                                print("✅ User Saved! \(user)")

                                // Switch to the main thread for any UI updates
                                DispatchQueue.main.async {
                                    // Return to previous view controller
                                    self?.navigationController?.popViewController(animated: true)
                                }

                            case .failure(let error):
                                self?.showAlert(description: error.localizedDescription)
                            }
                        }
                    }

                    // Return to previous view controller
                    self?.navigationController?.popViewController(animated: true)

                case .failure(let error):
                    self?.showAlert(description: error.localizedDescription)
                }
            }
        }


    }
    
//    private func showDescriptionAlert(completion: @escaping (String) -> Void) {
//        let alertController = UIAlertController(title: "Recipe Description", message: "Enter a description for your recipe", preferredStyle: .alert)
//
//        alertController.addTextField { textField in
//            textField.placeholder = "Description"
//        }
//
//        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
//            if let description = alertController.textFields?.first?.text {
//                // Save the description or pass it to the label on the profile screen
//                completion(description)
//            }
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        alertController.addAction(submitAction)
//        alertController.addAction(cancelAction)
//
//        present(alertController, animated: true)
//    }
    
    
//    private func saveRecipeWithDescription(_ description: String) {
//        // Unwrap optional pickedImage
//            guard let image = pickedImage,
//                  // Create and compress image data (jpeg) from UIImage
//                  let imageData = image.jpegData(compressionQuality: 0.1) else {
//                return
//            }
//
//            // Create a Parse File by providing a name and passing in the image data
//            let imageFile = ParseFile(name: "image.jpg", data: imageData)
//
//            // Create Post object
//            var post = Post()
//
//            // Set properties
//            post.imageFile = imageFile
//            post.title = titleTextField.text
//            post.ingredients = ingredientsTextView.text
//            post.preparation = preparationTextView.text
//
//            // Set the description
//            post.description = description
//
//            // Set the user as the current user
//            post.user = User.current
//
//            // Save object in the background (async)
//            post.save { [weak self] result in
//                // Switch to the main thread for any UI updates
//                DispatchQueue.main.async {
//                    switch result {
//                    case .success(let post):
//                        print("✅ Post Saved! \(post)")
//                        // Get the current user
//                        if var currentUser = User.current {
//                            // Update the `lastPostedDate` property on the user with the current date.
//                            currentUser.lastPostedDate = Date()
//
//                            // Save updates to the user (async)
//                            currentUser.save { [weak self] result in
//                                switch result {
//                                case .success(let user):
//                                    print("✅ User Saved! \(user)")
//                                    // Switch to the main thread for any UI updates
//                                    DispatchQueue.main.async {
//                                        // Return to the previous view controller
//                                        self?.navigationController?.popViewController(animated: true)
//                                    }
//
//                                case .failure(let error):
//                                    self?.showAlert(description: error.localizedDescription)
//                                }
//                            }
//                        }
//
//                        // Return to the previous view controller
//                        self?.navigationController?.popViewController(animated: true)
//
//                    case .failure(let error):
//                        self?.showAlert(description: error.localizedDescription)
//                    }
//                }
//            }
//    }
    
    
    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}


extension RecipeCreationController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // Dismiss the picker
        picker.dismiss(animated: true)

        // Make sure we have a non-nil item provider
        guard let provider = results.first?.itemProvider,
           // Make sure the provider can load a UIImage
           provider.canLoadObject(ofClass: UIImage.self) else { return }

        // Load a UIImage from the provider
        provider.loadObject(ofClass: UIImage.self) { [weak self] object, error in

           // Make sure we can cast the returned object to a UIImage
           guard let image = object as? UIImage else {

              // ❌ Unable to cast to UIImage
              self?.showAlert()
              return
           }

           // Check for and handle any errors
           if let error = error {
              self?.showAlert()
              return
           } else {

              // UI updates (like setting image on image view) should be done on main thread
              DispatchQueue.main.async {

                 // Set image on preview image view
                 self?.previewImageView.image = image

                 // Set image to use when saving post
                 self?.pickedImage = image
              }
           }
        }
    }
    
    
}
