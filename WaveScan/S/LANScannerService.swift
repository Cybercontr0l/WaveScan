import Foundation
import MMLanScan

class LANScannerService: NSObject, MMLANScannerDelegate {
    // MARK: - Properties
    var lanScanner: MMLANScanner!
    
    // MARK: - Initializer
    override init() {
        super.init()
        lanScanner = MMLANScanner(delegate: self)
    }

    // MARK: - Scanning Methods
    func startScan() {
        lanScanner.start()
    }

    func stopScan() {
        lanScanner.stop()
    }

    // MARK: - MMLANScannerDelegate Methods
    func lanScanDidFindNewDevice(_ device: MMDevice!) {
        print("Found new device: \(device.hostname ?? "Unknown")")
    }

    func lanScanDidFinishScanning(with status: MMLanScannerStatus) {
        print("Scan finished with status: \(status)")
    }

    func lanScanProgressPinged(_ pingedHosts: Float, from overallHosts: Int) {
        print("Pinged \(pingedHosts) of \(overallHosts) hosts.")
    }

    func lanScanDidFailedToScan() {
        print("Scan failed.")
    }
}
