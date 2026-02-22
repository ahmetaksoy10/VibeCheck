import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewViewModel {
    var errorMessage = ""
    
    func uploadPosts (image: UIImage, caption: String, completion: @escaping(Bool) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            self.errorMessage = "Fotoğraf işlenirken bir hata oluştu."
            completion(false)
            return
        }
        
        guard let currentUserEmail = Auth.auth().currentUser?.email else {
            self.errorMessage = "Oturum açmış bir kullanıcı bulunamadı."
            completion(false)
            return
        }
        
        let uuid = UUID().uuidString
        let reference = Storage.storage().reference().child("PostImages").child("\(uuid).jpg")
        reference.putData(imageData) {[weak self] metaData, error in
            if let error = error {
                self?.errorMessage = "Fotoğraf yüklenemedi: \(error.localizedDescription)"
                completion(false)
                return
            }
            
            reference.downloadURL {[weak self] url, error in
                guard let imageURL = url?.absoluteString else {
                    self?.errorMessage = "Fotoğrafın linki alınamadı."
                    completion(false)
                    return
                }
                
                self?.savePostToFirestore(UserEmail: currentUserEmail, imageUrl: imageURL, caption: caption, completion: completion)
            }
        }
    }
    
    private func savePostToFirestore(UserEmail: String, imageUrl: String, caption: String, completion: @escaping(Bool) -> Void) {
        let firestoreDataBase = Firestore.firestore()
        let newDocument = firestoreDataBase.collection("Posts").document()
        let newPosts = Posts(
            postID: newDocument.documentID,
            caption: caption,
            authorEmail: UserEmail,
            imageUrl: imageUrl,
            timestamp: Date().timeIntervalSince1970
        )
        do {
            try newDocument.setData(from: newPosts) { error in
                if let error = error {
                    self.errorMessage = "Gönderi paylaşılamadı: \(error.localizedDescription)"
                    completion(false)
                } else {
                    completion(true)
                }
            }
        } catch {
            self.errorMessage = "Veri formatı dönüştürülemedi."
            completion(false)
        }
    }
}
