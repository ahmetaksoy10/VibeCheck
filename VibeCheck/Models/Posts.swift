import Foundation

struct Posts: Codable {
    let postID: String
    var caption: String
    let authorID: String
    let imageUrl: String
    let timestamt: Double
}
