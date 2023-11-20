import Foundation
import SocketIO

class WebSocketManager: ObservableObject {
    private var manager: SocketManager
    private var socket: SocketIOClient
    @Published var messages = [(id: UUID, msg: String)]()
    @Published var roomKey: String? = nil
    @Published var saveMessages: Bool? = nil
    
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
        } // room creation
        
        socket.on("Save Messages Confirmation") { [weak self] (data, ack) in
            if let saveMessages = data[0] as? Bool {
                if(saveMessages) {
                    print("El doctor aprobo que los mensajes se guardaran en la base de datos")
                } else {
                    print("El doctor NO aprobo que los mensajes se guardaran en la base de datos")
                }
                DispatchQueue.main.async {
                    self?.saveMessages = saveMessages
                }
            }
        } // save messages confirmation
        
        
            
    } // setupSocketEvents
    
    func sendCompleteMessage(_ message: MessageModel) {
        let messageDict: [String: Any] = [
                "id": message.id,
                "message": message.message,
                "is_starred" : message.is_starred,
                "is_from_user": message.is_from_user,
                "created_at" : message.created_at,
                "consultation_id" : message.consultation_id
            ]
        print(messageDict)
        
        socket.emit("Send Complete Message", messageDict)
    }
    
    func sendWord(_ word: String) {
        socket.emit("Send Word to Web", word)
    }
    
    func sendMessageBeingWrittenByUser(_ message: String) {
        socket.emit("Send Message Being Written by User", message)
    }
    
    
    deinit {
        socket.disconnect()
    }
}