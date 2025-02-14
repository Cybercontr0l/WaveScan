import CoreData
import Foundation

class DatabaseService {
    // MARK: - Singleton Instance
    static let shared = DatabaseService()
    
    // MARK: - Core Data Container
    private let container: NSPersistentContainer
    
    // MARK: - Initializer
    init() {
        container = NSPersistentContainer(name: "DeviceDatabase")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Ошибка CoreData: \(error)")
            }
        }
    }
    
    // MARK: - Save Scan Session
    func saveScanSession(bluetoothDevices: [BluetoothDevice], lanDevices: [LANDevice]) {
        let context = container.viewContext
        let newSession = ScanSessionEntity(context: context)
        newSession.timestamp = Date()
        
        if let bluetoothData = try? JSONEncoder().encode(bluetoothDevices) {
            newSession.bluetoothDevices = bluetoothData
        }
        
        if let lanData = try? JSONEncoder().encode(lanDevices) {
            newSession.lanDevices = lanData
        }
        
        do {
            try context.save()
        } catch {
            print("Ошибка сохранения сессии сканирования: \(error)")
        }
    }
    
    // MARK: - Delete Scan Session
    func deleteScanSession(_ session: ScanSession) {
        let context = container.viewContext
        let request: NSFetchRequest<ScanSessionEntity> = ScanSessionEntity.fetchRequest()
        request.predicate = NSPredicate(format: "timestamp == %@", session.timestamp as CVarArg)
        
        do {
            let results = try context.fetch(request)
            if let entity = results.first {
                context.delete(entity)
                try context.save()
            }
        } catch {
            print("Ошибка удаления сессии: \(error)")
        }
    }
    
    // MARK: - Fetch Scan Sessions
    func fetchScanSessions() -> [ScanSession] {
        let context = container.viewContext
        let request: NSFetchRequest<ScanSessionEntity> = ScanSessionEntity.fetchRequest()
        
        do {
            let entities = try context.fetch(request)
            return entities.map { entity in
                let bluetoothDevices = try? JSONDecoder().decode([BluetoothDevice].self, from: entity.bluetoothDevices ?? Data())
                let lanDevices = try? JSONDecoder().decode([LANDevice].self, from: entity.lanDevices ?? Data())
                
                return ScanSession(
                    timestamp: entity.timestamp ?? Date(),
                    bluetoothDevices: bluetoothDevices ?? [],
                    lanDevices: lanDevices ?? []
                )
            }
        } catch {
            print("Ошибка загрузки истории сканирования: \(error)")
            return []
        }
    }
}
