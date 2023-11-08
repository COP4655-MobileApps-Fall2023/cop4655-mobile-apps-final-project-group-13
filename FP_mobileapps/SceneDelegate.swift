import ParseSwift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }

        NotificationCenter.default.addObserver(forName: Notification.Name("login"), object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.login()
        }

        NotificationCenter.default.addObserver(forName: Notification.Name("logout"), object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.logOut()
        }

        // Check if a current user exists
        if let currentUser = User.current {
            print("Logged in user: \(currentUser)")
            login()
        } else {
            print("No user logged in")
        }
    }

    private func login() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginNavigationController = storyboard.instantiateViewController(withIdentifier: "LoginNavigationController") as? UINavigationController {
            window?.rootViewController = loginNavigationController
        }
    }

    private func logOut() {
        User.logout { [weak self] result in
            switch result {
            case .success:
                // Make sure UI updates are done on the main thread when initiated from a background thread.
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let loginNavigationController = storyboard.instantiateViewController(withIdentifier: "LoginNavigationController") as? UINavigationController {
                        self?.window?.rootViewController = loginNavigationController
                    }
                }
            case .failure(let error):
                print("❌ Log out error: \(error)")
            }
        }
    }

    // Implement other scene-related methods here...
}




