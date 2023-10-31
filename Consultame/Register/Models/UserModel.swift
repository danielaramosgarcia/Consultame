import Foundation

struct UserModel : Decodable {
    var user_id : Int
    var name: String
    var email : String
    var password : String
    var sexo : Int
}
