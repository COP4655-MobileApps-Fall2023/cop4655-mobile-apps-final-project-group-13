//
//  UserMealCell.swift
//  FP_mobileapps
//
//  Created by Christian on 12/5/23.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class PostCell: UITableViewCell {
    @IBOutlet private weak var recipeTitle: UILabel!
    @IBOutlet private weak var postImage: UIImageView!

    @IBOutlet weak var blurView: UIVisualEffectView!
    
    private var imageDataRequest: DataRequest?
    
    // Closure to handle delete button action
    var deleteButtonAction: (() -> Void)?

    func configure(with post: Post) {
        
        // Image
        if let imageFile = post.imageFile,
           let imageUrl = imageFile.url {
            
            //
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    // Set image view image with fetched image
                    self?.postImage.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }

        // Title
        recipeTitle.text = post.title

        
        

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: P1 - Cancel image download
        // Reset image view image.
        postImage.image = nil

        // Cancel image request.
        imageDataRequest?.cancel()

    }
    
    // Configure delete button
        private func setupDeleteButton() {
            let deleteButton = UIButton(type: .system)
            deleteButton.setTitle("Delete", for: .normal)
            deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
            accessoryView = deleteButton
        }

        // Handle delete button tap
        @objc private func deleteButtonTapped() {
            deleteButtonAction?()
        }
    
}
