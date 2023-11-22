//
//  FamilyModel.swift
//  Consultame
//
//  Created by Toño on 19/11/23.
//

import Foundation

struct FamilyModel : Identifiable, Decodable, Hashable {
    var id : Int
    var chronic_disease_id : Int
    var diagnosis_date : String
    var relationship_id : Int
    var description : String?
    var user_id : Int
    var disease : DiseaseModel
}
