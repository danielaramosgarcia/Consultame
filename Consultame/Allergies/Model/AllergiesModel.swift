//
//  AllergiesModel.swift
//  Consultame
//
//  Created by Alumno on 17/11/23.
//

import Foundation

struct AllergiesModel : Identifiable, Decodable, Hashable{
    var id: Int
    var name: String
    var allergy_type_id: Int
    var description: String
}

