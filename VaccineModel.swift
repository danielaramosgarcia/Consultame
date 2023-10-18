import Foundation

struct VaccineModel : Identifiable, Decodable {
    var id : Int
    var name : String
    var image : String
    var description : String
}
