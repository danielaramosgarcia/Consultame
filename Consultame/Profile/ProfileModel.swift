//
//  ProfileModel.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 23/11/23.
//

import Foundation

struct Blood_typeModel : Identifiable, Decodable, Hashable {
    var id : Int
    var type : String
    
}

struct ProfileModel : Identifiable, Decodable, Hashable {
    var id : Int
    var contact_name : String
    var birth_date : String
    var height : String
    var weight : String
    var blood_type : Blood_typeModel?
    var age : Int
    
}
