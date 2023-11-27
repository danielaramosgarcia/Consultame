//
//  PersonalModel.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 25/11/23.
//

import Foundation

//struct Chronic_Disease : Identifiable, Decodable, Hashable {
//    var id : Int
//    var name : String
//}
//


struct PersonalModel : Identifiable, Decodable, Hashable {
    var id : Int
    var email : String
    var birth_date : String
    var phone_number : Int
    var sex_id : Int
    var height : Int
    var weight : Int
    var blood_type : Blood_typeModel
    var direction : String
}
