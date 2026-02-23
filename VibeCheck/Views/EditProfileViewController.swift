//
//  EditProfileViewController.swift
//  VibeCheck
//
//  Created by MacBook Pro on 23.02.2026.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var ProfileImage: UIImageView!
    let editProfileViewModel = EditProfileViewViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        ProfileImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectProfilePhoto))
        ProfileImage.addGestureRecognizer(gesture)
    }
    
    @objc func selectProfilePhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            ProfileImage.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            ProfileImage.image = originalImage
        }
        self.dismiss(animated: true)
    }
    
    func showAlert(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }

    @IBAction func saveButton(_ sender: Any) {
        if let image = ProfileImage.image {
            if image != UIImage(systemName: "person.crop.circle") {
                editProfileViewModel.editUserInfo(profileImage: image, username: usernameTextField.text!) { checkEditUserInfo in
                    if !checkEditUserInfo {
                        self.showAlert(errorMessage: self.editProfileViewModel.errorMessage)
                    } else {
                        self.dismiss(animated: true)
                        self.ProfileImage.image = UIImage(systemName: "person.crop.circle")
                        self.usernameTextField.text = ""
                    }
                }
            } else {
                self.showAlert(errorMessage: "Lütfen paylaşmak için bir fotoğraf seçin.")
            }
        }
    }
}
