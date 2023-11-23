//
//  SignUpViewController.swift
//  FP_mobileapps
//
//  Created by Richelle Plummer on 11/7/23.
//

import Foundation
import UIKit
import ParseSwift

class SignUpViewController: UIViewController{
    
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let text = "RecipEasy"
        let attributedText = NSMutableAttributedString(string: text)
        
        // Define the attributes for the first three letters (black color)
        let blackAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]
        
        // Define the attributes for the last four letters (#055C78 color)
        let customColor = UIColor(red: 5/255, green: 92/255, blue: 120/255, alpha: 1.0)
        let customColorAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: customColor
        ]
        
        // Apply the attributes to the specific ranges of text
        attributedText.addAttributes(blackAttributes, range: NSRange(location: 0, length: 5))
        attributedText.addAttributes(customColorAttributes, range: NSRange(location: text.count - 4, length: 4))
        
        // Set the attributed text to your label or text view
        appNameLabel.attributedText = attributedText
    }
    
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if let LoginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                // You can customize the presentation style here if needed.
                LoginViewController.modalPresentationStyle = .fullScreen
                present(LoginViewController, animated: true, completion: nil)
            }
    }
    
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        
        // Make sure all fields are non-nil and non-empty.
        guard let username = usernameField.text,
              let fullName = fullNameField.text,
              let password = passwordField.text,
              !username.isEmpty,
              !fullName.isEmpty,
              !password.isEmpty else {
            
            showMissingFieldsAlert()
            return
        }
        // TODO: Pt 1 - Parse user sign up
        var newUser = User()
        newUser.username = username
        newUser.fullName = fullName
        newUser.password = password
        
        newUser.signup { [weak self] result in
            
            switch result {
            case .success(let user):
                
                print("✅ Successfully signed up user \(user)")
                
                // Display the alert when signup is successful
                        let alert = UIAlertController(title: "Sign Up Successful", message: "Congratulations! Your account has been created.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                
                // Post a notification that the user has successfully signed up.
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
                
            case .failure(let error):
                // Failed sign up
                self?.showAlert(description: error.localizedDescription)
            }
        }
        
        
    }
    
    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Sign Up", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Opps...", message: "We need all fields filled out in order to sign you up.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
