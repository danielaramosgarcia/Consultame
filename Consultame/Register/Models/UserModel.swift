import Foundation

struct SendUserModel : Decodable, Encodable {
    var user_id : Int
    var name: String
    var email : String
    var password : String
    var sexo : Int
}


// Define root struct containing the User and the token
struct ReceiveUserModel: Decodable {
    var user_id: Int
    var token: String
}

