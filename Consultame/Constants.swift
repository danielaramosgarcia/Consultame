import Foundation

struct API {
    static let baseURL = "http://localhost:3000"
//    static let baseURL = "https://consultame-api.onrender.com"
    static let wsURL = "ws://consultame-api.onrender.com"
}



struct User: Decodable{
    static var user_id = 123
    static var user_name = "Jhon Doe"
    static var JWT = "Faik"
    static var gender = "Hombre"
}

struct msgConsultation {
    static var consultationID = -1
}

struct Utils {
    static let colors = ["purp1", "purp2", "purp3", "purp4", "purp5", "purp6", "purp7", "purp8", "blue1", "blue2", "blue3", "blue4", "blue5", "blue6", "blue7", "blue8"]
}
