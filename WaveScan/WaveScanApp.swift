import SwiftUI

@main
struct WaveScanApp: App {
    @StateObject private var bluetoothScanner = BluetoothScannerViewModel()
    @StateObject private var lanScanner = LANScannerViewModel()
    @StateObject private var historyViewModel = ScanHistoryViewModel()
    
    @State private var isActive = true
    

    var body: some Scene {
        WindowGroup {
            Group {
                if isActive {
                    LaunchScreenView(isActive: $isActive)
                } else {
                    TabBarView() 
                        .environmentObject(bluetoothScanner)
                        .environmentObject(lanScanner)
                        .environmentObject(historyViewModel)
                        .preferredColorScheme(.dark)
                }
            }
        }
    }
}
