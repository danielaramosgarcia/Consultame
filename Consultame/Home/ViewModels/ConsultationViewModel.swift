
//
//  ConsultationData.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 09/11/23.
//

import Foundation



class ConsultationViewModel: ObservableObject {
    @Published var consultations = [ConsultationModel]()
    @Published var apiError: String?
    
    let apiService = APIService.shared
    
    
    // This Function is getting all the consultations in the DB, not only the ones from a specific user
    func getConsultations() async throws {
        // Don't forget to use your own key
        apiService.getJSON(urlString: API.baseURL + "/consultation/\(User.user_id)") { (result: Result<[ConsultationModel],APIService.APIError>) in
            switch result {
            case .success(let consultationsArr):
                DispatchQueue.main.async {
                    self.consultations = consultationsArr
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    DispatchQueue.main.async {
                        self.apiError = errorString
                        print(errorString)
                    }
                }
            }
        }
    }
    
    
    func deleteConsultations(id: Int) async throws {
        guard let url = URL(string: API.baseURL + "/consultation/" + String(id)) else {
            print("invalid url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let (_, response) = try await URLSession.shared.data(for: request)
        print(response)
        
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("response error")
            return
        }
    }
    

    
}
