//
//  EditProfileViewModel.swift
//  VibeCheck
//
//  Created by MacBook Pro on 23.02.2026.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class EditProfileViewViewModel {
    var errorMessage = ""
    
    func editUserInfo(profileImage: UIImage, username: String, completion: @escaping(Bool) -> Void) {
        guard let profileImageData = profileImage.jpegData(compressionQuality: 0.5) else {
            self.errorMessage = "Fotoğraf işlenirken bir hata oluştu."
            completion(false)
            return
        }
        
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            self.errorMessage = "Oturum açmış bir kullanıcı bulunamadı."
            completion(false)
            return
        }
        
        let uuid = UUID().uuidString
        let storageReference = Storage.storage().reference().child("ProfilePhoto").child("\(uuid).jpg")
        storageReference.putData(profileImageData) {[weak self] metaData, error in
            if let error = error {
                self?.errorMessage = "Fotoğraf yüklenemedi: \(error.localizedDescription)"
                completion(false)
                return
            }
            
            storageReference.downloadURL {[weak self] url, error in
                guard let imageURL = url?.absoluteString else {
                    self?.errorMessage = "Fotoğrafın linki alınamadı."
                    completion(false)
                    return
                }
                
                self?.updateDataInFirebase(profileImageUrl: imageURL, username: username, id: currentUserId, completion: completion)
            }
        }
    }
    
    private func updateDataInFirebase(profileImageUrl: String, username: String, id: String, completion: @escaping(Bool) -> Void) {
        let dataBase = Firestore.firestore()
        dataBase.collection("Users").whereField("id", isEqualTo: id).getDocuments {[weak self] snapshot, error in
            if let error = error {
                self?.errorMessage = "Kullanıcı aranırken hata oluştu: \(error.localizedDescription)"
                completion(false)
                return
            }
            
            guard let document = snapshot?.documents.first else {
                self?.errorMessage = "Kullanıcı profili veritabanında bulunamadı."
                completion(false)
                return
            }
            
            let documentId = document.documentID
            dataBase.collection("Users").document(documentId).updateData([
                "username": username,
                "profileImageUrl": profileImageUrl
            ]) { error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.errorMessage = "Profil güncellenemedi: \(error.localizedDescription)"
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
            }
        }
    }
}
