import Foundation
import FirebaseFirestore

class FeedViewViewModel {
    var postArrays : [Posts] = []
    var reloadTableView: (() -> Void)?
    var error: ((String) -> Void)?
    
    func fetchPosts() {
        let firestoreDataBase = Firestore.firestore()
        
        firestoreDataBase.collection("Posts").order(by: "timestamp", descending: true).addSnapshotListener {[weak self] snapshot, error in
            if let error = error {
                self?.error?(error.localizedDescription)
                return
            }
            guard let documents = snapshot?.documents else {
                self?.error?("Hiç gönderi bulunamadı.")
                return
            }
            
            self?.postArrays = documents.compactMap({ document in
                do {
                    return try document.data(as: Posts.self)
                } catch {
                    print("Error")
                    return nil
                }
            })
            
            self?.reloadTableView?()
        }
    }
}
