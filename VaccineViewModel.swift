import Foundation
import SwiftUI

struct SetVaccineToUserRequestBody : Codable {
    let vaccination_date : Date
    let vaccine_id : Int
}


class VaccineViewModel : ObservableObject {
    @Published var vaccineArr = [VaccineModel]()
    @Published var isVaccineSetToUserSuccesful: Bool = false
    
    
    func getVaccines() async throws {
        guard let url = URL(string: API.baseURL + "/vaccine/available/" + String(DUMMY.user_id)) else {
            print("invalid url")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard(response as? HTTPURLResponse)?.statusCode == 200 else {
            print("response error")
            return
        }
        
        let results = try JSONDecoder().decode([VaccineModel].self, from: data)
        
        DispatchQueue.main.async {
            self.vaccineArr = results
        
        }
        
    }
    
    func setVaccineToUser(userId: Int, vaccineId: Int, date: Date) async throws {
        guard let url = URL(string: API.baseURL + "/user/vaccine/" + String(userId)) else {
            print("invalid url")
            return
        }
        
        let body = SetVaccineToUserRequestBody(vaccination_date: date, vaccine_id: vaccineId)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("response error")
            return
        }
        
        
        self.isVaccineSetToUserSuccesful = true
        
    }
    
}


