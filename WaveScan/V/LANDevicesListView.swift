/*FOR 2 differ buttons BT/WIFI sca
 import SwiftUI

struct LANDevicesListView: View {
    @ObservedObject var lanViewModel: LANScannerViewModel

    var body: some View {
        VStack {
            Button(action: {
                if lanViewModel.isScanning {
                    lanViewModel.stopScan()
                } else {
                    lanViewModel.scanNetwork()
                }
            }) {
                Text(lanViewModel.isScanning ? "Остановить сканирование" : "Начать сканирование")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(lanViewModel.isScanning ? Color.red : Color.green)
                    .cornerRadius(10)
            }

            List(lanViewModel.discoveredDevices) { device in
                NavigationLink(destination: DeviceDetailView(viewModel: DeviceDetailViewModel(lanDevice: device))) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(device.name ?? "Неизвестное устройство")
                                .font(.headline)
                            Text("IP: \(device.ip)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(device.mac ?? "Нет данных")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .navigationTitle("LAN-устройства")
    }
}*/
