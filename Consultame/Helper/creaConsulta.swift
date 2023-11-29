//
//  creaConsulta.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 26/11/23.
//

import Foundation


struct CreateConsultationModel : Codable {
    let name : String
    let user_id : Int
}



class ConsultationStore: ObservableObject {

    
    func createConsultation(name: String) async throws -> Int? {
        guard let url = URL(string: API.baseURL + "/consultation") else {
            print("invalid url")
            return nil
        }

        let body = CreateConsultationModel(name: name, user_id: User.user_id)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("response error")
            return nil
        }
        
        let responseData = try JSONDecoder().decode(ConsultationModel.self, from: data)
        return responseData.id 
    }

    
}
