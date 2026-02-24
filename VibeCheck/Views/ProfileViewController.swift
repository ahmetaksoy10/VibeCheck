//
//  ProfileView.swift
//  VibeCheck
//
//  Created by MacBook Pro on 19.02.2026.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    let profileViewModel = ProfileViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileViewModel.getDataFromFireBase { checkUserInfo in
            if !checkUserInfo {
                self.showAlert(messageInput: self.profileViewModel.errorMessage)
            } else {
                if let user = self.profileViewModel.userArray.first,
                   let imageUrlString = user.profileImageUrl,
                   let url = URL(string: imageUrlString) {
                    self.userEmail.text = user.email
                    self.usernameLabel.text = user.username
                    self.profilePhoto.sd_setImage(with: url)
                } else {
                    self.showAlert(messageInput: "Profile image could not be loaded.")
                }
                
                
            }
        }
        
    }
   
    private func showAlert(messageInput: String) {
        let alert = UIAlertController(title: "Error", message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    @IBAction func editProfileButton(_ sender: Any) {
        performSegue(withIdentifier: "toEditProfile", sender: nil)
    }
    
}
