//
//  PersonalModel.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 25/11/23.
//

import Foundation

struct DireccionModel : Identifiable, Decodable, Hashable {
    var id : Int
    var street_line_1 : String
    var street_line_2 : String?
    var city : String?
    var state_province_region : String
    var postal_code : String?
    var country : String
    var additional_info : String?
}

struct SexModel : Identifiable, Decodable, Hashable {
    var id : Int
    var type : String
}


struct PersonalModel : Identifiable, Decodable, Hashable {
    var id : Int
    var email : String
    var name : String
    var birth_date : String
    var phone_number : String
    var sex : SexModel
    var height : String
    var weight : String
    var blood_type : Blood_typeModel
    var addresses : [DireccionModel]
    
}
