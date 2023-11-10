//
//  Consultation.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 09/11/23.
//

import Foundation


struct ConsultationModel : Codable{
    let no: Int
    let name: String
    let duration: Int
    let date: Date
    let project: String
    let owner: String
    let status: String
}
