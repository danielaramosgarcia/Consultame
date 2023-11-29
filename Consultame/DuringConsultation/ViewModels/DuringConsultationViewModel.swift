//
//  DuringConsultationViewModel.swift
//  Consultame
//
//  Created by Alumno on 20/11/23.
//

import Foundation
import SwiftUI


class DuringConsultationViewModel : ObservableObject {
    var messageManager: MessageManager

            init(messageManager: MessageManager) {
                self.messageManager = messageManager
            }
    
    func createMessage(message: String, is_from_user: Bool, consultation_id: Int) async -> MessageModel? {
        guard let url = URL(string: API.baseURL + "/message") else {
            print("Invalid URL")
            return nil
        }

        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "America/Mexico_City")
        let isoDate = dateFormatter.string(from: Date())

        let body = CreateMessageModel(message: message, is_from_user: is_from_user, created_at: isoDate, consultation_id: consultation_id)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Response error")
                return nil
            }

            // Decodificar la respuesta JSON
            let decodedMessage = try JSONDecoder().decode(MessageModel.self, from: data)

            // Actualizar el arreglo de mensajes en el hilo principal
            DispatchQueue.main.async {
                self.messageManager.addMessage(decodedMessage)
                
            }

            return decodedMessage
        } catch {
            print("Request failed with error: \(error)")
            return nil
        }
    } // create message

    
    
} // class


