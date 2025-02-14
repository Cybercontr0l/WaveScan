import Foundation
import CoreBluetooth

class BluetoothScannerService: NSObject, CBCentralManagerDelegate {
    // MARK: - Properties
    var centralManager: CBCentralManager!
    var discoveredPeripherals: [CBPeripheral] = []

    // MARK: - Initializer
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    // MARK: - CBCentralManagerDelegate Methods
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            startScan()
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi: NSNumber) {
        discoveredPeripherals.append(peripheral)
    }

    // MARK: - Scanning Methods
    func stopScan() {
        centralManager.stopScan()
    }

    func startScan() {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
}
