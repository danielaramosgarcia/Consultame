import Foundation

struct RelationshipModel : Identifiable, Decodable, Hashable {
    var id : Int
    var type : String
    var description : String?
    var is_relative : Bool
}
