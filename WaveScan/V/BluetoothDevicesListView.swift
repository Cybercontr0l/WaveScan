/*FOR 2 differ buttons BT/WIFI scaner
 
 import SwiftUI

struct BluetoothDevicesListView: View {
    @ObservedObject var bluetoothViewModel: BluetoothScannerViewModel

    var body: some View {
        VStack {
            if bluetoothViewModel.isScanning {
                ProgressView("Scanning...")
                    .progressViewStyle(CircularProgressViewStyle())
            }
            List(bluetoothViewModel.discoveredDevices) { device in
                NavigationLink(destination: DeviceDetailView(viewModel: DeviceDetailViewModel(bluetoothDevice: device))) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(device.name)
                                .font(.headline)
                            Text("UUID: \(device.uuid)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("\(device.rssi) dBm")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .navigationTitle("Bluetooth-device")
        .onAppear {
            bluetoothViewModel.startScan() // Начать сканирование при загрузке экрана
        }
    }
}
*/
