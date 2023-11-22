//
//  DiseaseModel.swift
//  Consultame
//
//  Created by Toño on 19/11/23.
//

import Foundation

struct DiseaseModel : Identifiable, Decodable, Hashable {
    var id : Int
    var name : String
    var description : String?
    var type_id : Int
}
