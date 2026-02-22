import Foundation

struct Posts: Codable {
    let postID: String
    var caption: String
    let authorEmail: String
    let imageUrl: String
    let timestamp: Double
}
