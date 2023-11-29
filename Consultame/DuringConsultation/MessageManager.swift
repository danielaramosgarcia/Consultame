//
//  MessageManager.swift
//  Consultame
//
//  Created by Alumno on 28/11/23.
//

import Foundation


class MessageManager: ObservableObject {
    @Published var messages = [MessageModel]()

    func addMessage(_ message: MessageModel) {
        DispatchQueue.main.async {
            self.messages.append(message)
        }
    }

    func updateMessage(id: Int, newContent: String) {
        if let index = messages.firstIndex(where: { $0.id == id }) {
            DispatchQueue.main.async {
                self.messages[index].message = newContent
            }
        }
    }
}
