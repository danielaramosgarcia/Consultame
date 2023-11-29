//
//  AllergiesViewModel.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 26/11/23.
//

import Foundation

struct CreateAllergyRequestBody : Codable {
    let user_id : Int
    let allergy_id : Int
}

class AllergiesViewModel : ObservableObject {
    @Published var allergies = [AllergiesModel]()
    @Published var Allalergies = [Allergy]()
    @Published var allergyCreatedSuccessfully: Bool? = nil
    

    
    
    var drugAllergies: [AllergiesModel] {
        return allergies.filter { $0.allergy.allergy_type_id == 2 }
    }

    var foodAllergies: [AllergiesModel] {
        return allergies.filter { $0.allergy.allergy_type_id == 1 }
    }

    var otherAllergies: [AllergiesModel] {
        return allergies.filter { $0.allergy.allergy_type_id != 1 && $0.allergy.allergy_type_id != 2 }
    }
    
    let apiService = APIService.shared

    func getAllergy() async throws {
        let apiService = APIService.shared
        apiService.getJSON(urlString: API.baseURL + "/user_allergy/" + String(User.user_id)) { (result: Result<[AllergiesModel],APIService.APIError>) in
            print(result)
            switch result {
            case .success(let alergies):
                DispatchQueue.main.async {
                    self.allergies = alergies
                    print(alergies)
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    print(errorString)
                }
            }
        }
        
    }
    
    func getAllAllergies() async throws {
        let apiService = APIService.shared
        apiService.getJSON(urlString: API.baseURL + "/allergy") { (result: Result<[Allergy],APIService.APIError>) in
            switch result {
            case .success(let alergies):
                DispatchQueue.main.async {
                    self.Allalergies = alergies
                    print(alergies)
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    print(errorString)
                }
            }
        }
        
    }
    
    func postAllergyToUser(allergy_id: Int) async throws {
        guard let url = URL(string: API.baseURL + "/user_allergy/" ) else {
            self.allergyCreatedSuccessfully = false
            print("invalid url")
            return
        }
        
        let body = CreateAllergyRequestBody(user_id: User.user_id,allergy_id: allergy_id)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            self.allergyCreatedSuccessfully = false
            print("response error")
            return
        }
        
        
        self.allergyCreatedSuccessfully = true
    }
    
    
}
