import Foundation
import MMLanScan

class LANScannerViewModel: NSObject, ObservableObject, MMLANScannerDelegate {
    // MARK: - Properties
    @Published var discoveredDevices: [LANDevice] = []
    @Published var isScanning: Bool = false
    private var lanScanner: MMLANScanner?
    private var scanTimer: Timer?
    private var isScanCompleted: Bool = false

    var saveSessionCallback: (() -> Void)?

    // MARK: - Initializer
    override init() {
        super.init()
        self.lanScanner = MMLANScanner(delegate: self)
    }

    // MARK: - Scanning Methods
    func scanNetwork() {
        discoveredDevices.removeAll()
        isScanning = true
        isScanCompleted = false
        lanScanner?.start()

        scanTimer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false) { _ in
            self.stopScan()
        }
    }

    func stopScan() {
        if isScanCompleted { return }

        lanScanner?.stop()
        isScanning = false
        isScanCompleted = true
        scanTimer?.invalidate()
        scanTimer = nil

        DispatchQueue.main.async {
            self.saveSessionCallback?()
        }
    }

    // MARK: - MMLANScannerDelegate Methods
    func lanScanDidFindNewDevice(_ device: MMDevice!) {
        DispatchQueue.main.async {
            let newDevice = LANDevice(
                ip: device.ipAddress ?? "unknown",
                mac: device.macAddress ?? "no data",
                name: device.hostname ?? "unknown device"
            )

            let isDuplicate = self.discoveredDevices.contains { existingDevice in
                return (existingDevice.mac == newDevice.mac && newDevice.mac != "No data") ||
                       (existingDevice.ip == newDevice.ip)
            }

            if !isDuplicate {
                self.discoveredDevices.append(newDevice)
            }
        }
    }

    func lanScanDidFinishScanning(with status: MMLanScannerStatus) {
        print("✅ Сканирование завершено. Статус: \(status.rawValue)")
    }

    func lanScanDidFailedToScan() {
        print("⚠️ Ошибка сканирования LAN!")
        stopScan()
    }
}
