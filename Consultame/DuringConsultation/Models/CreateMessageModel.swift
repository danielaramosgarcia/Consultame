//
//  CreateMessageModel.swift
//  Consultame
//
//  Created by Alumno on 20/11/23.
//

import Foundation

struct CreateMessageModel : Codable {
    let message : String
    let is_from_user : Bool
    let created_at : String
    let consultation_id : Int
}
