import Foundation

struct UserVaccineModel : Decodable {
    var user_id : Int
    var vaccine_id : Int
    var vaccination_date : String
    var vaccine : VaccineModel
}
