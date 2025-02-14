import Foundation
import CoreBluetooth

class BluetoothScannerViewModel: NSObject, ObservableObject, CBCentralManagerDelegate {
    // MARK: - Properties
    @Published var discoveredDevices: [BluetoothDevice] = []
    @Published var isScanning: Bool = false
    @Published var isBluetoothOn: Bool = false
    
    private var centralManager: CBCentralManager!
    private var scanTimer: Timer?
    var saveSessionCallback: (() -> Void)?

    // MARK: - Initializer
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil) // Initialize central manager with self as delegate
    }

    // MARK: - Scanning Methods
    func startScan() {
        guard centralManager.state == .poweredOn else {
            print("❌ Bluetooth выключен или недоступен. Сканирование невозможно.")
            return
        }

        DispatchQueue.main.async {
            self.discoveredDevices.removeAll()
            self.isScanning = true
            print("✅ Сканирование Bluetooth начато")
        }

        centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])

        scanTimer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false) { _ in
            self.stopScan() // Automatically stop scanning after 15 seconds
            print("✅ Сканирование Bluetooth автоматически остановлено через 15 секунд")
        }
    }

    func stopScan() {
        centralManager.stopScan()
        isScanning = false
        scanTimer?.invalidate()
        scanTimer = nil

        DispatchQueue.main.async {
            self.saveSessionCallback?()
            print("✅ Сканирование Bluetooth остановлено")
        }
    }

    // MARK: - CBCentralManagerDelegate Methods
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        DispatchQueue.main.async {
            self.isBluetoothOn = central.state == .poweredOn
            if !self.isBluetoothOn {
                self.discoveredDevices.removeAll()
                print("⚠️ Bluetooth выключен")
            }
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard isBluetoothOn else { return }

        let device = BluetoothDevice(
            name: peripheral.name ?? "Unknown device",
            uuid: peripheral.identifier.uuidString,
            rssi: RSSI.intValue,
            status: "Available"
        )

        DispatchQueue.main.async {
            if !self.discoveredDevices.contains(where: { $0.uuid == device.uuid }) {
                self.discoveredDevices.append(device)
                print("✅ Найдено Bluetooth устройство: \(device.name)")
            }
        }
    }
}
