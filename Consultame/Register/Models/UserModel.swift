import Foundation

struct SendUserModel : Decodable, Encodable {
    var user_id : Int
    var name: String
    var email : String
    var password : String
    var sexo : Int
}

struct baseUser: Codable {
    var id: Int
    var name: String?
//    var email: String?
//    var password: String? // Note: It's usually not advisable to handle passwords in the client app.
//    var birth_date: Date?
//    var phone_number: String?
//    var sex_id: Int?
//    var created_at: Date?
//    var height: Double?
//    var weight: Double?
//    var blood_id: Int?
}

// Define root struct containing the User and the token
struct ReceiveUserModel: Decodable {
    var user: baseUser
    var token: String
}

