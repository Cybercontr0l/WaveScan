import Foundation

struct ScanSession: Identifiable, Codable {
    var id = UUID()
    let timestamp: Date
    let bluetoothDevices: [BluetoothDevice]
    let lanDevices: [LANDevice]
}
