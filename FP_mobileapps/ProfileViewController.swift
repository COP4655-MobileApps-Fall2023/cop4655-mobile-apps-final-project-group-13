//
//  ProfileViewController.swift
//  FP_mobileapps
//
//  Created by Christian on 11/14/23.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserData()
    }
    
  
    private func loadUserData(){
        if let currentUser = User.current {
                fullNameLabel.text = currentUser.fullName

                // Safely unwrap the optional username
                if let username = currentUser.username {
                    // Concatenate "@" with the username
                    let formattedUsername = "@" + username
                    usernameLabel.text = formattedUsername
                } else {
                    // Handle the case where the username is nil
                    usernameLabel.text = "@UnknownUser"
                }

                
               
            } else {
                showAlert(description: "User not Found")
            }    }
    
    @IBAction func onLogOutTapped(_ sender: Any) {
        showConfirmLogoutAlert()
    }
    
    private func showConfirmLogoutAlert() {
        let alertController = UIAlertController(title: "Log out of your account?", message: nil, preferredStyle: .alert)
        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
}
