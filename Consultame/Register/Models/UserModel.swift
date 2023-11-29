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
    var name: String
    var email: String
    var password: String? // Note: It's usually not advisable to handle passwords in the client app.
    var birthDate: Date?
    var phoneNumber: String?
    var sexId: Int?
    var createdAt: Date?
    var height: Double?
    var weight: Double?
    var bloodId: Int?

    // CodingKeys to map JSON keys to variable names in the Swift struct
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case password
        case birthDate = "birth_date"
        case phoneNumber = "phone_number"
        case sexId = "sex_id"
        case createdAt = "created_at"
        case height
        case weight
        case bloodId = "blood_id"
    }
}

// Define root struct containing the User and the token
struct ReceiveUserModel: Decodable {
    var user: baseUser
    var token: String
}

