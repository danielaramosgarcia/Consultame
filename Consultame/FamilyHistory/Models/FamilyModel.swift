//
//  FamilyModel.swift
//  Consultame
//
//  Created by Toño on 19/11/23.
//

import Foundation

struct Chronic_Disease : Identifiable, Decodable, Hashable {
    var id : Int
    var name : String
}

struct Relationship : Identifiable, Decodable, Hashable {
    var id : Int
    var type : String
}


struct FamilyModel : Identifiable, Decodable, Hashable {
    var id : Int
    var diagnosis_date : String
    var description : String?
    var chronic_disease : Chronic_Disease
    var relationship : Relationship
}
