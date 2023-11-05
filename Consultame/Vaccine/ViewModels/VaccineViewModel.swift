import Foundation
import SwiftUI

struct SetVaccineToUserRequestBody : Codable {
    let vaccination_date : String
    let vaccine_id : Int
}

struct DeleteVaccineFromUser : Codable {
    let vaccine_id : Int
}


class VaccineViewModel : ObservableObject {
    @Published var vaccineArr = [VaccineModel]()
    @Published var userVaccineArr = [UserVaccineModel]()
    @Published var isVaccineSetToUserSuccesful: Bool? = nil
    
    
    func getVaccines() async throws {
        guard let url = URL(string: API.baseURL + "/vaccine/available/" + String(User.user_id)) else {
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
    
    func getUserVaccines() async throws {
        guard let url = URL(string: API.baseURL + "/user/vaccine/" + String(User.user_id)) else {
            print("invalid url")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
    
        guard(response as? HTTPURLResponse)?.statusCode == 200 else {
            print("response error")
            return
        }
        
        
        let results = try JSONDecoder().decode([UserVaccineModel].self, from: data)
        
        DispatchQueue.main.async {
            self.userVaccineArr = results
        
        }
    }
    
    
    func setVaccineToUser(userId: Int, vaccineId: Int, date: Date) async throws {
        guard let url = URL(string: API.baseURL + "/user/vaccine/" + String(userId)) else {
            self.isVaccineSetToUserSuccesful = false
            print("invalid url")
            return
        }
        
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "America/Mexico_City")
        let isoDate = dateFormatter.string(from: date)
        
        let body = SetVaccineToUserRequestBody(vaccination_date: isoDate, vaccine_id: vaccineId)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            self.isVaccineSetToUserSuccesful = false
            print("response error")
            return
        }
        
        
        self.isVaccineSetToUserSuccesful = true
    }
    
    func deleteVaccineFromUser(userId: Int, vaccineId: Int) async throws {
        guard let url = URL(string: API.baseURL + "/user/vaccine/" + String(userId)) else {
            print("invalid url")
            return
        }
        
        let body = DeleteVaccineFromUser(vaccine_id: vaccineId)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("response error")
            return
        }
    }
        
    
}


