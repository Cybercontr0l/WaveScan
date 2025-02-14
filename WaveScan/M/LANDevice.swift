import Foundation

struct LANDevice: Identifiable, Codable {
    var id: String { mac ?? UUID().uuidString }
    let ip: String
    let mac: String?
    let name: String?
}
