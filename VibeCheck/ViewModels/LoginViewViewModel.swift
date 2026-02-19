import Foundation
import FirebaseAuth

class LoginViewViewModel {
    var email = ""
    var password = ""
    var errorMessage = ""
    
    func login(completion: @escaping (Bool) -> Void) {
        guard validate() else {
            completion(false)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            
            if let error = error {
                self?.errorMessage = error.localizedDescription
                completion(false)
            } else {
                completion(true)
                
            }
        }
    }
    
    func validate() -> Bool {
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
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
