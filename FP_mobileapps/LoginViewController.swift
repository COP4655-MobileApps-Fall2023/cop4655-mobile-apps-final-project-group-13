import UIKit
import ParseSwift

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var appNameLabel: UILabel!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let text = "RecipEasy"
        let attributedText = NSMutableAttributedString(string: text)
        
        // Set the password field to secure text entry
            passwordField.isSecureTextEntry = true
        
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
    
    
// //temporary logout
//    @IBAction func onLogOutTapped(_ sender: Any) {
//        showConfirmLogoutAlert()
//    }
//
//    private func showConfirmLogoutAlert() {
//        let alertController = UIAlertController(title: "Log out of your account?", message: nil, preferredStyle: .alert)
//        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
//            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        alertController.addAction(logOutAction)
//        alertController.addAction(cancelAction)
//        present(alertController, animated: true)
//    }

   
    
    
    @IBAction func onLoginTapped(_ sender: Any) {
        
        guard let username = usernameField.text,
              let password = passwordField.text,
              !username.isEmpty,
              !password.isEmpty else {

            showMissingFieldsAlert()
            return
        }

        // TODO: Pt 1 - Log in the parse user
   
        User.login(username: username, password: password) { [weak self] result in

            switch result {
            case .success(let user):
                print("✅ Successfully logged in as user: \(user)")

                // Post a notification that the user has successfully logged in.
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)

            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
        }
        
    }
    
    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Log in", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }

    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Opps...", message: "We need all fields filled out in order to log you in.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    
}
