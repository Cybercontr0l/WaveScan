import SwiftUI

struct TabBarView: View {
    // MARK: - Environment
    @EnvironmentObject var historyViewModel: ScanHistoryViewModel

    // MARK: - Init
    init() {
        setupTabBarAppearance()
    }

    var body: some View {
        TabView {
            MainScanView()
                .tabItem {
                    Image("scaner")
                    Text("Scanner")
                }

            ScanHistoryView()
                .tabItem {
                    Image("history_jorunal")
                    Text("Journal")
                }
        }
    }

    // MARK: - Private Methods
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black

        let normalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray]
        let selectedAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]

        let stackedLayout = appearance.stackedLayoutAppearance
        stackedLayout.normal.iconColor = .gray
        stackedLayout.normal.titleTextAttributes = normalAttributes
        stackedLayout.selected.iconColor = .white
        stackedLayout.selected.titleTextAttributes = selectedAttributes

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
