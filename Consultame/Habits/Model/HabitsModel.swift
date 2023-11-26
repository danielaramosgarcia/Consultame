//
//  HabitsModel.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 25/11/23.
//

import Foundation

struct Habit : Identifiable, Decodable, Hashable {
    var id : Int
    var name : String
    var description: String?
    var type_id : Int
    
}


struct HabitsModel : Identifiable, Decodable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case user_id
        case id = "habit_id"
        case value
        case habit
    }
    var user_id : Int
    var id : Int
    var value : Int?
    var habit : Habit

}
