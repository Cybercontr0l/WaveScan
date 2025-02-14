import SwiftUI

struct DeviceDetailView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: DeviceDetailViewModel

    // MARK: - Body
    var body: some View {
        VStack {
            deviceTitle
            deviceDetailsList
        }
        .navigationTitle("Details")
        .padding()
    }

    // MARK: - Subviews
    private var deviceTitle: some View {
        Text(viewModel.deviceName)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
    }

    private var deviceDetailsList: some View {
        List(viewModel.details.keys.sorted(), id: \.self) { key in
            HStack {
                Text(key)
                    .fontWeight(.medium)
                Spacer()
                Text(viewModel.details[key] ?? "—")
                    .foregroundColor(.gray)
            }
        }
    }
}
