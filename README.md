# **Wave Scan - Bluetooth & LAN Device Scanner**

**Wave Scan** is an iOS app that scans available Bluetooth and LAN devices, displaying them in real-time. It allows users to track the status of Bluetooth and Wi-Fi connections and save the history of all detected devices.

### Key Features:
- Scan for available **Bluetooth devices**.
- Scan for devices on the local **LAN network**.
- **Automatic saving** of discovered devices to the history.
- Display **Bluetooth** and **Wi-Fi** connection status.
- **Animations** to visualize the scanning process.

---

## 📱 **How to Use**

1. **Launch the app** on your device.
2. The main screen will display the **Bluetooth** and **Wi-Fi** status:
   - **Bluetooth**: If Bluetooth is enabled, a green icon will appear.
   - **Wi-Fi**: If your device is connected to Wi-Fi, a green icon will appear.
3. To start scanning, **tap the screen** to initiate the process.
   - The app will show an animation while **Bluetooth** and **LAN** scanning is active.
   - To stop scanning, tap the screen again or wait 15 sec.
4. All discovered devices will be automatically **saved to the history**.

---

## 🔧 **Setting Up & Running the Project**

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/WaveScan.git
2. **Open the project in Xcode:**
Open WaveScan.xcodeproj or WaveScan.xcworkspace in Xcode.
3. **Install Dependencies (if any):**
Make sure to install any required dependencies using **CocoaPods**, as specified in the project.
4. **Run the app:**
Select your target device or simulator in Xcode.
Click the **Run** button (or press Cmd + R) to build and run the app.

## 📚 Libraries and Frameworks Used
**CoreBluetooth:** For scanning Bluetooth devices.
**Network:** For monitoring Wi-Fi connection status.
**Lottie:** For displaying animation during the scanning process.
**MMLanScan:** For LAN device scanning.
