import Foundation
import SwiftUI

struct CreateConsultationModel : Codable {
    let name: String
}

class NewConsultationViewModel : ObservableObject {
    
    func createConsultation(name: String) async throws {
        guard let url = URL(string: API.baseURL + "/consultation") else {
            print("invalid url")
            return
        }
        
        
        let body = CreateConsultationModel(name: name)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("response error")
            return
        }
        
        print(response)
    }
    
  
        
    
}


