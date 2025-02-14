import SwiftUI

struct ScanHistoryView: View {
    // MARK: - Environment Objects
    @EnvironmentObject var historyViewModel: ScanHistoryViewModel

    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                scanSessionsList
            }
            .navigationTitle("History Scan")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .foregroundColor(.green)
                }
            }
        }
    }

    // MARK: - Scan Sessions List
    private var scanSessionsList: some View {
        ForEach(historyViewModel.scanSessions) { session in
            VStack(alignment: .leading) {
                Text("Session: \(session.timestamp.formatted())")
                    .font(.headline)

                Text("Bluetooth devices: \(session.bluetoothDevices.count)")
                Text("LAN devices: \(session.lanDevices.count)")

                NavigationLink("Details", destination: ScanSessionDetailView(session: session))
            }
        }
        .onDelete(perform: historyViewModel.deleteScanSession)
    }
}
