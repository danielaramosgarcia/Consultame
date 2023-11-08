import Foundation
import SocketIO

class WebSocketManager: ObservableObject {
    private var manager: SocketManager
    private var socket: SocketIOClient
    @Published var messages = [(id: UUID, msg: String)]()
    @Published var roomKey: String? = nil
    
    init() {
        self.manager = SocketManager(socketURL: URL(string: API.baseURL)!, config: [.log(true), .compress])
        self.socket = manager.defaultSocket
        
        setupSocketEvents()
        socket.connect()
    }
    
    private func setupSocketEvents() {
        socket.on(clientEvent: .connect) { [weak self] (data, ack) in
            print("Connected")
            self?.socket.emit("IOS Connection")
        }
        
        // get room id
        socket.on("Room Creation") { [weak self] (data, ack) in
            if let data = data[0] as? [String: Any],
               let roomKey = data["roomKey"] as? String {
                DispatchQueue.main.async {
                    self?.roomKey = roomKey
                    print("Room key received: \(roomKey)")
                }
            }
        }
    } // setupSocketEvents
    
    func sendMessage(_ message: String) {
        socket.emit("iOS Client Port", message)
    }
    
    deinit {
        socket.disconnect()
    }
}
