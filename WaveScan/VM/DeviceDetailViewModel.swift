import Foundation

class DeviceDetailViewModel: ObservableObject {
    // MARK: - Properties
    @Published var deviceName: String
    @Published var details: [String: String] = [:]

    // MARK: - Initializers
    init(bluetoothDevice: BluetoothDevice) {
        self.deviceName = bluetoothDevice.name
        self.details = [
            "UUID": bluetoothDevice.uuid,
            "RSSI": "\(bluetoothDevice.rssi) dBm",
            "Статус": bluetoothDevice.status
        ]
    }

    init(lanDevice: LANDevice) {
        self.deviceName = lanDevice.name ?? "Неизвестное устройство"
        self.details = [
            "IP-адрес": lanDevice.ip,
            "MAC-адрес": lanDevice.mac ?? "Неизвестен"
        ]
    }
}
