import SwiftUI

struct ScanSessionDetailView: View {
    // MARK: - Properties
    let session: ScanSession
    @EnvironmentObject var historyViewModel: ScanHistoryViewModel

    // MARK: - Body
    var body: some View {
        List {
            bluetoothDevicesSection
            lanDevicesSection
        }
        .navigationTitle("Session Details")
        .toolbar {
            deleteButton
        }
    }

    // MARK: - Sections
    private var bluetoothDevicesSection: some View {
        Section(header: Text("Bluetooth Devices")) {
            ForEach(session.bluetoothDevices) { device in
                NavigationLink(destination: DeviceDetailView(viewModel: DeviceDetailViewModel(bluetoothDevice: device))) {
                    Text(device.name)
                }
            }
        }
    }

    private var lanDevicesSection: some View {
        Section(header: Text("LAN Devices")) {
            ForEach(session.lanDevices) { device in
                NavigationLink(destination: DeviceDetailView(viewModel: DeviceDetailViewModel(lanDevice: device))) {
                    Text(device.name ?? "Unknown Device")
                }
            }
        }
    }

    // MARK: - Toolbar Button
    private var deleteButton: some View {
        Button(action: deleteSession) {
            Image(systemName: "trash")
                .foregroundColor(.green)
        }
    }

    // MARK: - Methods
    private func deleteSession() {
        if let index = historyViewModel.scanSessions.firstIndex(where: { $0.id == session.id }) {
            historyViewModel.deleteScanSession(at: IndexSet([index]))
        }
    }
}
