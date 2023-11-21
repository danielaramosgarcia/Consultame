//
//  Consultation.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 09/11/23.
//

import Foundation


struct ConsultationModel : Codable {
    let id: Int
    let name: String?
    let description: String?
    let date: Date?
    let user_id: Int
    let doctor_id: Int?
    let hospital_id: Int?
    let created_at: Date
}

