import Foundation

class ScanHistoryViewModel: ObservableObject {
    // MARK: - Properties
    @Published var scanSessions: [ScanSession] = []
    
    // MARK: - Initializer
    init() {
        loadScanSessions()
    }
    
    // MARK: - Methods
    func loadScanSessions() {
        self.scanSessions = DatabaseService.shared.fetchScanSessions()
    }
    
    func saveScanSession(bluetoothDevices: [BluetoothDevice], lanDevices: [LANDevice]) {
        DatabaseService.shared.saveScanSession(bluetoothDevices: bluetoothDevices, lanDevices: lanDevices)
        loadScanSessions()
    }
    
    func deleteScanSession(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let session = scanSessions[index]
        DatabaseService.shared.deleteScanSession(session)
        loadScanSessions()
    }
}
