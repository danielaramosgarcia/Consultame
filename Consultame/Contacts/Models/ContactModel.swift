import Foundation

struct ContactModel : Identifiable, Decodable, Hashable {
    var id : Int
    var contact_name : String
    var phone_number : String?
    var email : String?
    var relationship_id : Int
    var user_id : Int
    var relationship : RelationshipModel
    
}
