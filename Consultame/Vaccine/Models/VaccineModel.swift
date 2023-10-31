import Foundation

struct VaccineModel : Identifiable, Decodable, Hashable {
    var id : Int
    var name : String
    var image : String
    var description : String
}
