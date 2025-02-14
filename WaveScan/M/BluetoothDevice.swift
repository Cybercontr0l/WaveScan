import Foundation

struct BluetoothDevice: Identifiable, Codable {
    var id: String { uuid }
    let name: String
    let uuid: String
    let rssi: Int
    let status: String
}
