import SwiftUI
import Network

struct MainScanView: View {
    // MARK: - Environment Objects
    @EnvironmentObject var bluetoothScanner: BluetoothScannerViewModel
    @EnvironmentObject var lanScanner: LANScannerViewModel
    @EnvironmentObject var historyViewModel: ScanHistoryViewModel
    @StateObject private var networkMonitor = WiFiMonitor()

    // MARK: - State Variables
    @State private var isScanning: Bool = false
    @State private var isSessionSaved: Bool = false
    @State private var isBluetoothEnabled: Bool = false
    @State private var animationIsPlaying: Bool = false
    @State private var showAlert: Bool = false
    @State private var animationTimer: Timer?

    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                if animationIsPlaying {
                    LottieView(
                        name: "flying_dots",
                        loopMode: .loop,
                        isPlaying: true
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.opacity)
                    .animation(.spring(duration: 4), value: animationIsPlaying)
                }

                VStack {
                    Spacer()

                    statusIndicators

                    LottieView(
                        name: "scanning_animation",
                        loopMode: .loop,
                        isPlaying: isScanning || animationIsPlaying
                    )
                    .frame(width: 400, height: 400)

                    Text(isScanning ? "Stop Wave Scan" : "Start Wave Scan")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 10)

                    Spacer()
                }
            }
            .navigationTitle("Wave Scan")
            .onAppear(perform: monitorBluetoothStatus)
            .onTapGesture {
                isScanning ? stopScanning() : startScanning()
            }
            .onChange(of: bluetoothScanner.isScanning, perform: handleScanningChange)
            .onChange(of: lanScanner.isScanning, perform: handleScanningChange)
            .onChange(of: bluetoothScanner.isBluetoothOn) { newValue in
                isBluetoothEnabled = newValue
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Scanning is not possible"),
                    message: Text("To start scanning, turn on Wi-Fi or Bluetooth."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    // MARK: - Status Indicators View
    private var statusIndicators: some View {
        HStack(spacing: 20) {
            StatusIndicator(
                icon: isBluetoothEnabled ? "dot.radiowaves.left.and.right" : "nosign",
                label: isBluetoothEnabled ? "Bluetooth On" : "Bluetooth Off",
                color: isBluetoothEnabled ? .green : .red
            )

            StatusIndicator(
                icon: networkMonitor.isWiFiConnected ? "wifi" : "wifi.slash",
                label: networkMonitor.isWiFiConnected ? "Wi-Fi Connected" : "No Wi-Fi",
                color: networkMonitor.isWiFiConnected ? .green : .red
            )
        }
        .padding()
    }

    // MARK: - Scanning Functions
    private func startScanning() {
        guard canStartScanning() else {
            showAlert = true
            return
        }

        isSessionSaved = false
        bluetoothScanner.startScan()
        lanScanner.scanNetwork()
        isScanning = true
        animationIsPlaying = true
        startAnimationTimer()
    }

    private func stopScanning() {
        bluetoothScanner.stopScan()
        lanScanner.stopScan()
        saveScanSession()
        isScanning = false
        animationIsPlaying = false
        stopAnimationTimer()
    }

    private func handleScanningChange(_ newValue: Bool) {
        if !bluetoothScanner.isScanning && !lanScanner.isScanning {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                stopScanning()
            }
        }
    }

    // MARK: - Session Management
    private func saveScanSession() {
        if !bluetoothScanner.isScanning && !lanScanner.isScanning && !isSessionSaved {
            historyViewModel.saveScanSession(
                bluetoothDevices: bluetoothScanner.discoveredDevices,
                lanDevices: lanScanner.discoveredDevices
            )
            isSessionSaved = true
        }
    }

    // MARK: - Device Status Monitoring
    private func monitorBluetoothStatus() {
        isBluetoothEnabled = bluetoothScanner.isBluetoothOn
    }

    private func canStartScanning() -> Bool {
        return networkMonitor.isWiFiConnected || isBluetoothEnabled
    }

    // MARK: - Animation Timer
    private func startAnimationTimer() {
        stopAnimationTimer()
        animationTimer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false) { _ in
            stopScanning()
        }
    }

    private func stopAnimationTimer() {
        animationTimer?.invalidate()
        animationTimer = nil
    }
}

// MARK: - Status Indicator Subview
private struct StatusIndicator: View {
    let icon: String
    let label: String
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
            Text(label)
                .foregroundColor(.gray)
        }
    }
}
