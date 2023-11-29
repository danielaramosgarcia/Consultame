//
//  Consultation.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 09/11/23.
//

import Foundation

struct ConsultationModel: Codable, Identifiable {
    let id: Int?
    let name: String? // Para crear una consulta necesito esto
    let description: String?
    let date: Date?
    let user_id: Int? // Para crear una consulta necesito esto
    let doctor_id: Int?
    let hospital_id: Int?
    let created_at: String?
    
    
    var formatted_date: String? {
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "MMM dd, yyyy"

        guard let dateString = self.created_at else { return "N/A" }
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let date = isoFormatter.date(from: dateString) else {
            let date = Date() // This gets the current date
            let dateString = displayFormatter.string(from: date)
            return dateString
        }
        
        return displayFormatter.string(from: date)
    }
    var messages: MessageModel?
}


