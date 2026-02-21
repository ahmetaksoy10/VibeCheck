import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewViewModel {
    var email = ""
    var name = ""
    var password = ""
    var errorMessage = ""
    
    func register(completion: @escaping (Bool) -> Void) {
        guard validate() else {
            completion(false)
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) {authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion(false)
            } else {
                let firestore = Firestore.firestore().collection("Users")
                let userInfo = ["username": self.name, "email": self.email, "id": Auth.auth().currentUser!.uid, "profileImageUrl": ""] as [String: Any]
                firestore.addDocument(data: userInfo) { error in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
            }
        }
    }
    
    func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Lütfen boş yer bırakmayınız."
            return false
        }
        guard password.count >= 6 else {
            errorMessage = "Şifre en az 6 karakter olmalıdır."
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Lütfen geçerli bir mail adresi giriniz."
            return false
        }
        
        return true
    }
}
