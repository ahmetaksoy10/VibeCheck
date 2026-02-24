import Foundation
import FirebaseFirestore
import FirebaseAuth

class ProfileViewViewModel {
    var errorMessage = ""
    var userArray: [Users] = []
    
    func getDataFromFireBase(content: @escaping (Bool) -> Void) {
        let firestoreDataBase = Firestore.firestore()
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            errorMessage = "Kullanıcı bulunamadı."
            content(false)
            return
        }
        
        firestoreDataBase.collection("Users").whereField("id", isEqualTo: currentUserId).addSnapshotListener {[weak self] snapshot, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                content(false)
                return
            }
            
            guard let document = snapshot?.documents else{
                self?.errorMessage = "Hiç veri bulunamadı."
                content(false)
                return
            }
            
            self?.userArray = document.compactMap({ document in
                do {
                    return try document.data(as: Users.self)
                } catch {
                    print("Error")
                    return nil
                }
            })
            
            content(true)
            
        }
    }
}
