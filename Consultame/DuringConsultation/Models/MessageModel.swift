//
//  MessageModel.swift
//  Consultame
//
//  Created by Alumno on 20/11/23.
//

import Foundation

struct MessageModel: Codable, Identifiable {
    var id : Int
    var message: String
    var is_starred : Bool
    var is_from_user : Bool
    var created_at : String
    var consultation_id : Int
}

