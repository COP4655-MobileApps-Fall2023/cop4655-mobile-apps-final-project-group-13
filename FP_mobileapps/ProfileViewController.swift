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
    @IBOutlet weak var tableView: UITableView!
    
    private var posts = [Post]() {
        didSet {
            // Reload table view data any time the posts variable gets updated.
            tableView.reloadData()
        }
    }
    
    let avatarImages = [
        "avatar1",
        "avatar2",
        "avatar3",
        "avatar4",
        "avatar5",
        "avatar6",
        "avatar7",
        "avatar8",
        "avatar9",
        "avatar10",
        "avatar11",
        "avatar12",
        "avatar13",
        "avatar14",
        "avatar15"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserData()
        
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(profilePicTapped))
        profilePic.addGestureRecognizer(tapGesture)
        profilePic.isUserInteractionEnabled = true
        
        // Load the selected avatar from UserDefaults
        if let selectedAvatar = UserDefaults.standard.string(forKey: "selectedAvatar") {
                   profilePic.image = UIImage(named: selectedAvatar)
               }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        queryPosts()
    }
    
    private func queryPosts() {
        
        // 1. Create a query to fetch Posts
        // 2. Any properties that are Parse objects are stored by reference in Parse DB and as such need to explicitly use `include_:)` to be included in query results.
        // 3. Sort the posts by descending order based on the created at date
        
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: (-1), to: Date())!
        let query = Post.query()
            .include("user")
            .order([.descending("createdAt")])
            .limit(6) // <- Limit max number of returned posts to 6

        // Fetch objects (posts) defined in query (async)
        query.find { [weak self] result in
            switch result {
            case .success(let posts):
                // Update local posts property with fetched posts
                self?.posts = posts
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
        }
// https://github.com/parse-community/Parse-Swift/blob/3d4bb13acd7496a49b259e541928ad493219d363/ParseSwift.playground/Pages/2%20-%20Finding%20Objects.xcplaygroundpage/Contents.swift#L66


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
            }
        
    }
    
    @objc func profilePicTapped(){
        let alertController = UIAlertController(title: "Select Avatar", message: nil, preferredStyle: .actionSheet)

                // Add action for each avatar image
                for avatarName in avatarImages {
                    if let image = UIImage(named: avatarName) {
                        let action = UIAlertAction(title: "", style: .default) { [weak self] _ in
                            // Set the selected avatar to the profile picture
                            self?.profilePic.image = image

                            // Save the selected avatar name to UserDefaults
                            UserDefaults.standard.set(avatarName, forKey: "selectedAvatar")
                            
                            // Synchronize UserDefaults to ensure data is saved immediately
                            UserDefaults.standard.synchronize()
                        }

                        // Add a preview image to the action
                        action.setValue(image.withRenderingMode(.alwaysOriginal), forKey: "image")

                        alertController.addAction(action)
                    }
                }

                // Add a cancel action
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)

                // Present the alert controller
                present(alertController, animated: true, completion: nil)
            }
    
    
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


extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        cell.configure(with: posts[indexPath.row])
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate { }
