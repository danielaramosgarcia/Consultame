//
//  AllergiesModel.swift
//  Consultame
//
//  Created by Alumno on 17/11/23.
//

import Foundation

struct Allergy : Identifiable, Decodable, Hashable{
    var id: Int
    var name: String
    var description: String
    var allergy_type_id: Int
}

struct AllergiesModel: Identifiable, Decodable, Hashable{
    private enum CodingKeys: String, CodingKey {
        case id = "allergy_id"
        case user_id
        case allergy
    }
    var id: Int
    var user_id: Int
    var allergy: Allergy
}
