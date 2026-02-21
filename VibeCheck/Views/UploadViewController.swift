//
//  UploadView.swift
//  VibeCheck
//
//  Created by MacBook Pro on 19.02.2026.
//

import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func showAlert(messageInput: String) {
        let alert = UIAlertController(title: "Error", message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            imageView.image = originalImage
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let uploadViewModel = UploadViewViewModel()
        if let selectedImage = imageView.image {
            if selectedImage != UIImage(systemName: "photo.fill") {
                uploadViewModel.uploadPosts(image: selectedImage, caption: captionField.text!) { checkUpload in
                    if checkUpload {
                        self.imageView.image = UIImage(systemName: "photo.fill")
                        self.captionField.text = ""
                        self.tabBarController?.selectedIndex = 0
                    } else {
                        self.showAlert(messageInput: uploadViewModel.errorMessage)
                    }
                }
            } else {
                self.showAlert(messageInput: "Lütfen paylaşmak için bir fotoğraf seçin.")
            }
        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        imageView.image = UIImage(systemName: "photo.fill")
        captionField.text = ""
        tabBarController?.selectedIndex = 0
    }
    
}
