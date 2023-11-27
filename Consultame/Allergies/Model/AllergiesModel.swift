//
//  AllergiesModel.swift
//  Consultame
//
//  Created by Alumno on 17/11/23.
//

import Foundation

struct AllergiesModel : Codable{
    let no: Int
    let name: String
    let duration: Int
    let date: Date
    let project: String
    let owner: String
    let status: String
}

