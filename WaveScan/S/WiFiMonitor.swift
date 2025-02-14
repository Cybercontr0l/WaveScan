import SwiftUI
import Network

class WiFiMonitor: ObservableObject {
    // MARK: - Properties
    @Published var isWiFiConnected: Bool = false
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "WiFiMonitorQueue")

    // MARK: - Initializer
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isWiFiConnected = path.usesInterfaceType(.wifi)
            }
        }
        monitor.start(queue: queue)
    }
}
