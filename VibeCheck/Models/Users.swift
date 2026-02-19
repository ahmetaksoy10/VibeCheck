import Foundation

struct Users: Codable {
    let id: String
    let email: String
    var username: String
    var profileImageUrl: String?
}
